import 'package:flutter/material.dart';
import 'package:flutter_project/Model/EmployeeModel.dart';
import 'package:flutter_project/Model/PositionModel.dart';
import 'package:flutter_project/Service/employeeService.dart';
import 'package:flutter_project/Service/positionService.dart';
import 'package:flutter_project/pages/addEmolyeeScreen.dart';


import 'editEmployeeScreen.dart';


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

    fetchDataAndPrintName();
  }

  Future<void> fetchDataAndPrintName() async {
    await employeeService.loadEmployee();
    await positionService.loadPosition();

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
                    title: Text(employeeList[i].name + " " + positionService.getPosition(employeeList[i].positionId).name),
                  trailing: IconButton(
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ), onPressed: () {
                    // print(employeeList[i].id);
                    // employeeService.delete(employeeList[i].id);
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
                                // employeeService.delete(employeeList[i].id);
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
                // employeeService.delete(employeeList[i].id);
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
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => editEmployeeScreen(employee : employeeList[i])), // SecondScreen - ваша целевая страница
            );
                }
          },
            );
          }
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: (){
          print(positionList.length);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => addEmployee()), // SecondScreen - ваша целевая страница
          );

        },
        child: Icon(
          Icons.add,

        ),
      ),

    );

  }
  
}