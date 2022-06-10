import 'package:geolocator/geolocator.dart';

class Location {
  // ignore: non_constant_identifier_names
  double latitude = 0.0;
  double longitude = 0.0;

  Future<void> getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low);
      latitude = position.latitude;
      longitude = position.longitude;
      // e is error. If error catch error then print out error
    } catch (e) {
      print(e);
    }
  }
}
