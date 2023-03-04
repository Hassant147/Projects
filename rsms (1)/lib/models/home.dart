import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Home with ChangeNotifier {
  final String id;
  final String imageurl;
  final String adpostedby;
  final int rent;
  final bool furnished;
  final int bedrooms;
  final int bathrooms;
  final int storeys;
  final String areaUnit;
  final String location;
  final String features;
  final String adTitle;
  final String description;
  bool isFavourite;

  Home({
    required this.id,
    this.isFavourite = false,
    required this.imageurl,
    required this.adpostedby,
    required this.rent,
    required this.furnished,
    required this.bedrooms,
    required this.bathrooms,
    required this.storeys,
    required this.areaUnit,
    required this.location,
    required this.features,
    required this.adTitle,
    required this.description,
  });

  void _setFavValue(bool newValue) {
    isFavourite = newValue;
    notifyListeners();
  }

  Future<void> toggleFavoriteStatus() async {
    final oldStatus = isFavourite;
    isFavourite = !isFavourite;
    notifyListeners();
    final url = 'https://rsms-3e512-default-rtdb.firebaseio.com/homes/$id.json';
    try {
      final response = await http.patch(
        url as Uri,
        body: json.encode({
          'isFavorite': isFavourite,
        }),
      );
      if (response.statusCode >= 400) {
        _setFavValue(oldStatus);
      }
    } catch (error) {
      _setFavValue(oldStatus);
    }
  }
}
