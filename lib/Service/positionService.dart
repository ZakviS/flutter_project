import 'dart:convert';
import 'package:http/http.dart' as http;

import '../Model/PositionModel.dart';

class PositionService{

  String responseJson = "";
  List<PositionModel> position = [];

  Future<void> fetchData(String token) async {
    final url = Uri.parse('http://localhost:8080/position/all');

    final response = await http.get(
      url,
      headers: {
        'Authorization': '$token',
      },
    );

    if (response.statusCode == 200) {
      responseJson = response.body;
      // print('Response data: ${response.body}');
    } else {
      print('Request failed with status: ${response.statusCode}');
    }
    // EmployeeSearchModel('', false, 0, 10, "dsc", "surname");

    List<Map<String, dynamic>> parsedJson = jsonDecode(responseJson).cast<Map<String, dynamic>>();
    position = PositionModel.fromJsonList(parsedJson);
    print(responseJson);

  }

  List<PositionModel> getPositionList() {
    // fetchData(token);
    return position;
  }

  String getPosition(int id){

      for(int i = 0;i<position.length;i++){
        if (position[i].id== id){
          return position[i].name;
        }
      }

    return "";
  }

}