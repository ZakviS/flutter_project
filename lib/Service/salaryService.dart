import 'dart:convert';
import 'package:http/http.dart' as http;

import '../Model/SalaryModel.dart';
import '../api/apiService.dart';


class SalaryService{

  String responseJson = "";
  List<SalaryModel> salary = [];
  ApiService api = ApiService();


  Future<void> loadSalary(int ?id) async {

    responseJson = await api.getSalary(id);
    // print('Response data: ${response.body}');


    List<Map<String, dynamic>> parsedJson = jsonDecode(responseJson).cast<Map<String, dynamic>>();
    salary = SalaryModel.fromJsonList(parsedJson);
    // print(salary.length);

  }

  List<SalaryModel> getSalaryList() {
    // fetchData(token);
    return salary;
  }

  SalaryModel getSalary(int id){

    for(int i = 0;i<salary.length;i++){
      if (salary[i].id== id){
        return salary[i];
      }
    }

    return salary[0];
  }

  Future<void> delete(int? id) async {
    await api.deleteSalary(id);


  }

  Future<void> add(String token,SalaryModel salaryModel) async {

    responseJson = await api.addSalary(salaryModel);

  }

  Future<void> edit(String token,SalaryModel salaryModel, int id) async {

    responseJson = await api.editSalary(salaryModel, id);

  }

}