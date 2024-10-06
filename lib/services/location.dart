import 'package:favorite_places/models/placelocation.dart';
import 'package:location/location.dart';

import 'networking.dart';

class LocationModel {
  final PlaceLocation location;

  LocationModel({
    required this.location,
  });
  Future getPositionImageData() async {
    return await NetworkingHelper(
            'https://restapi.amap.com/v3/staticmap?location=${location.longitude},${location.latitude}&zoom=10&size=750*300&markers=mid,,A:${location.longitude},${location.latitude}&key=ba4158b74716713aab85a451d47e972d')
        .getImageData();
  }
  Future getLocationData(){
    return NetworkingHelper(
            'https://restapi.amap.com/v3/geocode/regeo?output=json&location=${location.longitude},${location.latitude}&key=ba4158b74716713aab85a451d47e972d&radius=1000&extensions=all').getData();
  }
}