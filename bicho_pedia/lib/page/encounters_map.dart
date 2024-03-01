import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapEncounters extends StatefulWidget {
  const MapEncounters({super.key});

  @override
  State<MapEncounters> createState() => _MapEncountersState();
}

class _MapEncountersState extends State<MapEncounters> {
  final Completer<GoogleMapController> _completer =
      Completer<GoogleMapController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _determinePosition(),
        builder: (BuildContext context, AsyncSnapshot<Position> snapshot) {
          if (snapshot.hasData) {
            return GoogleMap(
                mapType: MapType.terrain,
                initialCameraPosition: CameraPosition(
                    target: LatLng(
                        snapshot.data!.latitude, snapshot.data!.longitude),
                    zoom: 14),
                onMapCreated: (GoogleMapController controller) {
                  _completer.complete(controller);
                });
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          // The connection state is still ongoing
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }
}
