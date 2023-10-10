
import 'package:flutter/material.dart';
import 'package:flutter_project/Model/AllowanceModel.dart';
import 'package:flutter_project/Model/SalaryModel.dart';
import 'package:flutter_project/Service/allowanceService.dart';
import 'package:flutter_project/Service/salaryService.dart';

class EditAllowancePopup extends StatefulWidget {

  final int? id;
  const EditAllowancePopup({Key? key, required this.id}) : super(key: key);


  @override
  _EditPopupState createState() => _EditPopupState();
}

class _EditPopupState extends State<EditAllowancePopup> {
  final allowanceService = AllowanceService();
  int? id;
  AllowanceModel? allowance;

  int? text1 ;
  int? text2 ;

  TextEditingController textController1 = TextEditingController();
  TextEditingController textController2 = TextEditingController();
  TextEditingController date1Controller = TextEditingController();
  TextEditingController date2Controller = TextEditingController();

  DateTime? date1 = DateTime.now();
  DateTime? date2 = DateTime.now();


  @override
  void initState() {
    super.initState();
    id = widget.id;
    initFields();
    // fetchDataAndPrintName();


  }

  Future<void> initFields() async {
    await fetchDataAndPrintName();
    if (allowance != null) {
      textController1.text = allowance!.sum.toString();
      textController2.text = allowance!.numbOfOrder.toString();

      date1Controller.text = '${allowance!.dateOfSalary?.toLocal()}'.split(' ')[0];
      date2Controller.text = '${allowance!.dateOfOrder?.toLocal()}'.split(' ')[0];
    }
  }

  Future<void> fetchDataAndPrintName() async {
    await allowanceService.loadAllowance(id);

    // salaryList.clear();

    setState(() {
      this.allowance = allowanceService.getAllowance(id!);
      // print(salary?.sum);
    });


    final allowance = this.allowance;
    if (allowance != null) {
      text1 = allowance.sum;
      text2 = allowance.numbOfOrder;
      date1 = allowance.dateOfSalary;
      date2 = allowance.dateOfOrder ;
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
            subtitle: Text('${date2 != null ? date1?.toLocal() : DateTime.now().toLocal()}'.split(' ')[0]),
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
            subtitle: Text('${date2 != null ? date2?.toLocal() : DateTime.now().toLocal()}'.split(' ')[0]),
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
            // Обработчик нажатия на кнопку отмены
            Navigator.of(context).pop(); // Закрыть всплывающее окно
          },
          child: Text("Отмена"),
        ),
        ElevatedButton(
          onPressed: () {
            // Обработчик нажатия на кнопку сохранения
            allowanceService.edit("token", AllowanceModel(id: allowance!.id, sum: text1, dateOfSalary: date1, numbOfOrder: text2, dateOfOrder: date2, employeeId: allowance?.employeeId), 5);
            final result = SalaryModel(id: allowance!.id, sum: text1, dateOfSalary: date1, numbOfOrder: text2, dateOfOrder: date2, employeeId: allowance?.employeeId);
            Navigator.of(context).pop(result);

          },
          child: Text("Сохранить"),
        ),
      ],
    );
  }
}
