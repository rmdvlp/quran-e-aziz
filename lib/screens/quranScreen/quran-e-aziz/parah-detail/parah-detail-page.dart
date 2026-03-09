import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:quran_aziz/utils/more_screens_appBar.dart';
import 'package:quran_aziz/widgets/loader.dart';

import '../../../../utils/colors.dart';
import '../../../../utils/global_class.dart';

class ParahDetailScreen extends StatefulWidget {
  final String documentId;
  final String? parahTitle;

  const ParahDetailScreen(
      {super.key, required this.documentId, this.parahTitle});

  @override
  State<ParahDetailScreen> createState() => _ParahDetailScreenState();
}

class _ParahDetailScreenState extends State<ParahDetailScreen> {
  final List<String> _allPages = [];
  final List<String> pagesList = [];
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = true;
  bool _isLoadingMore = false;
  bool _hasMore = true;

  static const int _pageBatchSize = 5;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    fetchDocumentDetails(widget.documentId);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients || _isLoadingMore || !_hasMore) {
      return;
    }

    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (currentScroll >= maxScroll - 200) {
      _loadNextBatch();
    }
  }

  void _loadNextBatch() {
    if (_isLoadingMore || !_hasMore) {
      return;
    }

    setState(() {
      _isLoadingMore = true;
    });

    final start = pagesList.length;
    final end = (start + _pageBatchSize) > _allPages.length
        ? _allPages.length
        : (start + _pageBatchSize);

    if (start >= end) {
      setState(() {
        _hasMore = false;
        _isLoadingMore = false;
      });
      return;
    }

    pagesList.addAll(_allPages.sublist(start, end));

    setState(() {
      _hasMore = pagesList.length < _allPages.length;
      _isLoadingMore = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MoreScreensAppBar(
        color: AppColors.white,
        text: widget.parahTitle ?? widget.documentId,
      ),
      body: _isLoading
          ? const Loader()
          : ListView.builder(
              controller: _scrollController,
              itemCount: pagesList.length,
              itemBuilder: (context, index) {
                return InteractiveViewer(
                    panEnabled: true,
                    boundaryMargin: const EdgeInsets.all(20),
                    minScale: 0.5,
                    maxScale: 4.0,
                    child: _buildImageWidget(pagesList[index]));
              }),
    );
  }

  Widget _buildImageWidget(String imageData) {
    // Check if it's a base64 string or URL
    if (imageData.startsWith('http://') || imageData.startsWith('https://')) {
      return Image.network(imageData);
    } else {
      // Decode base64
      try {
        final Uint8List bytes = base64Decode(imageData);
        return Image.memory(bytes);
      } catch (e) {
        return const Center(
          child: Text('Failed to load image'),
        );
      }
    }
  }

  Future<void> fetchDocumentDetails(String documentId) async {
    List<MapEntry<String, dynamic>> tempImageList = [];

    var docSnapshot = await GlobalClass.fireBaseDB
        .collection('quran-e-aziz')
        .doc(documentId)
        .get();
    Map data = docSnapshot.data()!;
    data.forEach((key, value) {
      if (key.startsWith('image-')) {
        tempImageList.add(MapEntry(key, value));
      }
    });

    tempImageList.sort((a, b) {
      int aNumber = int.parse(a.key.replaceAll(RegExp(r'[^0-9]'), ''));
      int bNumber = int.parse(b.key.replaceAll(RegExp(r'[^0-9]'), ''));
      return aNumber.compareTo(bNumber);
    });

    setState(() {
      _allPages.clear();
      pagesList.clear();
      for (var entry in tempImageList) {
        _allPages.add(entry.value.toString());
      }
      _isLoading = false;
      _hasMore = true;
    });

    _loadNextBatch();
  }
}
