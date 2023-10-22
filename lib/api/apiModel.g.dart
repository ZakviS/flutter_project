// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'apiModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllowanceModel _$AllowanceModelFromJson(Map<String, dynamic> json) =>
    AllowanceModel(
      id: json['id'] as int?,
      sum: json['sum'] as int?,
      dateOfSalary: json['dateOfSalary'] == null
          ? null
          : DateTime.parse(json['dateOfSalary'] as String),
      numberOfOrder: json['numberOfOrder'] as int?,
      dateOfOrder: json['dateOfOrder'] == null
          ? null
          : DateTime.parse(json['dateOfOrder'] as String),
      employeeId: json['employeeId'] as int?,
    );

Map<String, dynamic> _$AllowanceModelToJson(AllowanceModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sum': instance.sum,
      'dateOfSalary': instance.dateOfSalary?.toIso8601String(),
      'numberOfOrder': instance.numberOfOrder,
      'dateOfOrder': instance.dateOfOrder?.toIso8601String(),
      'employeeId': instance.employeeId,
    };

SalaryModel _$SalaryModelFromJson(Map<String, dynamic> json) => SalaryModel(
      id: json['id'] as int?,
      sum: json['sum'] as int?,
      dateOfSalary: json['dateOfSalary'] == null
          ? null
          : DateTime.parse(json['dateOfSalary'] as String),
      numberOfOrder: json['numberOfOrder'] as int?,
      dateOfOrder: json['dateOfOrder'] == null
          ? null
          : DateTime.parse(json['dateOfOrder'] as String),
      employeeId: json['employeeId'] as int?,
    );

Map<String, dynamic> _$SalaryModelToJson(SalaryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sum': instance.sum,
      'dateOfSalary': instance.dateOfSalary?.toIso8601String(),
      'numberOfOrder': instance.numberOfOrder,
      'dateOfOrder': instance.dateOfOrder?.toIso8601String(),
      'employeeId': instance.employeeId,
    };

PremiumModel _$PremiumModelFromJson(Map<String, dynamic> json) => PremiumModel(
      id: json['id'] as int?,
      sum: json['sum'] as int?,
      dateOfSalary: json['dateOfSalary'] == null
          ? null
          : DateTime.parse(json['dateOfSalary'] as String),
      numberOfOrder: json['numberOfOrder'] as int?,
      dateOfOrder: json['dateOfOrder'] == null
          ? null
          : DateTime.parse(json['dateOfOrder'] as String),
      employeeId: json['employeeId'] as int?,
    );

Map<String, dynamic> _$PremiumModelToJson(PremiumModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sum': instance.sum,
      'dateOfSalary': instance.dateOfSalary?.toIso8601String(),
      'numberOfOrder': instance.numberOfOrder,
      'dateOfOrder': instance.dateOfOrder?.toIso8601String(),
      'employeeId': instance.employeeId,
    };

EmployeeModel _$EmployeeModelFromJson(Map<String, dynamic> json) =>
    EmployeeModel(
      id: json['id'] as int?,
      name: json['name'] as String,
      surname: json['surname'] as String,
      secondSurname: json['secondSurname'] as String,
      beginning: DateTime.parse(json['beginning'] as String),
      dismissal: json['dismissal'] == null
          ? null
          : DateTime.parse(json['dismissal'] as String),
      phoneNumber: json['phoneNumber'] as String,
      email: json['email'] as String,
      positionId: json['positionId'] as int,
    );

Map<String, dynamic> _$EmployeeModelToJson(EmployeeModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'surname': instance.surname,
      'secondSurname': instance.secondSurname,
      'beginning': instance.beginning.toIso8601String(),
      'dismissal': instance.dismissal?.toIso8601String(),
      'phoneNumber': instance.phoneNumber,
      'email': instance.email,
      'positionId': instance.positionId,
    };

EmployeeResponse _$EmployeeResponseFromJson(Map<String, dynamic> json) =>
    EmployeeResponse(
      employee: (json['employee'] as List<dynamic>)
          .map((e) => EmployeeModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      pageNo: json['pageNo'] as int,
      pageSize: json['pageSize'] as int,
      totalElements: json['totalElements'] as int,
      totalPages: json['totalPages'] as int,
      last: json['last'] as bool,
    );

Map<String, dynamic> _$EmployeeResponseToJson(EmployeeResponse instance) =>
    <String, dynamic>{
      'employee': instance.employee,
      'pageNo': instance.pageNo,
      'pageSize': instance.pageSize,
      'totalElements': instance.totalElements,
      'totalPages': instance.totalPages,
      'last': instance.last,
    };

EmployeeSearchModel _$EmployeeSearchModelFromJson(Map<String, dynamic> json) =>
    EmployeeSearchModel(
      surname: json['surname'] as String,
      working: json['working'] as bool,
      page: json['page'] as int,
      elementPerPage: json['elementPerPage'] as int,
      direction: json['direction'] as String,
      key: json['key'] as String,
    );

Map<String, dynamic> _$EmployeeSearchModelToJson(
        EmployeeSearchModel instance) =>
    <String, dynamic>{
      'surname': instance.surname,
      'working': instance.working,
      'page': instance.page,
      'elementPerPage': instance.elementPerPage,
      'direction': instance.direction,
      'key': instance.key,
    };

PositionModel _$PositionModelFromJson(Map<String, dynamic> json) =>
    PositionModel(
      id: json['id'] as int,
      name: json['name'] as String,
      beginning: json['beginning'] == null
          ? null
          : DateTime.parse(json['beginning'] as String),
    );

Map<String, dynamic> _$PositionModelToJson(PositionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'beginning': instance.beginning?.toIso8601String(),
    };
