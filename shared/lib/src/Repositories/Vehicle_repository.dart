
import 'package:shared/shared.dart';

class VehicleRepository {
 static final List<Vehicle> _vehicles = [];

  static add(Vehicle vehicle) {
    _vehicles.add(vehicle);
  }

  static List<Vehicle> getAll() {
    return _vehicles;
  }

  static Vehicle? getById(String registrationNumber) {
    try {
      return _vehicles.firstWhere((v) => v.registration_number == registrationNumber);
    } catch (e) {
      return null;
    }
  }

  static bool update(Vehicle updatedVehicle) {
    for (int i = 0; i < _vehicles.length; i++) {
      if (_vehicles[i].registration_number == updatedVehicle.registration_number) {
        _vehicles[i] = updatedVehicle;
        return true;
      }
    }
    return false;
  }

  static bool delete(String registrationNumber) {
    try {
      _vehicles.removeWhere((v) => v.registration_number == registrationNumber);
      return true;
    } catch (e) {
      return false;
    }
  }
}
