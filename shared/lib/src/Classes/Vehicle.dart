
import 'package:shared/shared.dart';

class Vehicle {
  String registration_number;
  String type;
  Person? person;

  Vehicle({required this.registration_number, required this.type, this.person});
}