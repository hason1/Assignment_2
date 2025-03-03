import 'dart:io';

import 'package:cli/Classes/ParkingSpace.dart';
import 'package:cli/Helpers/Tools.dart';
import 'package:cli/Repositories/Parking_space_repository.dart';

class parking_space_helper {
  static parking_space_options({String user_input = ''}){

    List main_options = ['1', '2', '3', '4', '5'];
    String? option;
    if(user_input.isNotEmpty){
      option = user_input;
    }
    else {
      stdout.writeln('\nDu har valt att hantera parkeringsplatser. Vad vill du göra?\n1. Lägg till ny parkeringsplats\n2. Visa alla parkeringsplatser\n3. Uppdatera parkeringsplats\n4. Ta bort parkeringsplats\n5. Gå tillbaka till huvudmenyn');
      stdout.write('\nVälj ett alternativ (1-5): ');
      option = stdin.readLineSync();
    }

    if(option is String && option != null && option.isNotEmpty && main_options.contains(option)){

      // man ska kunna flytta till koden i varje case till egen funktion
      switch (option) {
        case '1': // Lägg till
          try{
            stdout.write('\nSkriv parkeringsplats adress: ');
            String? address = stdin.readLineSync();

            stdout.write('Skriv parkeringsplats pris: ');
            String? price = stdin.readLineSync();

            stdout.write('Skriv parkeringsplats nummer: ');
            String? number = stdin.readLineSync();



            ParkingSpace? new_parking_space;
            if(address != null &&  address.isNotEmpty && address.isNotEmpty && price != null && price.isNotEmpty && number != null && number.isNotEmpty){
              new_parking_space =  ParkingSpace(id: Tools.generateId(),  address: address ?? '', number: number ?? '', price: price ?? '', );
            }
            else {
              print('Ett fel har inträffat, vänligen försök igen \n');
              parking_space_options(user_input: option);
            }


            if(new_parking_space != null){
              ParkingSpaceRepository.add(new_parking_space);
              print('Parkeringsplatsen är tillagd \n');

              parking_space_options();
            }
            else {
              print('Ett fel har inträffat, vänligen försök igen \n');
              parking_space_options(user_input: option);
            }
          }
          catch(e){
            print('Ett fel har inträffat, vänligen försök igen \n');
            parking_space_options(user_input: option);
          }
        case '2': // Visa alla
          List parking_spaces_to_print = ParkingSpaceRepository.getAll();
          if(parking_spaces_to_print.isNotEmpty){
            print("\nAlla parkeringsplatser:");
            for (var park_space in parking_spaces_to_print) {
              if(park_space != null){
                print("Nummer: ${park_space.number}, Adress: ${park_space.address} Pris: ${park_space.price}\n");
              }
            }
            parking_space_options();
          }
          else {
            print("Inga parkeringsplatser tillagda");
            parking_space_options();
          }
        case '3': // Uppdaera
          stdout.write('\nSkriv numret för parkeringsplatsen du vill uppdatera: ');
          String? number = stdin.readLineSync();

          if(number != null && number.isNotEmpty){
            ParkingSpace? parking = ParkingSpaceRepository.getByNumber(number);

            if(parking != null){
              stdout.write('\nParkeringsplats hittad, Ändra adress: ');
              String? address = stdin.readLineSync();


              if(address != null && address.isNotEmpty){
                parking.address = address ?? '';
                print('Parkeringsplats ändrad');
                parking_space_options();
              }
              else{
                parking_space_options(user_input: option);
              }

            }
            else {
              print('Kunde inte hitta parkeringsplatsen, vänligen försök igen');
              parking_space_options(user_input: option);
            }
          }

        case '4':   // Ta bort

          stdout.write('\nSkriv numret för parkeringsplatsen du vill ta bort: ');
          String? number = stdin.readLineSync();

          if(number != null && number.isNotEmpty){

            ParkingSpace? parking = ParkingSpaceRepository.getByNumber(number);

            if(parking != null){

              bool result = ParkingSpaceRepository.delete(parking.number);

              if(result == true){
                print('Parkeringen med numret ' + parking.number + ' togs bort');
                parking_space_options();
              }
              else{
                print('Ett fel har inträffat, vänligen försök igen');
                parking_space_options(user_input: option);
              }

            }
            else {
              print('Kunde inte hitta parkeringsplatsen, vänligen försök igen');
              parking_space_options(user_input: option);
            }
          }


        case '5':
          parking_space_options();
        default:
          parking_space_options();
      }
    }
    else {
      parking_space_options();
    }
  }
}