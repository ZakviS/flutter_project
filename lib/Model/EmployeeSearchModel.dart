
class EmployeeSearchModel {

  String surname;
  bool working;
  int page;
  int elementPerPage;
  String direction = "dsc";
  String key;

  EmployeeSearchModel({
    required this.surname,
    required this.working,
    required this.page,
    required this.elementPerPage,
    required this.direction,
    required this.key
  });

  factory EmployeeSearchModel.fromJson(Map<String, dynamic> json) {
    return EmployeeSearchModel(
        surname:json['surname'],
        working:json['working'],
        page:json['working'],
        elementPerPage:json['elementPerPage'],
        direction: json['direction'],
        key:json['key'],
    );
  }

  static List<EmployeeSearchModel> fromJsonList(List<Map<String, dynamic>> jsonList) {
    return jsonList.map((json) => EmployeeSearchModel.fromJson(json)).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'surname': surname,
      'working': working,
      'page': page,
      'elementPerPage': elementPerPage,
      'direction': direction,
      'key': key,
    };
  }


}
