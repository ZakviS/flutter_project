import 'dart:convert';

import 'package:flutter_project/api/apiModel.dart';
import 'package:http/http.dart' as http;


class ApiService {
  final String baseUrl = "http://localhost:8080";
  final String token = "asd";


  Future<EmployeeResponse> searchEmployee(
      EmployeeSearchModel employeeSearchModel) async {
    final url = Uri.parse('$baseUrl/employee/search');

    final response = await http.post(
      url,
      headers: <String, String>{
        'Authorization': '$token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(employeeSearchModel),
    );

    if (response.statusCode == 200) {
      return EmployeeResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load employee response');
    }
  }

  Future<void> deleteEmployee(int? id) async {
    final url = Uri.parse('$baseUrl/employee/delete/$id');

    final response = await http.delete(
      url,
      headers: {
        'Authorization': '$token',
      },
    );

    if (response.statusCode == 200) {
      print('Response data: ${response.body}');
    } else {
      print('Request failed with status: ${response.statusCode}');
    }
  }

  Future<String> addEmployee(EmployeeModel employeeModel) async {
    final url = Uri.parse('$baseUrl/employee/add');

    final response = await http.post(
      url,
      headers: {
        'Authorization': '$token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(employeeModel.toJson()),
    );

    if (response.statusCode == 201) {
      return response.body;
    } else {
      print('Request failed with status: ${response.statusCode}');
      throw Exception('Request failed with status: ${response.statusCode}');
    }
  }

  Future<String> editEmployee(EmployeeModel employeeModel, int id) async {
    final url = Uri.parse('$baseUrl/employee/edit/$id');

    final response = await http.put(
      url,
      headers: {
        'Authorization': '$token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(employeeModel.toJson()),
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Request failed with status: ${response.statusCode}');
    }
  }

  Future<String> getPosition() async {
    final url = Uri.parse('$baseUrl/position/all');

    final response = await http.get(
      url,
      headers: {
        'Authorization': '$token',
      },
    );

    if (response.statusCode == 200) {
      return response.body;
      // print('Response data: ${response.body}');
    } else {
      throw Exception('Request failed with status: ${response.statusCode}');
    }
  }

  Future<List<SalaryModel>> getSalary(int? id) async {
    final url = Uri.parse('$baseUrl/salary/get/$id');

    final response = await http.get(
      url,
      headers: {
        'Authorization': '$token',
      },
    );

    if (response.statusCode == 200) {
      List<Map<String, dynamic>> parsedJson =
      jsonDecode(response.body).cast<Map<String, dynamic>>();
      return SalaryModel.fromJsonList(parsedJson);
    } else {
      throw Exception('Request failed with status: ${response.statusCode}');
    }
  }

  Future<void> deleteSalary(int? id) async {
    final url = Uri.parse('$baseUrl/salary/delete/$id');

    final response = await http.delete(
      url,
      headers: {
        'Authorization': '$token',
      },
    );

    if (response.statusCode == 200) {
      print('Response data: ${response.body}');
    } else {
      print('Request failed with status: ${response.statusCode}');
    }
  }

  Future<String> addSalary(SalaryModel salaryModel) async {
    final url = Uri.parse('$baseUrl/salary/add');
    final response = await http.post(
      url,
      headers: {
        'Authorization': '$token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(salaryModel.toJson()),
    );

    if (response.statusCode == 201) {
      return response.body;
    } else {
      // print('Request failed with status: ${response.statusCode}');
      throw Exception('Request failed with status: ${response.statusCode}');
    }
  }

  Future<String> editSalary(SalaryModel salaryModel, int id) async {
    final url = Uri.parse('$baseUrl/salary/edit/$id');

    final response = await http.put(
      url,
      headers: {
        'Authorization': '$token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(salaryModel.toJson()),
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      print('Request failed with status: ${response.statusCode}');
      throw Exception('Request failed with status: ${response.statusCode}');
    }
  }

  Future<List<PremiumModel>> getPremium(int? id) async {
    final url = Uri.parse('$baseUrl/premium/get/$id');

    final response = await http.get(
      url,
      headers: {
        'Authorization': '$token',
      },
    );

    if (response.statusCode == 200) {
      List<Map<String, dynamic>> parsedJson =
      jsonDecode(response.body).cast<Map<String, dynamic>>();
      return PremiumModel.fromJsonList(parsedJson);
    } else {
      throw Exception('Request failed with status: ${response.statusCode}');
    }
  }

  Future<void> deletePremium(int? id) async {
    final url = Uri.parse('$baseUrl/premium/delete/$id');

    final response = await http.delete(
      url,
      headers: {
        'Authorization': '$token',
      },
    );

    if (response.statusCode == 200) {
      print('Response data: ${response.body}');
    } else {
      print('Request failed with status: ${response.statusCode}');
    }
  }

  Future<String> addPremium(PremiumModel premiumModel) async {
    final url = Uri.parse('$baseUrl/premium/add');

    final response = await http.post(
      url,
      headers: {
        'Authorization': '$token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(premiumModel.toJson()),
    );

    if (response.statusCode == 201) {
      return response.body;
    } else {
      print('Request failed with status: ${response.statusCode}');
      throw Exception('Request failed with status: ${response.statusCode}');
    }
  }

  Future<String> editPremium(PremiumModel premiumModel, int id) async {
    final url = Uri.parse('$baseUrl/premium/edit/$id');

    final response = await http.put(
      url,
      headers: {
        'Authorization': '$token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(premiumModel.toJson()),
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      print('Request failed with status: ${response.statusCode}');
      throw Exception('Request failed with status: ${response.statusCode}');
    }
  }

  Future<List<AllowanceModel>> getAllowance(int? id) async {
    final url = Uri.parse('$baseUrl/allowance/get/$id');

    final response = await http.get(
      url,
      headers: {
        'Authorization': '$token',
      },
    );

    if (response.statusCode == 200) {
      List<Map<String, dynamic>> parsedJson =
      jsonDecode(response.body).cast<Map<String, dynamic>>();

      return  AllowanceModel.fromJsonList(parsedJson);
    } else {
      throw Exception('Request failed with status: ${response.statusCode}');
    }
  }

  Future<void> deleteAllowance(int? id) async {
    final url = Uri.parse('$baseUrl/allowance/delete/$id');

    final response = await http.delete(
      url,
      headers: {
        'Authorization': '$token',
      },
    );

    if (response.statusCode == 200) {
      print('Response data: ${response.body}');
    } else {
      print('Request failed with status: ${response.statusCode}');
    }
  }

  Future<String> addAllowance(AllowanceModel allowanceModel) async {
    final url = Uri.parse('$baseUrl/allowance/add');

    final response = await http.post(
      url,
      headers: {
        'Authorization': '$token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(allowanceModel.toJson()),
    );

    if (response.statusCode == 201) {
      return  response.body;
    } else {
      print('Request failed with status: ${response.statusCode}');
      throw Exception('Request failed with status: ${response.statusCode}');
    }
  }

  Future<String> editAllowance(AllowanceModel allowanceModel, int id) async {
    final url = Uri.parse('$baseUrl/allowance/edit/$id');

    final response = await http.put(
      url,
      headers: {
        'Authorization': '$token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(allowanceModel.toJson()),
    );

    if (response.statusCode == 200) {
      return  response.body;
    } else {
      print('Request failed with status: ${response.statusCode}');
      throw Exception('Request failed with status: ${response.statusCode}');
    }
  }


}
