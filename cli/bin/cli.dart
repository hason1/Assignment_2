

import 'dart:io';

import 'package:shared/shared.dart';

void main(List<String> arguments) {

  start_app();

}


void start_app(){
  String? main_option_input = handle_main_options();

  if(main_option_input != null){
    handle_selected_option(option: main_option_input);
  }

}


String? handle_main_options(){
  stdout.writeln('\nVälkommen till Parkeringsappen!\nVad vill du hantera?\n1. Personer\n2. Fordon\n3. Parkeringsplatser\n4. Parkeringar\n5. Avsluta');
  stdout.write('\nVälj ett alternativ (1-5): ');

  List main_options = ['1', '2', '3', '4', '5'];

  String? input = stdin.readLineSync();
  if(input is String && input != null && input.isNotEmpty && main_options.contains(input)){
    if(input == '5'){
      stdout.write('\nProgram avslutad');
      exit(0);
    }
    else {
      return input;
    }
  }
  else {
    stdout.write('\nVälj ett alternativ (1-5): ');
    handle_main_options();
  }


}


void handle_selected_option({required String option}){

  switch (option) {
    case '1':
      person_helper.input_handler();
    case '2':
      vehicle_helper.input_handler();
    case '3':
      parking_space_helper.input_handler();
    case '4':
      parking_helper.input_handler();
    default:
    //  executeUnknown();
  }
}





