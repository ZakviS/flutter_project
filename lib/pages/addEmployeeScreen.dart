import 'package:flutter/material.dart';
import 'package:flutter_project/api/apiModel.dart';
import 'package:flutter_project/api/apiService.dart';
import 'package:flutter_project/service/positionService.dart';
import 'package:flutter_project/pages/employeeScreen.dart';


class AddEmployee extends StatefulWidget {
  const AddEmployee({super.key});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AddEmployeeState();
  }
}

class AddEmployeeState extends State<AddEmployee> {
  final positionService = PositionService();
  final apiService = ApiService();
  List<PositionModel> positionList = [];
  List<EmployeeModel> employeeList = [];
  PositionModel? selectedPosition;

  @override
  void initState() {
    super.initState();
    fetchDataAndPrintName();
  }

  Future<void> fetchDataAndPrintName() async {
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
  DateTime? date2 = null;

  String dropdownValue = 'Опция 1';

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {

        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) =>
                Employee(),
          ),
        );
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Моя форма'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              TextFormField(
                onChanged: (value) {
                  setState(() {
                    text1 = value;
                  });
                },
                decoration: InputDecoration(labelText: 'Имя'),
              ),
              TextFormField(
                onChanged: (value) {
                  setState(() {
                    text2 = value;
                  });
                },
                decoration: InputDecoration(labelText: 'Фамилия'),
              ),
              TextFormField(
                onChanged: (value) {
                  setState(() {
                    text3 = value;
                  });
                },
                decoration: InputDecoration(labelText: 'Отчество'),
              ),
              TextFormField(
                onChanged: (value) {
                  setState(() {
                    text4 = value;
                  });
                },
                decoration: InputDecoration(labelText: 'Телефон'),
              ),
              TextFormField(
                onChanged: (value) {
                  setState(() {
                    text5 = value;
                  });
                },
                decoration: InputDecoration(labelText: 'Email'),
              ),
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
                  if (pickedDate != date2)
                    setState(() {
                      date2 = pickedDate;
                    });
                },
              ),

              DropdownButton<PositionModel>(
                value: selectedPosition,
                onChanged: (PositionModel? newValue) {
                  if (newValue != null) {
                    setState(() {
                      selectedPosition = newValue;
                    });
                  }
                },
                items: positionList.map<DropdownMenuItem<PositionModel>>(
                    (PositionModel position) {
                  return DropdownMenuItem<PositionModel>(
                    value: position,
                    child: Text(position.name),
                  );
                }).toList(),
              ),
              ElevatedButton(
                onPressed: () {
                  EmployeeModel employee = EmployeeModel(
                      id: null,
                      name: text1,
                      surname: text2,
                      secondSurname: text3,
                      beginning: date1,
                      dismissal: date2,
                      phoneNumber: text4,
                      email: text5,
                      positionId: 1);
                  apiService.addEmployee(employee);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            Employee()),
                  );
                },
                child: Text('Отправить данные'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
