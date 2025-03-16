

import 'package:shared/shared.dart';

class Parking {
  Vehicle vehicle;
  ParkingSpace parking_space;
  String? start_time;
  String? end_time;

  Parking({required this.vehicle, required this.parking_space, required this.start_time, required this.end_time});
}
