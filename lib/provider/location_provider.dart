import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:location/location.dart';

class FormattedLocation {
  final String lat;
  final String long;
  final String address;

  FormattedLocation(
      {required this.lat, required this.long, required this.address});
}

class LocationProvider extends ChangeNotifier {
  Location location = Location();
  String? googleAddress;
  LocationData? currentLocation;

  double? latitude;
  double? longitude;
  String? newAddress;

  Future checkAndRequestPerm() async {
    bool serviceEnabled;
    PermissionStatus permissionStatus;
    serviceEnabled = await location.serviceEnabled();

    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionStatus = await location.hasPermission();
    if (permissionStatus == PermissionStatus.denied) {
      permissionStatus = await location.requestPermission();

      if (permissionStatus != PermissionStatus.granted) {
        return;
      }
    }

    await location.changeSettings(interval: 10000);
  }

  Future<FormattedLocation> getCurrentLocation() async {
    await checkAndRequestPerm();

    var data = await location.getLocation();
    currentLocation = data;

    googleAddress = await getCodedData(
      lat: data.latitude ?? 0,
      lng: data.longitude ?? 0,
    );

    print('**************ADDRESS');
    print(googleAddress);

    print(currentLocation?.latitude);
    print(currentLocation?.longitude);

    notifyListeners();
    return FormattedLocation(
      lat: "${currentLocation?.latitude ?? ""}",
      long: "${currentLocation?.longitude ?? ""}",
      address: googleAddress ?? '',
    );
  }

  Future<String> getCodedData(
      {required double lat, required double lng}) async {
    List<geo.Placemark> placemarks =
        await geo.placemarkFromCoordinates(lat, lng);

    return '${placemarks[3].name},${placemarks[3].street},${placemarks[3].administrativeArea},${placemarks[3].country}';
  }
}
