import 'dart:convert';

import 'package:flutter_project/Model/AllowanceModel.dart';

import '../Model/SalaryModel.dart';
import '../api/apiService.dart';


class AllowanceService{

  String responseJson = "";
  List<AllowanceModel> allowance = [];
  ApiService api = ApiService();


  Future<void> loadAllowance(int ?id) async {

    responseJson = await api.getSalary(id);
    // print('Response data: ${response.body}');


    List<Map<String, dynamic>> parsedJson = jsonDecode(responseJson).cast<Map<String, dynamic>>();
    allowance = AllowanceModel.fromJsonList(parsedJson);
    // print(salary.length);

  }

  List<AllowanceModel> getAllowanceList() {
    // fetchData(token);
    return allowance;
  }

  AllowanceModel getAllowance(int id){

    for(int i = 0;i<allowance.length;i++){
      if (allowance[i].id== id){
        return allowance[i];
      }
    }

    return allowance[0];
  }

  Future<void> delete(int? id) async {
    await api.deleteAllowance(id);


  }

  Future<void> add(String token,AllowanceModel allowanceModel) async {

    responseJson = await api.addAllowance(allowanceModel);

  }

  Future<void> edit(String token,AllowanceModel allowanceModel, int id) async {

    responseJson = await api.editAllowance(allowanceModel, id);

  }

}