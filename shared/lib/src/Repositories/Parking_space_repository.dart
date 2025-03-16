
import 'package:shared/shared.dart';

class ParkingSpaceRepository {
  static final List<ParkingSpace> _parkingSpaces = [];

  static add(ParkingSpace parkingSpace) {
    _parkingSpaces.add(parkingSpace);
  }

  static List<ParkingSpace> getAll() {
    return _parkingSpaces;
  }

  static ParkingSpace? getById(String id) {
    try {
      return _parkingSpaces.firstWhere((p) => p.id == id);
    } catch (e) {
      return null;
    }
  }

  static ParkingSpace? getByNumber(String number) {
    try {
      return _parkingSpaces.firstWhere((p) => p.number == number);
    } catch (e) {
      return null;
    }
  }

  bool update(ParkingSpace updatedParkingSpace) {
    for (int i = 0; i < _parkingSpaces.length; i++) {
      if (_parkingSpaces[i].id == updatedParkingSpace.id) {
        _parkingSpaces[i] = updatedParkingSpace;
        return true;
      }
    }
    return false;
  }

 static bool delete(String number) {
    try {
      _parkingSpaces.removeWhere((p) => p.number == number);
      return true;
    } catch (e) {
      return false;
    }
  }
}
