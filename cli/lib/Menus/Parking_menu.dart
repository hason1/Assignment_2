import 'dart:io';

import 'package:cli/Main_functions.dart';
import 'package:cli/Tools.dart';
import 'package:cli/Repositories/Parking_repository.dart';
import 'package:cli/Repositories/Vehicle_repository.dart';
import 'package:shared/shared.dart';

import '../Repositories/Parking_space_repository.dart';
import '../Repositories/Parking_space_repository.dart';

class parking_menu {
  static input_handler({String user_input = ''}) async{

    List main_options = ['1', '2', '3', '4', '5'];
    String? option;
    if(user_input.isNotEmpty){
      option = user_input;
    }
    else {
      stdout.writeln('\nDu har valt att hantera Parkeringar. Vad vill du göra?\n1. Lägg till ny parkering\n2. Visa alla parkeringar\n3. Gå tillbaka till huvudmenyn');
      stdout.write('\nVälj ett alternativ (1-5): ');
      option = stdin.readLineSync();
    }

    if(option is String && option != null && option.isNotEmpty && main_options.contains(option)){

      // man ska kunna flytta till koden i varje case till egen funktion
      switch (option) {
        case '1': // Lägg till
          try{

            stdout.write('Skriv registrering nummer: ');
            String? reg_number = stdin.readLineSync();

            stdout.write('Skriv parkeringsplats nummer: ');
            String? park_space_number = stdin.readLineSync();

            Vehicle? vehicle;
            ParkingSpace? parking_space;
            if(reg_number != null && reg_number.isNotEmpty && park_space_number != null && park_space_number.isNotEmpty){
              parking_space =  await ParkingSpaceRepository.get(park_space_number);
              vehicle = await VehicleRepository.get_vehicle(reg_number);
            }
            else {
              print('Fyll i parkeringsplats numret och fordons numret, vänligen försök igen \n');
              input_handler(user_input: option);
            }

            if(parking_space == null || vehicle == null){
              print('Parkeringsplatsen eller fordonet existerar inte, fordon och parkering platsen måste existera för att lägga parkeringen. vänligen försök igen \n');
              input_handler();
            }


            String? start_time = Tools.get_valid_time_user_input(text: 'starttid');
            String? end_time = Tools.get_valid_time_user_input(text: 'sluttid');


            if(vehicle != null && parking_space != null && start_time != null && start_time.isNotEmpty && end_time != null && end_time.isNotEmpty ){
              Parking parking = Parking(vehicle: vehicle, parking_space: parking_space, start_time: start_time, end_time: end_time);
              ParkingRepository.add(parking);

              print('\nParkeringen är skapad \n');

              input_handler();
            }
            else {
              print('\n Ett fel har inträffat, vänligen försök igen \n');
              input_handler(user_input: option);
            }
          }
          catch(e){
            print('\n Ett fel har inträffat, vänligen försök igen \n');
            input_handler(user_input: option);
          }
        case '2': // Visa alla
          List parkings_to_print = await ParkingRepository.getAll();
          if(parkings_to_print.isNotEmpty){
            print("\nAlla parkeringar:");
            for (var parking in parkings_to_print) {
              if(parking.vehicle != null){
                print("Regnummer: ${parking.vehicle.registration_number}, Typ: ${parking.vehicle.type}");
                print("Ägeranesnamn: ${parking.vehicle.person.name}, Ägeranes Personnummer: ${parking.vehicle.person.person_number}");
              }
              if(parking.parking_space != null){
                print("Adress: ${parking.parking_space.address}, Pris: ${parking.parking_space.price}, Nummer: ${parking.parking_space.number}");
              }

              if(parking.start_time != null && parking.end_time != null){
                print("Starttid: ${parking.start_time}, Sluttid: ${parking.end_time}");
              }
            }
            input_handler();
          }
          else {
            print("Inga parkeringar tillagda");
            input_handler();
          }
        case '3':
          main_functions.start_app();
        default:
          main_functions.start_app();
      }
    }
    else {
      input_handler();
    }


  }
}