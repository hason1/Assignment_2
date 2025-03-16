
import 'package:shared/shared.dart';

class PersonRepository {
  static final List<Person> _persons = [];

  static add(Person person) {
    _persons.add(person);
  }

  static List<Person> getAll() {
    return _persons;
  }

  static Person? getById(String personNumber) {
    try {
      return _persons.firstWhere((p) => p.person_number == personNumber);
    } catch (e) {
      return null;
    }
  }

  static bool update(Person updatedPerson) {
    for (int i = 0; i < _persons.length; i++) {
      if (_persons[i].person_number == updatedPerson.person_number) {
        _persons[i] = updatedPerson;
        return true;
      }
    }
    return false;
  }

  static bool delete(String personNumber) {
    try {
      _persons.removeWhere((p) => p.person_number == personNumber);
      return true;
    } catch (e) {
      return false;
    }
  }
}
