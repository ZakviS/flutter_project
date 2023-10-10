
class AllowanceModel{
  final int? id;
  int? sum;
  DateTime? dateOfSalary;
  int? numbOfOrder;
  DateTime? dateOfOrder;
  int? employeeId;


  AllowanceModel({
    required this.id,
    required this.sum,
    required this.dateOfSalary,
    required this.numbOfOrder,
    required this.dateOfOrder,
    required this.employeeId,

  });



  factory AllowanceModel.fromJson(Map<String, dynamic> json) {
    return AllowanceModel(
      id: json['id'],
      sum: json['sum'],
      dateOfSalary: json['month'] != null ? DateTime.parse(json['month']) : null,
      numbOfOrder: json['numberOfOrder'],
      dateOfOrder: json['dateOfOrder'] != null ? DateTime.parse(json['dateOfOrder']) : null,
      employeeId: json['employeeId'],
    );
  }

  static List<AllowanceModel> fromJsonList(List<Map<String, dynamic>> jsonList) {
    return jsonList.map((json) => AllowanceModel.fromJson(json)).toList();
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
