import 'dart:convert';

import 'EmployeeModel.dart';

class EmployeeResponse {
  List<EmployeeModel> employee;
  int pageNo;
  int pageSize;
  int totalElements;
  int totalPages;
  bool last;

  EmployeeResponse({
    required this.employee,
    required this.pageNo,
    required this.pageSize,
    required this.totalElements,
    required this.totalPages,
    required this.last,
  });

  factory EmployeeResponse.fromJson(Map<String, dynamic> json) {
    return EmployeeResponse(
      employee: List<EmployeeModel>.from(json['employee'].map((e) => EmployeeModel.fromJson(e))),
      pageNo: json['pageNo'],
      pageSize: json['pageSize'],
      totalElements: json['totalElements'],
      totalPages: json['totalPages'],
      last: json['last'],
    );
  }
}
