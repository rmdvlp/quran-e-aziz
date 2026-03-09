import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../utils/apptheme.dart';
import '../../../utils/colors.dart';
import '../../../utils/global_class.dart';
import '../../../utils/more_screens_appBar.dart';

class AddParahScreen extends StatefulWidget {
  const AddParahScreen({super.key});

  @override
  State<AddParahScreen> createState() => _AddParahScreenState();
}

class _AddParahScreenState extends State<AddParahScreen> {
  final TextEditingController _nameController = TextEditingController();
  final ImagePicker _imagePicker = ImagePicker();
  final List<XFile> _selectedImages = [];

  bool _isUploading = false;

  String _buildSafeDocumentId(String input) {
    final trimmed = input.trim();
    final noSlashes = trimmed.replaceAll(RegExp(r'[\\/]'), '-');
    final noSpecial = noSlashes.replaceAll(RegExp(r'[\[\]#?]'), '');
    final normalizedSpace = noSpecial.replaceAll(RegExp(r'\s+'), ' ');
    return normalizedSpace;
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _pickImages() async {
    try {
      final picked = await _imagePicker.pickMultiImage(imageQuality: 85);
      if (picked.isEmpty) {
        return;
      }

      setState(() {
        if (_selectedImages.length >= 60) {
          return;
        }
        final availableSlots = 60 - _selectedImages.length;
        _selectedImages.addAll(picked.take(availableSlots));
      });
    } catch (error) {
      _showMessage('Image selection failed. Please try again.');
    }
  }

  Future<void> _uploadParah() async {
    final parahName = _nameController.text.trim();
    final safeDocumentId = _buildSafeDocumentId(parahName);

    if (parahName.isEmpty) {
      _showMessage('Please enter Parah name.');
      return;
    }

    if (safeDocumentId.isEmpty) {
      _showMessage('Parah name contains invalid characters.');
      return;
    }

    if (_selectedImages.isEmpty) {
      _showMessage('Please select Parah images.');
      return;
    }

    setState(() {
      _isUploading = true;
    });

    try {
      final docRef =
          GlobalClass.fireBaseDB.collection('quran-e-aziz').doc(safeDocumentId);
      final Map<String, dynamic> payload = {
        'name': parahName,
        'documentId': safeDocumentId,
        'timestamp': DateTime.now().millisecondsSinceEpoch,
      };

      // Store images as base64 strings in Firestore (workaround for Spark plan)
      // Note: This has a ~1MB Firestore document limit. For production,
      // upgrade Firebase to Blaze plan and use Firebase Storage instead.
      for (int i = 0; i < _selectedImages.length; i++) {
        final imageNumber = i + 1;
        final imageKey = 'image-$imageNumber';

        final imageFile = File(_selectedImages[i].path);
        final imageBytes = await imageFile.readAsBytes();

        // Check file size (warn if >100KB per image)
        if (imageBytes.length > 100 * 1024) {
          _showMessage(
              'Warning: image-$imageNumber is large (${(imageBytes.length / 1024).toStringAsFixed(0)}KB). Upload may fail.');
        }

        final base64Image = base64Encode(imageBytes);
        payload[imageKey] = base64Image;
      }

      await docRef.set(payload, SetOptions(merge: true));

      if (!mounted) {
        return;
      }

      _showMessage('Parah uploaded successfully (images stored in Firestore).');
      Navigator.pop(context, true);
    } on FirebaseException catch (error) {
      if (error.code == 'permission-denied') {
        _showMessage(
            'Upload denied by Firebase rules. Please sign in or update Firebase rules.');
      } else if (error.code == 'unauthenticated') {
        _showMessage('Please login first, then upload Parah.');
      } else {
        _showMessage('Upload failed: ${error.message ?? error.code}');
      }
    } catch (error) {
      _showMessage(
          'Upload failed. Please try again. (${error.toString().split('\n').first})');
    } finally {
      if (mounted) {
        setState(() {
          _isUploading = false;
        });
      }
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MoreScreensAppBar(
        color: AppColors.white,
        text: 'Add Parah',
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Parah Name',
                hintText: 'Enter Parah name',
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.mainAppColor,
                    ),
                    onPressed: _isUploading ? null : _pickImages,
                    icon: const Icon(Icons.image, color: AppColors.white),
                    label: const Text(
                      'Select Images',
                      style: TextStyle(color: AppColors.white),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Selected: ${_selectedImages.length}/60',
                style: AppTheme.textTheme.bodySmall,
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: _selectedImages.isEmpty
                  ? const Center(child: Text('No images selected yet.'))
                  : ListView.builder(
                      itemCount: _selectedImages.length,
                      itemBuilder: (context, index) {
                        final imageLabel = 'image-${index + 1}';
                        return ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: SizedBox(
                            height: 50,
                            width: 50,
                            child: Image.file(
                              File(_selectedImages[index].path),
                              fit: BoxFit.cover,
                            ),
                          ),
                          title: Text(imageLabel),
                          subtitle: Text(_selectedImages[index].name),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete_outline),
                            onPressed: _isUploading
                                ? null
                                : () {
                                    setState(() {
                                      _selectedImages.removeAt(index);
                                    });
                                  },
                          ),
                        );
                      },
                    ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.mainAppColor,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: _isUploading ? null : _uploadParah,
                child: _isUploading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: AppColors.white,
                        ),
                      )
                    : const Text(
                        'Upload Parah',
                        style: TextStyle(color: AppColors.white),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
