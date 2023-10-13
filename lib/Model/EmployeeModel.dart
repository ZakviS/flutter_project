
class EmployeeModel{

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


   factory EmployeeModel.fromJson(Map<String, dynamic> json) {
     return EmployeeModel(
       id: json['id'],
       name: json['name'],
       surname: json['surname'],
       secondSurname: json['secondSurname'],
       beginning: DateTime.parse(json['beginning']),
       // dismissal: DateTime.parse(json['dismissal']),
       dismissal: json['dismissal'] != null ? DateTime.parse(json['dismissal']) : null,

       phoneNumber: json['phoneNumber'],
       email: json['email'],
       positionId: json['positionId'],
     );
   }

   static List<EmployeeModel> fromJsonList(List<Map<String, dynamic>> jsonList) {
     return jsonList.map((json) => EmployeeModel.fromJson(json)).toList();
   }

   Map<String, dynamic> toJson() {
     return {
       'id': id,
       'name': name,
       'surname': surname,
       'secondSurname': secondSurname,
       'beginning': beginning.toIso8601String(),
       'dismissal': dismissal?.toIso8601String(),
       'phoneNumber': phoneNumber,
       'email': email,
       'positionId': positionId,
     };
   }
}
