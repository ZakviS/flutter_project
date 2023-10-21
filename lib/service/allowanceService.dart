
import 'dart:convert';

import 'package:flutter_project/model/allowanceModel.dart';

import '../api/apiService.dart';

class AllowanceService {
  String responseJson = "";
  List<AllowanceModel> allowance = [];
  ApiService api = ApiService();

  Future<List<AllowanceModel>> loadAllowance(int? id) async {
    responseJson = await api.getAllowance(id);

    List<Map<String, dynamic>> parsedJson =
        jsonDecode(responseJson).cast<Map<String, dynamic>>();

    allowance = AllowanceModel.fromJsonList(parsedJson);

    // print(allow.toString());
    return  AllowanceModel.fromJsonList(parsedJson);
  }


  Future<void> delete(int? id) async {
    await api.deleteAllowance(id);
  }

  Future<void> add(String token, AllowanceModel allowanceModel) async {
    responseJson = await api.addAllowance(allowanceModel);
  }

  Future<void> edit(String token, AllowanceModel allowanceModel, int id) async {
    responseJson = await api.editAllowance(allowanceModel, id);
  }
}
