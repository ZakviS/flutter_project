
class EmployeeModel{

   int id;
   String name;
   String surname;
   String secondSurname;
   DateTime beginning;
   DateTime dismissal;
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


   factory EmployeeModel.fromJson(Map<String, dynamic> json) {
     return EmployeeModel(
       id: json['id'],
       name: json['name'],
       surname: json['surname'],
       secondSurname: json['secondSurname'],
       beginning: DateTime.parse(json['beginning']),
       dismissal: DateTime.parse(json['dismissal']),
       phoneNumber: json['phoneNumber'],
       email: json['email'],
       positionId: json['positionId'],
     );
   }

   static List<EmployeeModel> fromJsonList(List<Map<String, dynamic>> jsonList) {
     return jsonList.map((json) => EmployeeModel.fromJson(json)).toList();
   }
}
