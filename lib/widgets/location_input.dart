
import 'package:flutter/material.dart';
import 'package:location/location.dart';

import '../constents/constants.dart';
import '../models/placelocation.dart';
import '../services/location.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({super.key, required this.onLocationSelected});
  final void Function(PlaceLocation location) onLocationSelected;

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  var _isGettingLocation = false;
  void _getCurrentLocation() async {
    Location location = Location();
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    setState(() {
      _isGettingLocation = true;
    });
    _locationData = await location.getLocation();
    setState(() {
      _isGettingLocation = false;
    });
    print(_locationData.latitude);
    print(_locationData.longitude);
    upLocationData(_locationData);
  }

  Widget content = const Text(
    'No Location Chosen',
    style: TextStyle(color: Colors.white),
  );
  @override
  Widget build(BuildContext context) {
    if (_isGettingLocation) {
      content = const CircularProgressIndicator();
    }
    return Column(
      children: [
        kFrameWidget(content: content),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton.icon(
              onPressed: () {
                _getCurrentLocation();
              },
              label: const Text('Current Location'),
              icon: const Icon(Icons.location_on),
            ),
            TextButton.icon(
              onPressed: () {},
              label: const Text('Select on Map'),
              icon: const Icon(Icons.map),
            )
          ],
        ),
      ],
    );
  }

  void upLocationData(LocationData locationData) {
    final location = locationData.latitude;
    final longitude = locationData.longitude;
    PlaceLocation placeLocation = PlaceLocation(
      latitude: location!,
      longitude: longitude!,
      address: '',
    );
    LocationModel locationModel = LocationModel(
       location: placeLocation,
    );
    Future.wait([
    locationModel.getPositionImageData().then((value) {
      return value;
    }),
    locationModel.getLocationData().then((value) {
      print(value);
      return value;
    })
    ]).then((results){
      setState(() {
        content = ConstrainedBox(
            constraints: const BoxConstraints.expand(),
            child: Image.memory(results[0],fit: BoxFit.cover,width: double.infinity,height: double.infinity,));
      });
      List<dynamic> address=results[1]['regeocode']['formatted_address'];
      if(address.isEmpty){
        address.add('Unknown');
      }
      placeLocation.address=address[0];
      widget.onLocationSelected(placeLocation);
    }).catchError((e){
      print(e);
    });
  }
}
