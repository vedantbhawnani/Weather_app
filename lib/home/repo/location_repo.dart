import 'dart:convert';
import 'dart:developer';

import 'package:geocode/geocode.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;

class LocationRepo {
  Location location = Location();
  // TODO: ask permission everytime if denied, and never ask if granted. --Shared_preferences
  Future<bool> requestPermission() async {
    PermissionStatus permissionGranted;
    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return false;
      }
    }
    return true;
  }

  Future<LocationData> getCurrentLocation() async {
    final serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      final result = await location.requestService();
      if (result == true) {
        print("Service enabled.");
      } else {
        print("Service not enabled.");
      }
    }
    final locationData = await location.getLocation();
    return locationData;
  }

  Future<Map<String, dynamic>> fetchData(
      double? latitude, double? longitude) async {
    var client = http.Client();
    try {
      var response = await client.get(
        Uri.parse(
            "https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=22d25b5d78fa5d57eefdfd50069a82a7"),
      );
      Map<String, dynamic> result = jsonDecode(response.body);
      return result;
    } catch (e) {
      log(e.toString());
      return {};
    }
  }

  Future<String> getAddress(double? lat, double? lang) async {
    if (lat == null || lang == null) return "";
    GeoCode geoCode = GeoCode();
    // Future.delayed(Duration(seconds: 1));
    Address address =
        await geoCode.reverseGeocoding(latitude: lat, longitude: lang);
    print(address);
    if (address.streetAddress == null) {
      return "📍Here";
    }
    return "${address.streetAddress}, ${address.city}";
  }
}
