import 'package:flutter/material.dart';
import 'package:flutter_project/Model/EmployeeModel.dart';
import 'package:flutter_project/Model/PositionModel.dart';
import 'package:flutter_project/Model/EmployeeSearchModel.dart';
import 'package:flutter_project/Service/employeeService.dart';
import 'package:flutter_project/Service/positionService.dart';
import 'package:flutter_project/pages/addEmolyeeScreen.dart';


import 'dart:convert';
import 'package:http/http.dart' as http;


class Employee extends StatefulWidget{
  const Employee({super.key});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return EmployeeState();
  }

}


class EmployeeState extends State<Employee>{
  final employeeService = EmployeeService();
  final positionService = PositionService();
  List<EmployeeModel> employeeList = [];
  List<PositionModel> positionList = [];

  @override
  void initState(){
    super.initState();

    // var emp = EmployeeModel(id:3,name:"ads",surname:"dsf",secondSurname:"qwed",beginning:DateTime.parse("2023-09-13"),dismissal:DateTime.parse("2023-09-13"),phoneNumber:"sdf",email:"rgedf@gmail.com", positionId: 1);
    fetchDataAndPrintName();
    // employeeList.add(emp);
    // employeeService.fetchData("MTY5NTU3MDUyNzMxOTo5ZGY5NzJhZTE2NGIwYmQxODdlMGYxOGM1NTA2ZDUyYTFkNjg2YWJlNGQ2NWJlMjQyMzU2ZDdjNTI2ZjM2ZTYwOnpha3ZpczEyMzQ1OjMzZDhkOGRmZGIzZDU4M2RiOTJmMTQxZjQzZWViNTFiNDY1YmY5OTdiZWFiNmFlZGE0ZmJjMDQ2YzNkMjk0ODFiYTI5ZmZkOGE4NGUwZGZiN2QwY2U3MWE1ODlmNGJhZDM1NmVhOWUzYWQ5MjQzYjY4Yzg0MWIyZmE3OWZmYzE4");



  }

  Future<void> fetchDataAndPrintName() async {
    await employeeService.fetchData("MTY5NTU3MDUyNzMxOTo5ZGY5NzJhZTE2NGIwYmQxODdlMGYxOGM1NTA2ZDUyYTFkNjg2YWJlNGQ2NWJlMjQyMzU2ZDdjNTI2ZjM2ZTYwOnpha3ZpczEyMzQ1OjMzZDhkOGRmZGIzZDU4M2RiOTJmMTQxZjQzZWViNTFiNDY1YmY5OTdiZWFiNmFlZGE0ZmJjMDQ2YzNkMjk0ODFiYTI5ZmZkOGE4NGUwZGZiN2QwY2U3MWE1ODlmNGJhZDM1NmVhOWUzYWQ5MjQzYjY4Yzg0MWIyZmE3OWZmYzE4");
    await positionService.fetchData("token");

    setState(() {
      employeeList.addAll(employeeService.getEmployeeList());// Обновляем список после получения данных
      positionList.addAll(positionService.getPositionList());
    });
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Штат'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: employeeList.length,
        itemBuilder: (BuildContext context, int i){
          return Dismissible(
              key: Key(employeeList[i].name),
              child: Card(
                child: ListTile(
                    title: Text(employeeList[i].name + " " + positionList.first.name),
                  trailing: IconButton(
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ), onPressed: () {
                    // print(employeeList[i].id);
                    // employeeService.delete("token", employeeList[i].id);
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Подтвердите удаление'),
                          content: Text('Вы уверены, что хотите удалить этого сотрудника?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(); // Закрыть диалог
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(builder: (context) => Employee()), // SecondScreen - ваша целевая страница
                                // );
                              },
                              child: Text('Отмена'),
                            ),
                            TextButton(
                              onPressed: () {
                                // Вызов метода удаления после подтверждения
                                print(employeeList[i].id);
                                // employeeService.delete("token", employeeList[i].id);
                                Navigator.of(context).pop(); // Закрыть диалог
                              },
                              child: Text('Удалить'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  ) ,
                ),
             ),
    onDismissed: (direction) {
      if (direction == DismissDirection.endToStart) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Подтвердите удаление'),
              content: Text('Вы уверены, что хотите удалить этого сотрудника?'),
              actions: [
                TextButton(
                 onPressed: () {
                   Navigator.of(context).pop(); // Закрыть диалог
                   Navigator.push(
                     context,
                     MaterialPageRoute(builder: (context) => Employee()), // SecondScreen - ваша целевая страница
                   );
                },
                child: Text('Отмена'),
            ),
            TextButton(
              onPressed: () {
              // Вызов метода удаления после подтверждения
                print(employeeList[i].id);
                // employeeService.delete("token", employeeList[i].id);
                Navigator.of(context).pop(); // Закрыть диалог
                },
              child: Text('Удалить'),
              ),
            ],
          );
        },
        );
      }
      else{

                }
          },
            );
          }
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: (){
          // showDialog(context: context, builder: (BuildContext context){
          //   return AlertDialog(
          //     title: Text('Add employee'),
          //     content: TextField(
          //       onChanged: (String value){
          //
          //       },
          //     ),
          //   );
          // });
          print(positionList.length);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => addEmployee()), // SecondScreen - ваша целевая страница
          );
          // Navigator.pushNamed(context, '/employee',);
          // Future.delayed(Duration.zero, () {});
        },
        child: Icon(
          Icons.add,

        ),
      ),

    );
    // case '/employee':
    // return Employee();
  }
  
}