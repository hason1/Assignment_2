import 'dart:convert';
import 'dart:io';

import 'package:shared/shared.dart';

// Denna fil helper hanterar data lagring
class file_helper {

  @override
  static Future<bool> create({required dynamic json_data, required String path}) async {
    File file = File(path);

    try {
      await file.create(exclusive: true);
      await file.writeAsString(jsonEncode([]));
    } catch (e) {
      // file already exists
      // dont try to create a database file if it exists.
    }

    try {
      String content = await file.readAsString();

      var json = jsonDecode(content) as List;

      json = [...json, json_data];

      await file.writeAsString(jsonEncode(json));
    } catch (e) {
      // TODO: Log error information so Dennis can check it later
      return false;
    }

    return true;
  }


  @override
  static Future<List> getAll({required String path}) async {
    File file = File(path);

    try {
      await file.create(exclusive: true);
      await file.writeAsString(jsonEncode([]));
    } catch (e) {
      // file already exists
      // dont try to create a database file if it exists.
    }

    String content = await file.readAsString();

    return (jsonDecode(content) as List);
  }

  @override
  static Future<bool> update({required String id, required dynamic json_data, required String path} ) async {
    File file = File(path);

    try {
      await file.create(exclusive: true);
      await file.writeAsString(jsonEncode([]));
    } catch (e) {
      // file already exists
    }

    var entities = await getAll(path: path);

    for (var i = 0; i < entities.length; i++) {
      if (entities[i]['id'].toString() == id) {
        entities[i] = json_data;

        await file.writeAsString(
            jsonEncode(entities.map((item) => item).toList()));

        return true;
      }
    }

    return false;
  }

  @override
  static Future<bool> delete({required String id, required String path}) async {
    File file = File(path);

    try {
      await file.create(exclusive: true);
      await file.writeAsString(jsonEncode([]));
    } catch (e) {
      // file already exists
    }

    var entities = await getAll(path: path);

    for (var i = 0; i < entities.length; i++) {
      if (entities[i]['id'].toString() == id) {
        final entity = entities.removeAt(i);

        // write the items in file again
        await file.writeAsString(
            jsonEncode(entities.map((item) => item).toList()));
        return true;
      }
    }
    return false;
  }
}