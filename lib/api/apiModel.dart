
import 'package:json_annotation/json_annotation.dart';
part 'apiModel.g.dart';

@JsonSerializable()
class AllowanceModel {
  final int? id;
  int? sum;
  DateTime? dateOfSalary;
  int? numberOfOrder;
  DateTime? dateOfOrder;
  int? employeeId;

  AllowanceModel({
    required this.id,
    required this.sum,
    required this.dateOfSalary,
    required this.numberOfOrder,
    required this.dateOfOrder,
    required this.employeeId,
  });

  static List<AllowanceModel> fromJsonList(
      List<Map<String, dynamic>> jsonList) {
    return jsonList.map((json) => AllowanceModel.fromJson(json)).toList();
  }

  factory AllowanceModel.fromJson(Map<String, dynamic> json) => _$AllowanceModelFromJson(json);
  Map<String, dynamic> toJson() => _$AllowanceModelToJson(this);
}

@JsonSerializable()
class SalaryModel {
  final int? id;
  int? sum;
  DateTime? dateOfSalary;
  int? numberOfOrder;
  DateTime? dateOfOrder;
  int? employeeId;

  SalaryModel({
    required this.id,
    required this.sum,
    required this.dateOfSalary,
    required this.numberOfOrder,
    required this.dateOfOrder,
    required this.employeeId,
  });

  static List<SalaryModel> fromJsonList(List<Map<String, dynamic>> jsonList) {
    return jsonList.map((json) => SalaryModel.fromJson(json)).toList();
  }

  factory SalaryModel.fromJson(Map<String, dynamic> json) => _$SalaryModelFromJson(json);
  Map<String, dynamic> toJson() => _$SalaryModelToJson(this);

}


@JsonSerializable()
class PremiumModel {
  final int? id;
  int? sum;
  DateTime? dateOfSalary;
  int? numberOfOrder;
  DateTime? dateOfOrder;
  int? employeeId;

  PremiumModel({
    required this.id,
    required this.sum,
    required this.dateOfSalary,
    required this.numberOfOrder,
    required this.dateOfOrder,
    required this.employeeId,
  });

  static List<PremiumModel> fromJsonList(List<Map<String, dynamic>> jsonList) {
    return jsonList.map((json) => PremiumModel.fromJson(json)).toList();
  }

  factory PremiumModel.fromJson(Map<String, dynamic> json) => _$PremiumModelFromJson(json);
  Map<String, dynamic> toJson() => _$PremiumModelToJson(this);

}

@JsonSerializable()
class EmployeeModel {
  final int? id;
  String name;
  String surname;
  String secondSurname;
  DateTime beginning;
  DateTime? dismissal;
  String phoneNumber;

  EmployeeModel({
    required this.id,
    required this.name,
    required this.surname,
    required this.secondSurname,
    required this.beginning,
    required this.dismissal,
    required this.phoneNumber,
    required this.email,
    required this.positionId,
  });

  String email;
  int positionId;

  static List<EmployeeModel> fromJsonList(List<Map<String, dynamic>> jsonList) {
    return jsonList.map((json) => EmployeeModel.fromJson(json)).toList();
  }

  factory EmployeeModel.fromJson(Map<String, dynamic> json) => _$EmployeeModelFromJson(json);
  Map<String, dynamic> toJson() => _$EmployeeModelToJson(this);

}

@JsonSerializable()
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

  factory EmployeeResponse.fromJson(Map<String, dynamic> json) => _$EmployeeResponseFromJson(json);
  Map<String, dynamic> toJson() => _$EmployeeResponseToJson(this);

}

@JsonSerializable()
class EmployeeSearchModel {
  String surname;
  bool working;
  int page;
  int elementPerPage;
  String direction = "dsc";
  String key;

  EmployeeSearchModel(
      {required this.surname,
        required this.working,
        required this.page,
        required this.elementPerPage,
        required this.direction,
        required this.key});


  static List<EmployeeSearchModel> fromJsonList(
      List<Map<String, dynamic>> jsonList) {
    return jsonList.map((json) => EmployeeSearchModel.fromJson(json)).toList();
  }


  factory EmployeeSearchModel.fromJson(Map<String, dynamic> json) => _$EmployeeSearchModelFromJson(json);
  Map<String, dynamic> toJson() => _$EmployeeSearchModelToJson(this);

}

@JsonSerializable()
class PositionModel {
  final int id;
  String name;
  DateTime? beginning;

  PositionModel({
    required this.id,
    required this.name,
    required this.beginning,
  });

  static List<PositionModel> fromJsonList(List<Map<String, dynamic>> jsonList) {
    return jsonList.map((json) => PositionModel.fromJson(json)).toList();
  }

  factory PositionModel.fromJson(Map<String, dynamic> json) => _$PositionModelFromJson(json);
  Map<String, dynamic> toJson() => _$PositionModelToJson(this);

}




