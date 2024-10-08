import 'package:flutter/material.dart';
import 'package:amap_map/amap_map.dart';
import 'package:x_amap_base/x_amap_base.dart';
import '../constents/constants.dart';
import '../models/placelocation.dart';

class MapScreen extends StatefulWidget {
  MapScreen(
      {this.isSelected = true,
      this.location = const PlaceLocation(
          latitude: 39.906217, longitude: 116.3912757, address: '')});
  @override
  State<MapScreen> createState() => _MapScreenState();
  final String id = 'map';
  final PlaceLocation location;
  final bool isSelected;
}

class _MapScreenState extends State<MapScreen> {
  LatLng? _latLng;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AMapInitializer.updatePrivacyAgree(ConstConfig.amapPrivacyStatement);
  }

  @override
  Widget build(BuildContext context) {
    final AMapWidget amap = AMapWidget(
      initialCameraPosition: CameraPosition(
        target: LatLng(widget.location.latitude, widget.location.longitude),
        zoom: 16.0,
      ),
      markers: (_latLng==null&& widget.isSelected)? {} :{
        Marker(
          position: _latLng != null
              ? _latLng!
              : LatLng(widget.location.latitude, widget.location.longitude),
        ),
      },
      onMapCreated: onMapCreated,
      onTap: widget.isSelected==false ? null : (latLng) {
        setState(() {
          _latLng = latLng;
        });
      },
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isSelected ? 'Pick your location' : 'Your Location'),
        actions: [
          if (widget.isSelected)
            IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                Navigator.of(context).pop(_latLng);
              },
            )
        ],
      ),
      body: ConstrainedBox(
        constraints: BoxConstraints.expand(),
        child: Container(
          child: amap,
          height: double.infinity,
          width: double.infinity,
        ),
      ),
    );
  }

  late AMapController _mapController;
  void onMapCreated(AMapController controller) {
    setState(() {
      _mapController = controller;
    });
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _mapController.disponse();
    super.dispose();

  }
}
