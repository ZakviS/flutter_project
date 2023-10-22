import 'dart:convert';

import 'package:flutter_project/api/apiModel.dart';
import '../api/apiService.dart';

class PositionService {
  String responseJson = "";
  List<PositionModel> position = [];
  ApiService api = ApiService();

  static final PositionService _instance = PositionService._internal();

  PositionService._internal();

  factory PositionService() {
    return _instance;
  }


  Future<void> loadPosition() async {
    responseJson = await api.getPosition();

    List<Map<String, dynamic>> parsedJson =
        jsonDecode(responseJson).cast<Map<String, dynamic>>();
    position = PositionModel.fromJsonList(parsedJson);
  }

  List<PositionModel> getPositionList() {
    return position;
  }

  PositionModel getPosition(int id) {
    for (int i = 0; i < position.length; i++) {
      if (position[i].id == id) {
        return position[i];
      }
    }
    return position[0];
  }
}
