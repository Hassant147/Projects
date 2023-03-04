//used this library to convert Map into Jason
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
//HTTP library to do CRUDE function
import 'package:http/http.dart' as http;

import 'package:rsms/models/home.dart';

//ChangeNotifier ki class ko mix kiya hai hmne Home ki class ke sath
//Kuke ChangeNotifier ka method hume use krna tha which is notifyListeners();

//ChangeNotifier ki class ko Mixin ke through hmne inherit kiya hai Homes me
// ye jb hm isi class me data edit kre gey tb he trigger hogi ye Mixin class
//else agr kahi or se edit hoga data by using pointers to phr ye trigger ni hogi.
class Homes with ChangeNotifier {
  //notifyListeners(); ko use islie kr rhe hum kuke is se pta chale ga jo bhi data me change aya hai.
  // wo change sb listeners ko pas jayega or jo jo listener widgets se attach hain jo is data se affect hote hain
  // un sb widgets ko iska pta chalega JO CHANGE AYA.
  //and then phir wohi widgets rebuild honge only. Not the whole app.

// i made items as private data member of this class.
//reason nechay given hai.

  List<Home> _items = [
    Home(
      id: '0',
      imageurl:
          'http://www.mydomaine.com/thmb/dke2LC6lH21Pvqwd2lI6AIutnDY=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/SuCasaDesign-Modern-9335be77ca0446c7883c5cf8d974e47c.jpg',
      adpostedby: '',
      rent: 30000,
      furnished: false,
      bedrooms: 3,
      bathrooms: 2,
      storeys: 1,
      areaUnit: '7 Marla',
      location: "DHA",
      features: 's',
      adTitle: '7 Marla House for rent',
      description: 'Nice home with clean water',
      isFavourite: false,
    ),
    Home(
      id: '1',
      imageurl:
          'http://cdn.pixabay.com/photo/2016/06/24/10/47/house-1477041__340.jpg',
      adpostedby: '',
      rent: 50000,
      furnished: false,
      bedrooms: 3,
      bathrooms: 2,
      storeys: 1,
      areaUnit: '7 Marla',
      location: "DHA",
      features: 's',
      adTitle: '7 Marla House for rent',
      description: 'Nice home with clean water',
      isFavourite: false,
    ),
  ];
  List<Home> get items {
    // if (_showFavoritesOnly) {
    //   return _items.where((prodItem) => prodItem.isFavorite).toList();
    // }
    return [..._items];
  }

  List<Home> get favoriteItems {
    return _items.where((home) => home.isFavourite).toList();
  }

  Home findById(String id) {
    return _items.firstWhere((hom) => hom.id == id);
  }

  Future<void> fetchAndSetHomes() async {
    const url = 'https://rsms-3e512-default-rtdb.firebaseio.com/homes.json';
    try {
      final response = await http.get(url as Uri);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }
      final List<Home> loadedHomes = [];
      extractedData.forEach((homeid, homeData) {
        loadedHomes.add(Home(
            id: homeid,
            description: homeData['description'],
            adpostedby: homeData['adpostedby'],
            adTitle: homeData['adTitle'],
            areaUnit: homeData['areaUnit'],
            bathrooms: homeData['bathrooms'],
            features: homeData['features'],
            bedrooms: homeData['bedrooms'],
            furnished: homeData['furnished'],
            imageurl: homeData['imageurl'],
            location: homeData['location'],
            rent: homeData['rent'],
            storeys: homeData['storeys'],
            isFavourite: homeData['isFavourite']));
      });
      _items = loadedHomes;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> addHome(Home home) async {
    print(home.adTitle);
    final url = 'http://rsms-3e512-default-rtdb.firebaseio.com/homes.json';

    try {
      final response = await http.post(
        Uri.parse(url),
        body: json.encode({
          'isFavourite': home.isFavourite,
          'description': home.description,
          'adpostedby': home.adpostedby,
          'adTitle': home.adTitle,
          'areaUnit': home.areaUnit,
          'bathrooms': home.bathrooms,
          'features': home.features,
          'bedrooms': home.bedrooms,
          'furnished': home.furnished,
          'imageurl': home.imageurl,
          'location': home.location,
          'rent': home.rent,
          'storeys': home.storeys,
        }),
      );
      final newHome = Home(
        adpostedby: home.adpostedby,
        id: json.decode(response.body)['name'],
        adTitle: home.adTitle,
        areaUnit: home.areaUnit,
        bathrooms: home.bathrooms,
        features: home.features,
        bedrooms: home.bedrooms,
        furnished: home.furnished,
        imageurl: home.imageurl,
        location: home.location,
        rent: home.rent,
        storeys: home.storeys,
        description: home.description,
      );
      _items.add(newHome);
      // _items.insert(0, newHome); // at the start of the list
      notifyListeners();
    } catch (error) {
      print('error:$error');
      throw error;
    }
  }

  Future<void> updateHome(String id, Home newHome) async {
    final homeIndex = _items.indexWhere((hom) => hom.id == id);
    if (homeIndex >= 0) {
      final url = 'rsms-3e512-default-rtdb.firebaseio.com/homes/$id.json';
      await http.patch(url as Uri,
          body: json.encode({
            'description': newHome.description,
            'adpostedby': newHome.adpostedby,
            'adTitle': newHome.adTitle,
            'areaUnit': newHome.areaUnit,
            'bathrooms': newHome.bathrooms,
            'features': newHome.features,
            'bedrooms': newHome.bedrooms,
            'furnished': newHome.furnished,
            'imageurl': newHome.imageurl,
            'location': newHome.location,
            'rent': newHome.rent,
            'storeys': newHome.storeys,
          }));
      _items[homeIndex] = newHome;
      notifyListeners();
    } else {
      // print('...');
    }
  }

  Future<void> deleteHome(String id) async {
    final url = 'https://rsms-3e512-default-rtdb.firebaseio.com/homes/$id.json';
    final existingHomeIndex = _items.indexWhere((prod) => prod.id == id);
    Home? existingProduct = _items[existingHomeIndex];
    _items.removeAt(existingHomeIndex);
    notifyListeners();
    final response = await http.delete(url as Uri);
    if (response.statusCode >= 400) {
      _items.insert(existingHomeIndex, existingProduct);
      notifyListeners();
      throw HttpException('Could not delete your Ad.');
    }
    existingProduct = null;
  }
}
