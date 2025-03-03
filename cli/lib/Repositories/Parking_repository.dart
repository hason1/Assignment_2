import 'package:cli/Classes/Parking.dart';

class ParkingRepository {
  static final List<Parking> _parkings = [];

  static add(Parking parking) {
    _parkings.add(parking);
  }

  static List<Parking> getAll() {
    return _parkings;
  }

  static Parking? getById(String vehicleRegistration) {
    try {
      return _parkings.firstWhere((p) => p.vehicle.registration_number == vehicleRegistration);
    } catch (e) {
      return null;
    }
  }

  static bool update(Parking updatedParking) {
    for (int i = 0; i < _parkings.length; i++) {
      if (_parkings[i].vehicle.registration_number == updatedParking.vehicle.registration_number) {
        _parkings[i] = updatedParking;
        return true;
      }
    }
    return false;
  }

  static bool delete(String vehicleRegistration) {
    try {
      _parkings.removeWhere((p) => p.vehicle.registration_number == vehicleRegistration);
      return true;
    } catch (e) {
      return false;
    }
  }
}
