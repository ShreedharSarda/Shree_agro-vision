import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';

class MyMap extends StatefulWidget {
  @override
  State<MyMap> createState() => MyMapSampleState();
}

class MyMapSampleState extends State<MyMap> {
  Completer<GoogleMapController> _controller = Completer();
  final Map<String, Marker> _markers = {};
  void _getLocation() async {
    var currentLocation = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(currentLocation.latitude, currentLocation.longitude),
        zoom: 13)));
    setState(() {
      _markers.clear();
      final marker = Marker(
        markerId: MarkerId("curr_loc"),
        position: LatLng(currentLocation.latitude, currentLocation.longitude),
        infoWindow: InfoWindow(title: 'Your Location'),
      );
      _markers["Current Location"] = marker;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.hybrid,
            zoomControlsEnabled: false,
            initialCameraPosition: CameraPosition(
              target: LatLng(31.113950446941107, 76.40454660906389),
              zoom: 11,
            ),
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            markers: _markers.values.toSet(),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SafeArea(
              child: Align(
                alignment: Alignment.topRight,
                child: FloatingActionButton(
                  backgroundColor: Colors.green[900],
                  onPressed: _getLocation,
                  tooltip: 'Get Location',
                  child: Icon(Icons.pin_drop),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
