import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:quran_aziz/utils/images.dart';
import 'package:smooth_compass/utils/src/compass_ui.dart';

import '../../../utils/colors.dart';
import '../../../utils/more_screens_appBar.dart';

class QiblahDirectionScreen extends StatefulWidget {
  const QiblahDirectionScreen({super.key});
  // Flutter 3.19.2 • channel stable • https://github.com/flutter/flutter.gitflutter
  // Framework • revision 7482962148 (7 months ago) • 2024-02-27 16:51:22 -0500
  // Engine • revision 04817c99c9
  // Tools • Dart 3.3.0 • DevTools 2.31.1

  //new here after upadate flutter
//  [✓] Android toolchain - develop for Android devices (Android SDK version 33.0.0)
//  [✓] Xcode - develop for iOS and macOS (Xcode 15.4)

  @override
  State<QiblahDirectionScreen> createState() => _QiblahDirectionScreenState();
}

class _QiblahDirectionScreenState extends State<QiblahDirectionScreen> {
  bool _isChecking = true;
  bool _hasLocationPermission = false;
  bool _isLocationServiceEnabled = true;
  String _statusMessage = '';

  @override
  void initState() {
    _initializeQibla();
    super.initState();
  }

  Future<void> _initializeQibla() async {
    setState(() {
      _isChecking = true;
      _statusMessage = '';
    });

    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        _isLocationServiceEnabled = false;
        _hasLocationPermission = false;
        _isChecking = false;
        _statusMessage = 'Please enable location services to use Qibla.';
      });
      return;
    }

    PermissionStatus status = await Permission.locationWhenInUse.status;
    if (!status.isGranted && !status.isLimited) {
      status = await Permission.locationWhenInUse.request();
    }

    if (status.isGranted || status.isLimited) {
      setState(() {
        _isLocationServiceEnabled = true;
        _hasLocationPermission = true;
        _isChecking = false;
        _statusMessage = '';
      });
      return;
    }

    setState(() {
      _isLocationServiceEnabled = true;
      _hasLocationPermission = false;
      _isChecking = false;
      _statusMessage = status.isPermanentlyDenied
          ? 'Location permission is permanently denied. Open settings and allow location to use Qibla.'
          : 'Location permission is required for Qibla direction.';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MoreScreensAppBar(
        color: AppColors.white,
        text: "Qibla Screen",
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isChecking) {
      return const Center(child: CircularProgressIndicator());
    }

    if (!_isLocationServiceEnabled) {
      return _buildStatusView(
        message: _statusMessage,
        primaryButtonText: 'Open Location Settings',
        onPrimaryTap: () async {
          await Geolocator.openLocationSettings();
          _initializeQibla();
        },
      );
    }

    if (!_hasLocationPermission) {
      return _buildStatusView(
        message: _statusMessage,
        primaryButtonText: 'Allow Permission',
        onPrimaryTap: () async {
          final status = await Permission.locationWhenInUse.request();
          if (status.isPermanentlyDenied) {
            await openAppSettings();
          }
          _initializeQibla();
        },
      );
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: SmoothCompass(
            height: 200,
            width: 200,
            isQiblahCompass: true,
            compassBuilder: (context, snapshot, child) {
              final compassTurns = snapshot?.data?.turns ?? 0;
              final qiblaTurns = (snapshot?.data?.qiblahOffset ?? 0) / 360;

              return AnimatedRotation(
                turns: compassTurns,
                duration: const Duration(milliseconds: 300),
                child: SizedBox(
                  height: 300,
                  width: 300,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Image.asset(
                          Images.compassImage,
                          fit: BoxFit.contain,
                        ),
                      ),
                      Positioned(
                        top: 20,
                        left: 0,
                        right: 0,
                        bottom: 20,
                        child: AnimatedRotation(
                          turns: qiblaTurns,
                          duration: const Duration(milliseconds: 300),
                          child: Image.asset(
                            Images.qiblaNedleImage,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'If direction looks unstable, move your phone in a figure-8 motion to calibrate compass sensors.',
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColors.mainAppColor),
          ),
        ),
      ],
    );
  }

  Widget _buildStatusView({
    required String message,
    required String primaryButtonText,
    required void Function() onPrimaryTap,
  }) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColors.mainAppColor),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: onPrimaryTap,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.mainAppColor,
              ),
              child: Text(
                primaryButtonText,
                style: const TextStyle(color: AppColors.white),
              ),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: _initializeQibla,
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}
