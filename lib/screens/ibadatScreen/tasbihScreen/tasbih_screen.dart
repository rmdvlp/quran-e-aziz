import 'package:flutter/material.dart';

import '../../../utils/apptheme.dart';
import '../../../utils/colors.dart';
import '../../../utils/more_screens_appBar.dart';

class TasbihScreen extends StatefulWidget {
  const TasbihScreen({super.key});

  @override
  State<TasbihScreen> createState() => _TasbihScreenState();
}

class _TasbihScreenState extends State<TasbihScreen> {
  final List<int> _tasbihOptions = [33, 100, 1000];
  int? _selectedTarget;
  int _currentCount = 0;
  bool _isCompleted = false;

  void _selectTasbih(int target) {
    setState(() {
      _selectedTarget = target;
      _currentCount = 0;
      _isCompleted = false;
    });
  }

  void _handleTapCount() {
    if (_selectedTarget == null || _isCompleted) {
      return;
    }

    setState(() {
      _currentCount++;
      if (_currentCount >= _selectedTarget!) {
        _isCompleted = true;
      }
    });
  }

  void _resetSelection() {
    setState(() {
      _selectedTarget = null;
      _currentCount = 0;
      _isCompleted = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MoreScreensAppBar(
        text: 'Tasbih',
        color: AppColors.white,
      ),
      body:
          _selectedTarget == null ? _buildSelectionView() : _buildCounterView(),
    );
  }

  Widget _buildSelectionView() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Select Tasbih Size',
            style: AppTheme.textTheme.displayLarge?.copyWith(fontSize: 28),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 30),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            alignment: WrapAlignment.center,
            children: _tasbihOptions
                .map(
                  (option) => ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.mainAppColor,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 28,
                        vertical: 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    onPressed: () => _selectTasbih(option),
                    child: Text(
                      option.toString(),
                      style: AppTheme.textTheme.titleMedium,
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildCounterView() {
    return GestureDetector(
      onTap: _handleTapCount,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: double.infinity,
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Target: $_selectedTarget',
                style: AppTheme.textTheme.labelLarge,
              ),
              const SizedBox(height: 10),
              Text(
                '$_currentCount',
                style: AppTheme.textTheme.displayLarge?.copyWith(fontSize: 72),
              ),
              const SizedBox(height: 10),
              Text(
                _isCompleted
                    ? 'Tasbih is complete'
                    : 'Tap anywhere on screen to count',
                style: AppTheme.textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              if (_isCompleted)
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.mainAppColor,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 12,
                    ),
                  ),
                  onPressed: _resetSelection,
                  child: Text(
                    'Select New Tasbih',
                    style: AppTheme.textTheme.titleMedium,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
