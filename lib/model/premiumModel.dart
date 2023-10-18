
class PremiumModel {
  final int id;
  int? sum;
  DateTime? dateOfSalary;
  int? numbOfOrder;
  DateTime? dateOfOrder;
  int? employeeId;

  PremiumModel({
    required this.id,
    required this.sum,
    required this.dateOfSalary,
    required this.numbOfOrder,
    required this.dateOfOrder,
    required this.employeeId,
  });

  factory PremiumModel.fromJson(Map<String, dynamic> json) {
    return PremiumModel(
      id: json['id'],
      sum: json['sum'],
      dateOfSalary:
          json['month'] != null ? DateTime.parse(json['month']) : null,
      numbOfOrder: json['numberOfOrder'],
      dateOfOrder: json['dateOfOrder'] != null
          ? DateTime.parse(json['dateOfOrder'])
          : null,
      employeeId: json['employeeId'],
    );
  }

  static List<PremiumModel> fromJsonList(List<Map<String, dynamic>> jsonList) {
    return jsonList.map((json) => PremiumModel.fromJson(json)).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'sum': sum,
      'month': dateOfSalary?.toIso8601String(),
      'numberOfOrder': numbOfOrder,
      'dateOfOrder': dateOfOrder?.toIso8601String(),
      'employeeId': employeeId,
    };
  }
}
