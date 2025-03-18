
import 'package:shared/shared.dart';

class ParkingRepository {
  static final List<Parking> _parkings = [];

  static Future add(Parking parking) async{
    _parkings.add(parking);
  }

  static Future<List<Parking>> getAll() async {
    return _parkings;
  }

  static Future<Parking?> getById(String vehicleRegistration) async {
    try {
      return _parkings.firstWhere((p) => p.vehicle.registration_number == vehicleRegistration);
    } catch (e) {
      return null;
    }
  }

  static Future<bool> update(Parking updatedParking) async {
    for (int i = 0; i < _parkings.length; i++) {
      if (_parkings[i].vehicle.registration_number == updatedParking.vehicle.registration_number) {
        _parkings[i] = updatedParking;
        return true;
      }
    }
    return false;
  }

  static Future<bool> delete(String vehicleRegistration) async {
    try {
      _parkings.removeWhere((p) => p.vehicle.registration_number == vehicleRegistration);
      return true;
    } catch (e) {
      return false;
    }
  }
}
