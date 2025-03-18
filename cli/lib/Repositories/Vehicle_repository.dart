import 'dart:convert';

import 'package:http/http.dart';
import 'package:shared/shared.dart';
import 'package:http/http.dart' as http;

class VehicleRepository {
 static final List<Vehicle> _vehicles = [];

 static Future<Vehicle?> add(Vehicle vehicle) async {
    _vehicles.add(vehicle);
  }

  static Future<List<Vehicle>> getAll() async {
    return _vehicles;
  }

  static Future<Vehicle?> getById(String registrationNumber) async {
    try {
      return _vehicles.firstWhere((v) => v.registration_number == registrationNumber);
    } catch (e) {
      return null;
    }
  }

  static Future<bool> update(Vehicle updatedVehicle) async {
    for (int i = 0; i < _vehicles.length; i++) {
      if (_vehicles[i].registration_number == updatedVehicle.registration_number) {
        _vehicles[i] = updatedVehicle;
        return true;
      }
    }
    return false;
  }

  static Future<bool> delete(String registrationNumber) async {
    try {
      _vehicles.removeWhere((v) => v.registration_number == registrationNumber);
      return true;
    } catch (e) {
      return false;
    }
  }
}
