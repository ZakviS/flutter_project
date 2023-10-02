
class PositionModel{

  final int id;
  String name;
  DateTime? beginning;


  PositionModel({
    required this.id,
    required this.name,
    required this.beginning,
  });



  factory PositionModel.fromJson(Map<String, dynamic> json) {
    return PositionModel(
      id: json['id'],
      name: json['name'],
      // beginning: DateTime.parse(json['beginning']),
      beginning: json['beginning'] != null ? DateTime.parse(json['beginning']) : null,
    );
  }

  static List<PositionModel> fromJsonList(List<Map<String, dynamic>> jsonList) {
    return jsonList.map((json) => PositionModel.fromJson(json)).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'beginning': beginning?.toIso8601String(),
    };
  }
}
