import 'package:flutter/material.dart';
import 'package:flutter_project/api/apiModel.dart';
import 'package:flutter_project/api/apiService.dart';

class EditAllowancePopup extends StatefulWidget {
  final AllowanceModel allowanceModel;

  const EditAllowancePopup({Key? key, required this.allowanceModel}) : super(key: key);

  @override
  _EditPopupState createState() => _EditPopupState();
}

class _EditPopupState extends State<EditAllowancePopup> {
  final apiService = ApiService();
  AllowanceModel? allowance;

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
    this.allowance = widget.allowanceModel;
    final allowance = this.allowance;
    if (allowance != null) {
      text1 = allowance.sum;
      text2 = allowance.numberOfOrder;
      date1 = allowance.dateOfSalary;
      date2 = allowance.dateOfOrder;
    }
    initFields();
  }

  Future<void> initFields() async {
    if (allowance != null) {
      textController1.text = allowance!.sum.toString();
      textController2.text = allowance!.numberOfOrder.toString();

      date1Controller.text =
          '${allowance!.dateOfSalary?.toLocal()}'.split(' ')[0];
      date2Controller.text =
          '${allowance!.dateOfOrder?.toLocal()}'.split(' ')[0];
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
            apiService.editAllowance(
                    AllowanceModel(
                    id: allowance!.id,
                    sum: text1,
                    dateOfSalary: date1,
                    numberOfOrder: text2,
                    dateOfOrder: date2,
                    employeeId: allowance?.employeeId),
                5);
            final result = AllowanceModel(
                id: allowance!.id,
                sum: text1,
                dateOfSalary: date1,
                numberOfOrder: text2,
                dateOfOrder: date2,
                employeeId: allowance?.employeeId);
            Navigator.of(context).pop(result);
          },
          child: Text("Сохранить"),
        ),
      ],
    );
  }
}
