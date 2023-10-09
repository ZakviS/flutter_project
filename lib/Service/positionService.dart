import 'dart:convert';
import 'package:http/http.dart' as http;

import '../Model/PositionModel.dart';
import '../api/apiService.dart';


class PositionService{

  String responseJson = "";
  List<PositionModel> position = [];
  ApiService api = ApiService();


  Future<void> loadPosition() async {

      responseJson = await api.getPosition();
      // print('Response data: ${response.body}');


    List<Map<String, dynamic>> parsedJson = jsonDecode(responseJson).cast<Map<String, dynamic>>();
    position = PositionModel.fromJsonList(parsedJson);
    // print(responseJson);

  }

  List<PositionModel> getPositionList() {
    // fetchData(token);
    return position;
  }

  PositionModel getPosition(int id){

      for(int i = 0;i<position.length;i++){
        if (position[i].id== id){
          return position[i];
        }
      }

    return position[0];
  }

}