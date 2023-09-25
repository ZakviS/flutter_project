import 'dart:convert';
import 'package:http/http.dart' as http;

import '../Model/EmployeeModel.dart';

class EmployeeService{

  String responseJson = "";
  List<EmployeeModel> employees = [];

  Future<void> fetchData(String token) async {
    final url = Uri.parse('http://localhost:8080/employee/get');

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
    employees = EmployeeModel.fromJsonList(parsedJson);


  }

  List<EmployeeModel> getEmployeeList() {
    // fetchData(token);
    return employees;
  }


}