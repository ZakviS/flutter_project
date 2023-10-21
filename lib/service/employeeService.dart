import 'dart:convert';

import 'package:flutter_project/model/employeeSearchModel.dart';
import 'package:flutter_project/model/employeeModel.dart';

import '../model/employeeResponse.dart';
import '../api/apiService.dart';

class EmployeeService {
  String responseJson = "";
  List<EmployeeModel> employees = [];
  ApiService api = ApiService();



  Future<void> delete(int? id) async {
    await api.deleteEmployee(id);
    // EmployeeSearchModel('', false, 0, 10, "dsc", "surname");
  }

  Future<void> add(String token, EmployeeModel employeeModel) async {
    responseJson = await api.addEmployee(employeeModel);
  }

  Future<void> edit(String token, EmployeeModel employeeModel, int id) async {
    responseJson = await api.editEmployee(employeeModel, id);
  }

  Future<EmployeeResponse> searchEmployee(
      EmployeeSearchModel employeeSearchModel) async {
    return await api.searchEmployee(employeeSearchModel);
  }
}
