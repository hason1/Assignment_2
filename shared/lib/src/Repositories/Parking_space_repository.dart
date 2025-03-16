
import 'package:shared/shared.dart';

class ParkingSpaceRepository {
  static final List<ParkingSpace> _parkingSpaces = [];

  static add(ParkingSpace parkingSpace) async {
    _parkingSpaces.add(parkingSpace);
  }

  static Future<List<ParkingSpace>> getAll() async {
    return _parkingSpaces;
  }

  static Future<ParkingSpace?> getById(String id) async {
    try {
      return _parkingSpaces.firstWhere((p) => p.id == id);
    } catch (e) {
      return null;
    }
  }

  static Future<ParkingSpace?> getByNumber(String number) async {
    try {
      return _parkingSpaces.firstWhere((p) => p.number == number);
    } catch (e) {
      return null;
    }
  }

  Future<bool> update(ParkingSpace updatedParkingSpace) async {
    for (int i = 0; i < _parkingSpaces.length; i++) {
      if (_parkingSpaces[i].id == updatedParkingSpace.id) {
        _parkingSpaces[i] = updatedParkingSpace;
        return true;
      }
    }
    return false;
  }

 static Future<bool> delete(String number) async {
    try {
      _parkingSpaces.removeWhere((p) => p.number == number);
      return true;
    } catch (e) {
      return false;
    }
  }
}
