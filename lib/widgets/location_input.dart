
import 'package:favorite_places/screens/map.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../constents/constants.dart';
import '../models/placelocation.dart';
import '../services/location.dart';
import 'package:x_amap_base/x_amap_base.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({super.key, required this.onLocationSelected});
  final void Function(PlaceLocation location) onLocationSelected;

  @override
  State<LocationInput> createState() => _LocationInputState();
}
class _LocationInputState extends State<LocationInput> {
  var _isGettingLocation = false;
  void _getCurrentLocation() async {
    LocationPermission permission=await Geolocator.checkPermission();
    bool isEnabled = await Geolocator.isLocationServiceEnabled();
    if(!isEnabled){
      await Geolocator.openLocationSettings();
    }else{
      if(permission==LocationPermission.denied){
        print("Permission denied");
        permission=await Geolocator.requestPermission();
        if(permission==LocationPermission.whileInUse || permission==LocationPermission.always){
          await getPosition();
        }
        return;
      }else if(permission==LocationPermission.deniedForever){
        print("Permission denied forever");
        permission=await Geolocator.requestPermission();
        if(permission==LocationPermission.whileInUse || permission==LocationPermission.always){
          await getPosition();
        }
      }else if(permission==LocationPermission.whileInUse || permission==LocationPermission.always){
        await getPosition();
      }
    }
  }

  Future<void> getPosition() async {
    Position? location;
    try{
      setState(() {
        _isGettingLocation = true;
      });
      //forceAndroidLocationManager 真机需要设置为true
      location = await Geolocator.getCurrentPosition(forceAndroidLocationManager: true);
      setState(() {
        _isGettingLocation = false;
      });
      upLocationData(location.latitude,location.longitude);
      print("Permission granted");
      print("latitude:${location.latitude}");
      print("longitude:${location.longitude}");
    }catch(e){
      print(e);
    }
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
              onPressed: () {
                _selectOnMap();
              },
              label: const Text('Select on Map'),
              icon: const Icon(Icons.map),
            )
          ],
        ),
      ],
    );
  }

  void upLocationData(double lat, double lng) {
    PlaceLocation? placeLocation;
    LocationModel locationModel = LocationModel(
       latitude: lat,
       longitude: lng,
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
      var address=results[1]['regeocode']['formatted_address'];
      if(address is String){
        if(address.isEmpty){
          address='Unknown';
        }
        placeLocation=PlaceLocation(latitude: lat, longitude: lng, address: address);
        widget.onLocationSelected(placeLocation!);

      }else if(address is List){
        if(address.isEmpty){
          address.add('unknown');
          placeLocation=PlaceLocation(latitude: lat, longitude: lng, address: address[0]);
        }
        widget.onLocationSelected(placeLocation!);
      }
    }).catchError((e){
      print(e);
    });
  }

  void _selectOnMap() async {
    final pickedLocation = await Navigator.of(context).push<LatLng>(MaterialPageRoute(builder: (ctx) => MapScreen(isSelected: true)));
    if (pickedLocation == null) {
      return;
    }else{
      print("pickedLocation:$pickedLocation");
      upLocationData(pickedLocation.latitude, pickedLocation.longitude);

    }
  }
}
