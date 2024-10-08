import 'package:favorite_places/models/placelocation.dart';

import 'networking.dart';

class LocationModel {
  final double latitude;
  final double longitude;

  LocationModel({
    required this.latitude,
    required this.longitude,
  });
  Future getPositionImageData() async {
    return await NetworkingHelper(
            'https://restapi.amap.com/v3/staticmap?location=${longitude},${latitude}&zoom=10&size=750*300&markers=mid,,A:${longitude},${latitude}&key=ba4158b74716713aab85a451d47e972d')
        .getImageData();
  }
  Future getLocationData(){
    return NetworkingHelper(
            'https://restapi.amap.com/v3/geocode/regeo?output=json&location=${longitude},${latitude}&key=ba4158b74716713aab85a451d47e972d&radius=1000&extensions=all').getData();
  }
}