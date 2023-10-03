
import 'package:flutter/material.dart';
import 'package:flutter_project/Model/PositionModel.dart';
import 'package:flutter_project/Model/EmployeeModel.dart';
import 'package:flutter_project/Model/EmployeeSearchModel.dart';
import 'package:flutter_project/Service/employeeService.dart';
import 'package:flutter_project/Service/positionService.dart';
import 'package:flutter_project/pages/employeeScreen.dart';


import 'dart:convert';
import 'package:http/http.dart' as http;


class editEmployeeScreen extends StatefulWidget {
  final EmployeeModel employee;

  const editEmployeeScreen({Key? key, required this.employee}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return editEmployeeState();
  }
}



class editEmployeeState extends State<editEmployeeScreen> {
  final employeeService = EmployeeService();
  final positionService = PositionService();
  List<PositionModel> positionList = [];
  PositionModel? selectedPosition;
  EmployeeModel? employee;

  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController secondSurnameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController beginningFieldController = TextEditingController();
  TextEditingController dismissalFieldController = TextEditingController();
  TextEditingController positionFieldController = TextEditingController();



  String text1 = '';
  String text2 = '';
  String text3 = '';
  String text4 = '';
  String text5 = '';
  DateTime date1 = DateTime.now();
  DateTime? date2 = null ;


  @override
  void initState() {
    super.initState();
    employee = widget.employee;
    fetchDataAndPrintName();
    initFields();

  }

  Future<void> initFields() async {
    await fetchDataAndPrintName();
    if (employee != null) {
      nameController.text = employee!.name;
      surnameController.text = employee!.surname;
      secondSurnameController.text = employee!.secondSurname;
      phoneNumberController.text = employee!.phoneNumber;
      emailController.text = employee!.email;
      beginningFieldController.text = '${employee!.beginning.toLocal()}'.split(' ')[0];
      dismissalFieldController.text = '${employee!.dismissal?.toLocal()}'.split(' ')[0];
      selectedPosition = positionService.getPosition(employee!.positionId);
    }
  }

  Future<void> fetchDataAndPrintName() async {
    await positionService.fetchData("token");

    positionList.clear();

    setState(() {
      positionList.addAll(positionService.getPositionList());
    });

    final employee = this.employee;
    if (employee != null) {
       text1 = employee.name;
       text2 = employee.secondSurname;
       text3 = employee.surname;
       text4 = employee.phoneNumber;
       text5 = employee.email;
       date1 = DateTime.now();
       date2 = employee.dismissal ;
    }
  }




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
            controller: nameController,
              onChanged: (value) {
                setState(() {
                  text1 = value;
                });
              },
              decoration: InputDecoration(labelText: 'Имя'),
            ),
            // Поле ввода текста 2
            TextFormField(
              controller: surnameController,
              onChanged: (value) {
                setState(() {
                  text2 = value;
                });
              },
              decoration: InputDecoration(labelText: 'Фамилия'),
            ),
            // Поле ввода текста 3
            TextFormField(
              controller: secondSurnameController,
              onChanged: (value) {
                setState(() {
                  text3 = value;
                });
              },
              decoration: InputDecoration(labelText: 'Отчество'),
            ),
            // Поле ввода текста 4
            TextFormField(
              controller: phoneNumberController,
              onChanged: (value) {
                setState(() {
                  text4 = value;
                });
              },
              decoration: InputDecoration(labelText: 'Телефон'),
            ),
            // Поле ввода текста 5
            TextFormField(
              controller: emailController,
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
              subtitle: TextFormField(
                controller: beginningFieldController, // Свяжите контроллер с TextFormField
                onChanged: (value) {
                  // Обработка изменений в текстовом поле, если необходимо
                },
                decoration: InputDecoration(
                  hintText: '${date1.toLocal()}'.split(' ')[0], // Начальное значение или подсказка
                  // Другие настройки внешнего вида, если необходимо
                ),
              ),
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
              subtitle: TextFormField(
                controller: dismissalFieldController, // Свяжите контроллер с TextFormField
                onChanged: (value) {
                  // Обработка изменений в текстовом поле, если необходимо
                },
                decoration: InputDecoration(
                  hintText: '${date1.toLocal()}'.split(' ')[0], // Начальное значение или подсказка
                  // Другие настройки внешнего вида, если необходимо
                ),
              ),
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
                print(selectedPosition?.id);
                // EmployeeModel employee = EmployeeModel(id: 1,name: text1, surname: text2, secondSurname: text3, beginning: date1, dismissal: date2, phoneNumber: text4, email: text5, positionId: selectedPosition!.id);
                // employeeService.add("token", employee);
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