import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/global_class.dart';
import 'home_events.dart';
import 'home_states.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    // Register event handlers
    on<LoadImagesEvent>(_onLoadImages);
    on<RefreshImagesEvent>(_onRefreshImages);
  }

  // Handler for LoadImagesEvent
  Future<void> _onLoadImages(LoadImagesEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoading());
    List<String>? cachedImages = await _loadCachedData();
    if (cachedImages != null) {
      emit(HomeLoaded(cachedImages));  // Load from cache
    } else {
      await _fetchAndEmitImages(emit);
    }
  }

  // Handler for RefreshImagesEvent
  Future<void> _onRefreshImages(
      RefreshImagesEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoading());
    await _fetchAndEmitImages(emit);  // Force reload
  }

  // Load cached data from SharedPreferences
  Future<List<String>?> _loadCachedData() async {
    final prefs = await SharedPreferences.getInstance();
    String? cachedData = prefs.getString('imageUrls');
    if (cachedData != null) {
      return List<String>.from(json.decode(cachedData));
    }
    return null;
  }

  // Fetch data from Firebase and emit the new state
  Future<void> _fetchAndEmitImages(Emitter<HomeState> emit) async {
    try {
      var db = await GlobalClass.fireBaseDB
          .collection('quotesImages')
          .doc('mHSlN67s3G910ChbUC9N')
          .get();

      Map data = db.data()!;
      List<String> imageUrls = [];

      for (var entry in data.entries) {
        if (entry.key.startsWith('image')) {
          imageUrls.add(entry.value);
        }
      }

      await _cacheData(imageUrls);  // Cache the data
      emit(HomeLoaded(imageUrls));
    } catch (e) {
      emit(HomeError("Failed to load images. Please check your connection."));
    }
  }

  // Cache data in SharedPreferences
  Future<void> _cacheData(List<String> imageUrls) async {
    final prefs = await SharedPreferences.getInstance();
    String encodedData = json.encode(imageUrls);
    await prefs.setString('imageUrls', encodedData);
  }
}
