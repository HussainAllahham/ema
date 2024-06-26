import 'package:location/location.dart';

Location location = new Location();

bool? _serviceEnabled;

PermissionStatus? _permissionGranted;

LocationData? _locationData;

Future<dynamic> getLocation() async {
  _serviceEnabled = await location.serviceEnabled();
  if (!_serviceEnabled!) _serviceEnabled = await location.requestService();

  _permissionGranted = await location.hasPermission();
  if (_permissionGranted == PermissionStatus.denied) {
    _permissionGranted = await location.requestPermission();
  }
  _locationData = await location.getLocation();
  return _locationData;
}
