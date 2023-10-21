
import 'package:json_annotation/json_annotation.dart';

part 'allowanceModel.g.dart';

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
