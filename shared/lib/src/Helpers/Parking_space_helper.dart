import 'dart:io';

import 'package:shared/shared.dart';

class parking_space_helper {
  static input_handler({String user_input = ''}) async{

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
              input_handler(user_input: option);
            }


            if(new_parking_space != null){
              ParkingSpaceRepository.add(new_parking_space);
              print('Parkeringsplatsen är tillagd \n');

              input_handler();
            }
            else {
              print('Ett fel har inträffat, vänligen försök igen \n');
              input_handler(user_input: option);
            }
          }
          catch(e){
            print('Ett fel har inträffat, vänligen försök igen \n');
            input_handler(user_input: option);
          }
        case '2': // Visa alla
          List parking_spaces_to_print = await ParkingSpaceRepository.getAll();
          if(parking_spaces_to_print.isNotEmpty){
            print("\nAlla parkeringsplatser:");
            for (var park_space in parking_spaces_to_print) {
              if(park_space != null){
                print("Nummer: ${park_space.number}, Adress: ${park_space.address} Pris: ${park_space.price}\n");
              }
            }
            input_handler();
          }
          else {
            print("Inga parkeringsplatser tillagda");
            input_handler();
          }
        case '3': // Uppdaera
          stdout.write('\nSkriv numret för parkeringsplatsen du vill uppdatera: ');
          String? number = stdin.readLineSync();

          if(number != null && number.isNotEmpty){
            ParkingSpace? parking = await ParkingSpaceRepository.getByNumber(number);

            if(parking != null){
              stdout.write('\nParkeringsplats hittad, Ändra adress: ');
              String? address = stdin.readLineSync();


              if(address != null && address.isNotEmpty){
                parking.address = address ?? '';
                print('Parkeringsplats ändrad');
                input_handler();
              }
              else{
                input_handler(user_input: option);
              }

            }
            else {
              print('Kunde inte hitta parkeringsplatsen, vänligen försök igen');
              input_handler(user_input: option);
            }
          }

        case '4':   // Ta bort

          stdout.write('\nSkriv numret för parkeringsplatsen du vill ta bort: ');
          String? number = stdin.readLineSync();

          if(number != null && number.isNotEmpty){

            ParkingSpace? parking = await ParkingSpaceRepository.getByNumber(number);

            if(parking != null){

              bool result = await ParkingSpaceRepository.delete(parking.number);

              if(result == true){
                print('Parkeringen med numret ' + parking.number + ' togs bort');
                input_handler();
              }
              else{
                print('Ett fel har inträffat, vänligen försök igen');
                input_handler(user_input: option);
              }

            }
            else {
              print('Kunde inte hitta parkeringsplatsen, vänligen försök igen');
              input_handler(user_input: option);
            }
          }


        case '5':
          input_handler();
        default:
          input_handler();
      }
    }
    else {
      input_handler();
    }
  }
}