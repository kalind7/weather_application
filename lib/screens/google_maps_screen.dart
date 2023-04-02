import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/provider/export_provider.dart';

class GoogleMapPage extends StatefulWidget {
  const GoogleMapPage({
    super.key,
  });

  // final FormattedLocation? formattedLocation;
  // final Function(double, double, String) callback;

  @override
  State<GoogleMapPage> createState() => _GoogleMapPageState();
}

class _GoogleMapPageState extends State<GoogleMapPage> {
  late GoogleMapController googleMapController;

  CameraPosition? cameraPosition;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer2<LocationProvider, WeatherProvider>(
          builder: (context, locationProv, weatherProv, child) {
        return Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: const CameraPosition(
                  target: LatLng(
                    27.708496,
                    85.34657,
                  ),
                  zoom: 18),
              onMapCreated: (controller) {
                setState(() {
                  googleMapController = controller;
                });
              },
              onCameraMove: ((position) {
                cameraPosition = position;
              }),
              onCameraIdle: () async {
                if (cameraPosition != null) {
                  var data = await locationProv.getCodedData(
                      lat: cameraPosition!.target.latitude,
                      lng: cameraPosition!.target.longitude);

                  setState(() {
                    locationProv.googleAddress = data;
                  });

                  // widget.callback.call(cameraPosition!.target.latitude,
                  //     cameraPosition!.target.longitude, data);
                }
              },
            ),
            Center(
              child: Image.asset(
                'assets/images/marker.png',
                height: 40,
                width: 40,
              ),
            ),
            Positioned(
                bottom: 75,
                left: 20,
                right: 20,
                child: Text(
                  locationProv.googleAddress ?? '',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                )),
            Positioned(
                bottom: 15,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width - 100,
                  child: ElevatedButton(
                    onPressed: () {
                      weatherProv.fetchWeatherDatas(
                        lat: cameraPosition?.target.latitude,
                        long: cameraPosition?.target.longitude,
                      );
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Save Address',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ))
          ],
        );
      }),
    );

    // return Scaffold(
    //   body: GoogleMap(
    //     initialCameraPosition: const CameraPosition(
    //         target: LatLng(
    //       27.708496,
    //       85.34657,
    //     )),
    //     mapType: MapType.normal,
    //     onMapCreated: (controller) {
    //       setState(() {
    //         googleMapController = controller;
    //       });
    //     },
    //     onCameraMove: (position) {
    //       setState(() {
    //         cameraPosition = position;
    //       });
    //     },
    //   ),
    // );
  }
}
