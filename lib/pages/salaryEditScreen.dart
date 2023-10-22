import 'package:flutter/material.dart';
import 'package:flutter_project/api/apiModel.dart';

import '../api/apiService.dart';

class EditSalaryPopup extends StatefulWidget {
  final SalaryModel salaryModel;

  const EditSalaryPopup({Key? key, required this.salaryModel}) : super(key: key);

  @override
  _EditPopupState createState() => _EditPopupState();
}

class _EditPopupState extends State<EditSalaryPopup> {
  final apiService = ApiService();
  int? id;
  SalaryModel? salary;

  int? text1;

  int? text2;

  TextEditingController textController1 = TextEditingController();
  TextEditingController textController2 = TextEditingController();
  TextEditingController date1Controller = TextEditingController();
  TextEditingController date2Controller = TextEditingController();

  DateTime? date1 = DateTime.now();
  DateTime? date2 = DateTime.now();

  @override
  void initState() {
    super.initState();
    super.initState();
    this.salary = widget.salaryModel;
    final salary = this.salary;
    if (salary != null) {
      text1 = salary.sum;
      text2 = salary.numberOfOrder;
      date1 = salary.dateOfSalary;
      date2 = salary.dateOfOrder;
    }
    initFields();
  }

  Future<void> initFields() async {
    if (salary != null) {
      textController1.text = salary!.sum.toString();
      textController2.text = salary!.numberOfOrder.toString();

      date1Controller.text = '${salary!.dateOfSalary?.toLocal()}'.split(' ')[0];
      date2Controller.text = '${salary!.dateOfOrder?.toLocal()}'.split(' ')[0];
    }
  }



  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Редактировать данные"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: textController1,
            onChanged: (value) {
              setState(() {
                text1 = int.tryParse(value);
              });
            },
            decoration: InputDecoration(labelText: "Текстовое поле 1"),
          ),
          TextFormField(
            controller: textController2,
            onChanged: (value) {
              setState(() {
                text2 = int.tryParse(value);
              });
            },
            decoration: InputDecoration(labelText: "Текстовое поле 2"),
          ),
          ListTile(
            title: Text('Дата 2'),
            subtitle: Text(
                '${date2 != null ? date1?.toLocal() : DateTime.now().toLocal()}'
                    .split(' ')[0]),
            trailing: Icon(Icons.calendar_today),
            onTap: () async {
              final DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: date1 ?? DateTime.now(),
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
            title: Text('Дата 2'),
            subtitle: Text(
                '${date2 != null ? date2?.toLocal() : DateTime.now().toLocal()}'
                    .split(' ')[0]),
            trailing: Icon(Icons.calendar_today),
            onTap: () async {
              final DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: date2 ?? DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2101),
              );
              if (pickedDate != null && pickedDate != date2)
                setState(() {
                  date2 = pickedDate;
                });
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text("Отмена"),
        ),
        ElevatedButton(
          onPressed: () {
            apiService.editSalary(
                SalaryModel(
                    id: salary!.id,
                    sum: text1,
                    dateOfSalary: date1,
                    numberOfOrder: text2,
                    dateOfOrder: date2,
                    employeeId: salary?.employeeId),
                5);
            final result = SalaryModel(
                id: salary!.id,
                sum: text1,
                dateOfSalary: date1,
                numberOfOrder: text2,
                dateOfOrder: date2,
                employeeId: salary?.employeeId);
            Navigator.of(context).pop(result);
          },
          child: Text("Сохранить"),
        ),
      ],
    );
  }
}
