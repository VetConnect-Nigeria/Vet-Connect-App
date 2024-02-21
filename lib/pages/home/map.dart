import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapSample extends StatefulWidget {
  const MapSample({super.key});

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  final Location _location = Location();
  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;
  late LocationData _locationData;

  @override
  void initState() {
    super.initState();
    _checkLocationPermissions();
    _location.onLocationChanged.listen((LocationData currentLocation) {
      // Update your location marker
      setState(() {
        _locationData = currentLocation;
        _updateMarkers(currentLocation);
      });
    });
  }

  Future<void> _checkLocationPermissions() async {
    _serviceEnabled = await _location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await _location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await _location.getLocation();
  }

  void _updateMarkers(LocationData currentLocation) {
    final userLocationMarker = Marker(
      markerId: const MarkerId("userLocation"),
      position: LatLng(currentLocation.latitude!, currentLocation.longitude!),
      infoWindow:
          const InfoWindow(title: "Your Location", snippet: "You are here!"),
    );

    final List<Marker> markers = [
      userLocationMarker,
      const Marker(
        markerId: MarkerId("location1"),
        position: LatLng(7.174111, 3.408801),
        infoWindow: InfoWindow(
          title: "Dr. Ben's Clinic",
          snippet: "Expert veterinary care for your pets.",
        ),
      ),
      const Marker(
        markerId: MarkerId("location2"),
        position: LatLng(7.235983, 3.438542),
        infoWindow: InfoWindow(
          title: "FUNAAB Veterinary Teaching Hospital",
          snippet: "State-of-the-art facility for animal health and research.",
        ),
      ),
      const Marker(
        markerId: MarkerId("location3"),
        position: LatLng(7.221227, 3.446593),
        infoWindow: InfoWindow(
          title: "Dr. Taiwo's Office",
          snippet: "Comprehensive animal wellness exams and treatments.",
        ),
      ),
      // Add more markers as needed
    ];

    setState(() {
      _markers.clear();
      _markers.addAll(markers);
    });
  }

  final List<Marker> _markers = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          target: LatLng(_locationData?.latitude ?? 7.235983,
              _locationData?.longitude ?? 3.438542),
          zoom: 14,
        ),
        markers: Set.from(_markers),
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}
