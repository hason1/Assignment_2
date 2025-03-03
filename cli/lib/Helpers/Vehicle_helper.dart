import 'dart:io';

import 'package:cli/Classes/Person.dart';
import 'package:cli/Classes/Vehicle.dart';
import 'package:cli/Repositories/Person_repository.dart';
import 'package:cli/Repositories/Vehicle_repository.dart';

class vehicle_helper {
  static vehicle_options({String user_input = ''}){

    List main_options = ['1', '2', '3', '4', '5'];
    String? option;
    if(user_input.isNotEmpty){
      option = user_input;
    }
    else {
      stdout.writeln('\nDu har valt att hantera Fordon. Vad vill du göra?\n1. Lägg till nytt fordon\n2. Visa alla fordon\n3. Uppdatera fordon\n4. Ta bort fordon\n5. Gå tillbaka till huvudmenyn');
      stdout.write('\nVälj ett alternativ (1-5): ');
      option = stdin.readLineSync();
    }

    if(option is String && option != null && option.isNotEmpty && main_options.contains(option)){

      // man ska kunna flytta till koden i varje case till egen funktion
      switch (option) {
        case '1': // Lägg till
          try{
            stdout.write('\nSkriv registrering nummer: ');
            String? reg_number = stdin.readLineSync();

            stdout.write('Skriv fordon typ: ');
            String? type = stdin.readLineSync();


            Vehicle? new_vehicle;
            if(reg_number != null && reg_number.isNotEmpty && type != null && type.isNotEmpty){
              new_vehicle =  Vehicle(registration_number: reg_number ?? '', type: type ?? '', );
            }

            stdout.write('Skriv ägarens namn: ');
            String? person_name = stdin.readLineSync();

            stdout.write('Skriv ägarens personnummer: ');
            String? person_number = stdin.readLineSync();


            Person? vehicle_owner;
            if(person_name != null && person_name.isNotEmpty && person_number != null && person_number.isNotEmpty){
              vehicle_owner = Person(name: person_name ?? '', person_number: person_number ?? '');
            }
            else {
              print('Ett fel har inträffat, vänligen försök igen \n');
              vehicle_options(user_input: option);
            }

            if(new_vehicle != null && vehicle_owner != null){
              new_vehicle.person = vehicle_owner;
              VehicleRepository.add(new_vehicle);

              // Kontrollera att personen är inte redan registrerad
              Person? person = PersonRepository.getById(vehicle_owner.person_number);
              if(person == null){
                PersonRepository.add(vehicle_owner);
              }

              vehicle_options();
            }
            else {
              print('Ett fel har inträffat, vänligen försök igen \n');
              vehicle_options(user_input: option);
            }
          }
          catch(e){
            print('Ett fel har inträffat, vänligen försök igen \n');
            vehicle_options(user_input: option);
          }
        case '2': // Visa alla
          List vehicles_to_print = VehicleRepository.getAll();
          if(vehicles_to_print.isNotEmpty){
            print("\nAlla fordon:");
            for (var vehicle in vehicles_to_print) {
              if(vehicle.person != null){
                print("Regnummer: ${vehicle.registration_number}, Typ: ${vehicle.type}");
                print("Ägeranesnamn: ${vehicle.person.name}, Ägeranes Personnummer: ${vehicle.person.person_number} \n");
              }
            }
            vehicle_options();
          }
          else {
            print("Inga bilar tillagda");
            vehicle_options();
          }
        case '3': // Uppdaera
          stdout.write('\nSkriv regnumret för fordonet du vill uppdatera: ');
          String? reg_number = stdin.readLineSync();

          if(reg_number != null && reg_number.isNotEmpty){
            Vehicle? vehicle = VehicleRepository.getById(reg_number);

            if(vehicle != null){
              stdout.write('\nFordon hittad, Ändra ägeranes namn: ');
              String? name = stdin.readLineSync();

              stdout.write('Skriv ägarens personnummer: ');
              String? person_number = stdin.readLineSync();

              if(name != null && name.isNotEmpty){
                vehicle.person!.name = name ?? '';
                vehicle.person!.person_number = person_number ?? '';
                print('Person ändrad');
                vehicle_options();
              }
              else{
                vehicle_options(user_input: option);
              }

            }
            else {
              print('Kunde inte hitta fordonet, vänligen försök igen');
              vehicle_options(user_input: option);
            }
          }

        case '4':   // Ta bort

          stdout.write('\nSkriv regnumret för fordonet du vill ta bort: ');
          String? reg_number = stdin.readLineSync();

          if(reg_number != null && reg_number.isNotEmpty){

            Vehicle? vehicle = VehicleRepository.getById(reg_number);

            if(vehicle != null){

              bool result = VehicleRepository.delete(vehicle.registration_number);

              if(result == true){
                print(vehicle.registration_number + ' tog bort');
                vehicle_options();
              }
              else{
                print('Ett fel har inträffat, vänligen försök igen');
                vehicle_options(user_input: option);
              }

            }
            else {
              print('Kunde inte hitta fordonet, vänligen försök igen');
              vehicle_options(user_input: option);
            }
          }


        case '5':
          vehicle_options();
        default:
          vehicle_options();
      }
    }
    else {
      vehicle_options();
    }


  }
}