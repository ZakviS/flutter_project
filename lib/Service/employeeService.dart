import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:flutter_project/Model/EmployeeSearchModel.dart';
import 'package:http/http.dart' as http;

import '../Model/EmployeeModel.dart';
import '../Model/EmployeeResponse.dart';
import '../api/apiService.dart';

class EmployeeService{

  String responseJson = "";
  List<EmployeeModel> employees = [];
  ApiService api = ApiService();

  Future<void> loadEmployee() async {

    responseJson = await api.getEmployee();

    // EmployeeSearchModel('', false, 0, 10, "dsc", "surname");
    List<Map<String, dynamic>> parsedJson = jsonDecode(responseJson).cast<Map<String, dynamic>>();
    employees = EmployeeModel.fromJsonList(parsedJson);


  }

  List<EmployeeModel> getEmployeeList() {
    // fetchData(token);
    return employees;
  }

  Future<void> delete(int? id) async {
    await api.deleteEmployee(id);
    // EmployeeSearchModel('', false, 0, 10, "dsc", "surname");


  }

  Future<void> add(String token,EmployeeModel employeeModel) async {

      responseJson = await api.addEmployee(employeeModel);

  }

  Future<void> edit(String token,EmployeeModel employeeModel,int id) async {

    responseJson = await api.editEmployee(employeeModel,id);

  }

  Future<EmployeeResponse> searchEmployee(EmployeeSearchModel employeeSearchModel) async {

    return await api.searchEmployee(employeeSearchModel);

  }


}