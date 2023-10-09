
import 'package:flutter/material.dart';
import 'package:flutter_project/Model/PositionModel.dart';
import 'package:flutter_project/Model/EmployeeModel.dart';
import 'package:flutter_project/Model/EmployeeSearchModel.dart';
import 'package:flutter_project/Service/employeeService.dart';
import 'package:flutter_project/Service/positionService.dart';
import 'package:flutter_project/pages/employeeScreen.dart';


import 'dart:convert';
import 'package:http/http.dart' as http;


class addEmployee extends StatefulWidget{
  const addEmployee({super.key});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return addEmployeeState();
  }

}


class addEmployeeState extends State<addEmployee> {
  final employeeService = EmployeeService();
  final positionService = PositionService();
  List<PositionModel> positionList = [];
  List<EmployeeModel> employeeList = [];
  PositionModel? selectedPosition;
  @override
  void initState() {
    super.initState();
    fetchDataAndPrintName();
  }

  Future<void> fetchDataAndPrintName() async {
    await positionService.loadPosition();

    setState(() {
      positionList.addAll(positionService.getPositionList());
    });
  }

  String text1 = '';
  String text2 = '';
  String text3 = '';
  String text4 = '';
  String text5 = '';
  DateTime date1 = DateTime.now();
  DateTime? date2 = null ;
  String dropdownValue = 'Опция 1';


  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: Text('Моя форма'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Поле ввода текста 1
            TextFormField(
              onChanged: (value) {
                setState(() {
                  text1 = value;
                });
              },
              decoration: InputDecoration(labelText: 'Имя'),
            ),
            // Поле ввода текста 2
            TextFormField(
              onChanged: (value) {
                setState(() {
                  text2 = value;
                });
              },
              decoration: InputDecoration(labelText: 'Фамилия'),
            ),
            // Поле ввода текста 3
            TextFormField(
              onChanged: (value) {
                setState(() {
                  text3 = value;
                });
              },
              decoration: InputDecoration(labelText: 'Отчество'),
            ),
            // Поле ввода текста 4
            TextFormField(
              onChanged: (value) {
                setState(() {
                  text4 = value;
                });
              },
              decoration: InputDecoration(labelText: 'Телефон'),
            ),
            // Поле ввода текста 5
            TextFormField(
              onChanged: (value) {
                setState(() {
                  text5 = value;
                });
              },
              decoration: InputDecoration(labelText: 'Email'),
            ),
            // Поле выбора даты 1
            ListTile(
              title: Text('Дата принятия'),
              subtitle: Text('${date1.toLocal()}'.split(' ')[0]),
              trailing: Icon(Icons.keyboard_arrow_down),
              onTap: () async {
                final DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: date1,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2101),
                );
                if (pickedDate != null && pickedDate != date1)
                  setState(() {
                    date1 = pickedDate;
                  });
              },
            ),
            // Поле выбора даты 2
            ListTile(
              title: Text('Дата увольнения'),
              subtitle: Text('${date2?.toLocal()}'.split(' ')[0]),
              trailing: Icon(Icons.keyboard_arrow_down),
              onTap: () async {
                final DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2101),
                );
                if ( pickedDate != date2)
                  setState(() {
                    date2 = pickedDate;
                  });
              },
            ),
            // Выпадающий список

            DropdownButton<PositionModel>(
              value: selectedPosition,
              onChanged: (PositionModel? newValue) { // Обратите внимание на тип String?
                if (newValue != null) { // Проверка на null
                  setState(() {
                    selectedPosition = newValue;
                  });
                }
              },

              items: positionList.map<DropdownMenuItem<PositionModel>>((PositionModel position) {
                return DropdownMenuItem<PositionModel>(
                  value: position,
                  child: Text(position.name),
                );
              }).toList(),
            ),
            // Кнопка для отправки данных (просто пример)
            ElevatedButton(
              onPressed: () {
                // Здесь можно отправить данные на сервер или выполнить другие действия
                // Используйте значения text1, text2, и так далее
                print('Имя: $text1');
                print('Фамилия: $text2');
                print('Отчество: $text3');
                print('Телефон: $text4');
                print('Email: $text5');
                print('Дата приема: $date1');
                print('Дата увольнения: $date2');
                print('Должность: $selectedPosition');
                EmployeeModel employee = EmployeeModel(id: null,name: text1, surname: text2, secondSurname: text3, beginning: date1, dismissal: date2, phoneNumber: text4, email: text5, positionId: 1);
                employeeService.add("token", employee);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Employee()), // SecondScreen - ваша целевая страница
                );
                // Navigator.pushNamed(context, '/employee',);
                // Future.delayed(Duration.zero, () {});

              },
              child: Text('Отправить данные'),
            ),
          ],
        ),
      ),
    );
  }
}