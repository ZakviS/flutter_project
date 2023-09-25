

class EmployeeSearchModel {
  // EmployeeSearchModel({this.id, this.name});

  EmployeeSearchModel(this.surname, this.working, this.page,
      this.elementPerPage, this.direction, this.key);

  String surname;
  bool working;
  int page;
  int elementPerPage;
  String direction = "dsc";
  String key;

}