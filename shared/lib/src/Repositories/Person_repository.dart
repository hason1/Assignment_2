
import 'package:shared/shared.dart';

class PersonRepository {
  static final List<Person> _persons = [];

  static add(Person person) async {
    _persons.add(person);
  }

  static Future<List<Person>> getAll() async {
    return _persons;
  }

  static Future<Person?> getById(String personNumber) async {
    try {
      return _persons.firstWhere((p) => p.person_number == personNumber);
    } catch (e) {
      return null;
    }
  }

  static Future<bool> update(Person updatedPerson) async {
    for (int i = 0; i < _persons.length; i++) {
      if (_persons[i].person_number == updatedPerson.person_number) {
        _persons[i] = updatedPerson;
        return true;
      }
    }
    return false;
  }

  static Future<bool> delete(String personNumber) async {
    try {
      _persons.removeWhere((p) => p.person_number == personNumber);
      return true;
    } catch (e) {
      return false;
    }
  }
}
