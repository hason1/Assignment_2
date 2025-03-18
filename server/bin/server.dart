import 'dart:convert';
import 'dart:io';

import 'package:server/Handlers/Person_handler.dart';
import 'package:server/Handlers/Vehicle_handler.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';

// Configure routes.
final _router =
    Router()
      ..get('/', _rootHandler)
      ..get('/echo/<message>', _echoHandler)
      ..post('/persons', person_handler.add_person)
      ..get('/persons', person_handler.get_persons)
      ..get('/persons/<id>', person_handler.get_person)
      ..put('/persons/<id>', person_handler.update_person)
      ..delete('/persons/<id>', person_handler.delete_person)
      ..post('/vehicles', vehicle_handler.add_vehicle)
      ..get('/vehicles', vehicle_handler.get_vehicles)
      ..get('/vehicles/<id>', vehicle_handler.get_vehicle)
      ..put('/vehicles/<id>', vehicle_handler.update_vehicle)
      ..delete('/vehicles/<id>', vehicle_handler.delete_vehicle);

Response _rootHandler(Request req) {
  return Response.ok('Hello, World!\n');
}

Response _echoHandler(Request request) {
  final message = request.params['message'];
  return Response.ok('$message\n');
}

void main(List<String> args) async {
  // Use any available host or container IP (usually `0.0.0.0`).
  final ip = InternetAddress.anyIPv4;

  // Configure a pipeline that logs requests.
  final handler = Pipeline()
      .addMiddleware(logRequests())
      .addHandler(_router.call);

  // For running in containers, we respect the PORT environment variable.
  final port = int.parse(Platform.environment['PORT'] ?? '8080');
  final server = await serve(handler, ip, port);
  print('Server listening on port ${server.port}');
}
