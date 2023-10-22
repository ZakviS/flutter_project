import 'package:flutter/material.dart';
import 'package:flutter_project/api/apiModel.dart';
import 'package:flutter_project/service/positionService.dart';

import 'package:flutter_project/pages/employeeScreen.dart';
import 'package:flutter_project/pages/premiumEditScreen.dart';
import 'package:flutter_project/pages/salaryEditScreen.dart';

import '../api/apiService.dart';
import 'allowanceEditScreen.dart';

class EditEmployeeScreen extends StatefulWidget {
  final EmployeeModel employee;

  const EditEmployeeScreen({Key? key, required this.employee})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return EditEmployeeState();
  }
}

class EditEmployeeState extends State<EditEmployeeScreen> {
  final positionService = PositionService();
  final apiService = ApiService();


  List<PositionModel> positionList = [];
  List<SalaryModel> salaryList = [];
  List<PremiumModel> premiumList = [];
  List<AllowanceModel> allowanceList = [];
  PositionModel? selectedPosition ;
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
  DateTime? date2 = null;

  String salarySum = '';
  String salaryNumb = '';
  DateTime dateOfSalary = DateTime.now();
  DateTime? dateOfSalOrder = DateTime.now();

  String premiumSum = '';
  String premiumNumb = '';
  DateTime dateOfPremium = DateTime.now();
  DateTime? dateOfPremOrder = DateTime.now();

  String allowanceSum = '';
  String allowanceNumb = '';
  DateTime dateOfAllowance = DateTime.now();
  DateTime? dateOfAllowOrder = DateTime.now();

  TextEditingController salarySumController = TextEditingController();
  DateTime salaryDateController = DateTime.now();
  TextEditingController salaryNumbController = TextEditingController();
  DateTime salaryDateOrderController = DateTime.now();

  TextEditingController allowanceSumController = TextEditingController();
  DateTime allowanceDateController = DateTime.now();
  TextEditingController allowanceNumbController = TextEditingController();
  DateTime allowanceDateOrderController = DateTime.now();

  TextEditingController premiumSumController = TextEditingController();
  DateTime premiumDateController = DateTime.now();
  TextEditingController premiumNumbController = TextEditingController();
  DateTime premiumDateOrderController = DateTime.now();

  @override
  void initState() {
    super.initState();
    employee = widget.employee;
    selectedPosition = positionService.getPosition(employee!.positionId);
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
      beginningFieldController.text =
          '${employee!.beginning.toLocal()}'.split(' ')[0];
      dismissalFieldController.text =
          '${employee!.dismissal?.toLocal()}'.split(' ')[0];
    }
  }

  Future<void> fetchDataAndPrintName() async {

    positionList.clear();

    setState(() {
      positionList.addAll(positionService.getPositionList());
    });

    final employee = this.employee;


    allowanceList = await apiService.getAllowance(employee?.id);
    salaryList =  await apiService.getSalary(employee?.id);
    premiumList = await apiService.getPremium(employee?.id);

    if (employee != null) {
      text1 = employee.name;
      text2 = employee.secondSurname;
      text3 = employee.surname;
      text4 = employee.phoneNumber;
      text5 = employee.email;
      date1 = DateTime.now();
      date2 = employee.dismissal;
    }
  }

  void deleteAllowanceAndUpdateScreen(int? allowanceId) {
    // Выполните удаление элемента из списка
    allowanceList.removeWhere((allowance) => allowance.id == allowanceId);

    // Вызов setState, чтобы перерисовать экран
    setState(() {});
  }


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
          title: const Text('Моя форма'),
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
                  controller: beginningFieldController,
                  // Свяжите контроллер с TextFormField
                  onChanged: (value) {
                    // Обработка изменений в текстовом поле, если необходимо
                  },
                  decoration: InputDecoration(
                    hintText: '${date1.toLocal()}'
                        .split(' ')[0], // Начальное значение или подсказка
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
                  controller: dismissalFieldController,
                  // Свяжите контроллер с TextFormField
                  onChanged: (value) {
                    // Обработка изменений в текстовом поле, если необходимо
                  },
                  decoration: InputDecoration(
                    hintText: '${date2?.toLocal()}'
                        .split(' ')[0], // Начальное значение или подсказка
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
                  if (pickedDate != date2)
                    setState(() {
                      date2 = pickedDate;
                    });
                },
              ),
              // Выпадающий список
              DropdownButton<PositionModel>(
                value: selectedPosition,

                onChanged: (PositionModel? newValue) {
                  if (newValue != null && newValue != positionService.getPosition(employee!.positionId)) {
                    print(newValue.name);
                    setState(() {
                      selectedPosition = newValue;
                      print(selectedPosition?.name);
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

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                Employee()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey,
                    ),
                    child: Text('Отмена'),
                  ),
                  SizedBox(width: 30),
                  ElevatedButton(
                    onPressed: () {

                      EmployeeModel employee = EmployeeModel(
                          id: this.employee?.id,
                          name: text1,
                          surname: text2,
                          secondSurname: text3,
                          beginning: date1,
                          dismissal: date2,
                          phoneNumber: text4,
                          email: text5,
                          positionId: selectedPosition!.id);
                      apiService.editEmployee( employee, 5);
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

              //salary
              SizedBox(height: 30),
              const Text(
                "Зарплата",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 2 - 24,
                    child: TextFormField(
                      controller: salarySumController,
                      onChanged: (value) {
                        setState(() {
                          salarySum = value;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'Сумма зарплаты',
                      ),
                    ),
                  ),
                  SizedBox(width: 16.0),
                  Container(
                    width: MediaQuery.of(context).size.width / 2 - 24,
                    child: GestureDetector(
                      onTap: () async {
                        final DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101),
                        );
                        if (pickedDate != dateOfSalary) {
                          setState(() {
                            dateOfSalary = pickedDate!;
                            salaryDateController = pickedDate!;
                          });
                        }
                      },
                      child: ListTile(
                        title: Text('Дата зарплаты'),
                        subtitle: Text(
                            '${salaryDateController.toLocal()}'.split(' ')[0]),
                        trailing: Icon(Icons.calendar_today),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 2 - 24,
                    child: TextFormField(
                      controller: salaryNumbController,
                      onChanged: (value) {
                        setState(() {
                          salaryNumb = value;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'Введите текст',
                      ),
                    ),
                  ),
                  SizedBox(width: 16.0),
                  Container(
                    width: MediaQuery.of(context).size.width / 2 - 24,
                    child: GestureDetector(
                      onTap: () async {
                        final DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101),
                        );
                        if (pickedDate != dateOfSalOrder) {
                          setState(() {
                            dateOfSalOrder = pickedDate!;
                            salaryDateOrderController = pickedDate;
                          });
                        }
                      },
                      child: ListTile(
                        title: Text('Дата принятия'),
                        subtitle: Text('${salaryDateOrderController.toLocal()}'
                            .split(' ')[0]),
                        trailing: Icon(Icons.calendar_today),
                      ),
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  apiService.addSalary(
                          SalaryModel(
                          id: null,
                          sum: int.tryParse(salarySum),
                          dateOfSalary: dateOfSalary,
                          numberOfOrder: int.tryParse(salaryNumb),
                          dateOfOrder: dateOfSalOrder,
                          employeeId: employee?.id));

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            Employee()),
                  );
                },
                child: Text('Отправить данные'),
              ),
              PopupMenuButton<String>(
                onSelected: (String value) {

                },
                itemBuilder: (BuildContext context) {
                  return salaryList.map((SalaryModel salary) {
                    return PopupMenuItem<String>(
                      value: salary.numberOfOrder.toString(),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("номер приказа: " +
                              salary.numberOfOrder.toString()),
                          Row(
                            children: [
                              IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () async {
                                  final SalaryModel result = await showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return EditSalaryPopup(salaryModel: salary);
                                    },
                                  );
                                  if (result != null) {
                                    setState(() {
                                      salary.sum = result.sum;
                                      salary.numberOfOrder = result.numberOfOrder;
                                      salary.dateOfSalary = result.dateOfSalary;
                                      salary.dateOfOrder = result.dateOfOrder;

                                      // ... остальные данные ...
                                    });
                                  }
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.delete), // Кнопка удаления
                                onPressed: () {
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }).toList();
                },
                child: Text("Посмотреть историю"),
              ),

              //premium
              SizedBox(height: 30),
              const Text(
                "Премия",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 2 - 24,
                    child: TextFormField(
                      controller: premiumSumController,
                      onChanged: (value) {
                        setState(() {
                          premiumSum = value;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'Сумма премии',
                      ),
                    ),
                  ),
                  SizedBox(width: 16.0),
                  Container(
                    width: MediaQuery.of(context).size.width / 2 - 24,
                    child: GestureDetector(
                      onTap: () async {
                        final DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101),
                        );
                        if (pickedDate != dateOfPremium) {
                          setState(() {
                            dateOfPremium = pickedDate!;
                            premiumDateController = pickedDate!;
                          });
                        }
                      },
                      child: ListTile(
                        title: Text('Дата премии'),
                        subtitle: Text(
                            '${premiumDateController.toLocal()}'.split(' ')[0]),
                        trailing: Icon(Icons.calendar_today),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 2 - 24,
                    child: TextFormField(
                      controller: premiumNumbController,
                      onChanged: (value) {
                        setState(() {
                          premiumNumb = value;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'Введите текст',
                      ),
                    ),
                  ),
                  SizedBox(width: 16.0),
                  Container(
                    width: MediaQuery.of(context).size.width / 2 - 24,
                    child: GestureDetector(
                      onTap: () async {
                        final DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101),
                        );
                        if (pickedDate != dateOfPremOrder)
                          setState(() {
                            dateOfPremOrder = pickedDate!;
                            premiumDateOrderController = pickedDate;
                          });
                      },
                      child: ListTile(
                        title: Text('Дата принятия'),
                        subtitle: Text('${premiumDateOrderController.toLocal()}'
                            .split(' ')[0]),
                        trailing: Icon(Icons.calendar_today),
                      ),
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  print('Имя: $premiumSum');
                  print('Фамилия: $premiumNumb');
                  print('Отчество: $dateOfPremium');
                  print('Телефон: $dateOfPremOrder');

                  apiService.addPremium(
                      PremiumModel(
                          id: null,
                          sum: int.tryParse(premiumSum),
                          dateOfSalary: dateOfPremium,
                          numberOfOrder: int.tryParse(premiumNumb),
                          dateOfOrder: dateOfPremOrder,
                          employeeId: employee?.id));

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            Employee()),
                  );

                },
                child: Text('Отправить данные'),
              ),
              PopupMenuButton<String>(
                onSelected: (String value) {
                },
                itemBuilder: (BuildContext context) {
                  return premiumList.map((PremiumModel premium) {
                    return PopupMenuItem<String>(
                      value: premium.numberOfOrder.toString(),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("номер приказа: " +
                              premium.numberOfOrder.toString()),
                          Row(
                            children: [
                              IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () async {
                                  final PremiumModel result = await showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return EditPremiumPopup(premiumModel: premium);
                                    },
                                  );
                                  if (result != null) {
                                    setState(() {
                                      premium.sum = result.sum;
                                      premium.numberOfOrder = result.numberOfOrder;
                                      premium.dateOfSalary =
                                          result.dateOfSalary;
                                      premium.dateOfOrder = result.dateOfOrder;

                                    });
                                  }
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () {
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }).toList();
                },
                child: Text("Посмотреть историю"), // Текст кнопки
              ),

              //allowance
              SizedBox(height: 30),
              const Text(
                "Надбавка",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 2 - 24,
                    child: TextFormField(
                      controller: allowanceSumController,
                      onChanged: (value) {
                        setState(() {
                          allowanceSum = value;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'Сумма премии',
                      ),
                    ),
                  ),
                  SizedBox(width: 16.0),
                  Container(
                    width: MediaQuery.of(context).size.width / 2 - 24,
                    child: GestureDetector(
                      onTap: () async {
                        final DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101),
                        );
                        if (pickedDate != dateOfAllowance) {
                          setState(() {
                            dateOfAllowance = pickedDate!;
                            allowanceDateController = pickedDate!;
                          });
                        }
                      },
                      child: ListTile(
                        title: Text('Дата премии'),
                        subtitle: Text('${allowanceDateController.toLocal()}'
                            .split(' ')[0]),
                        trailing: Icon(Icons.calendar_today),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 2 - 24,
                    child: TextFormField(
                      controller: allowanceNumbController,
                      onChanged: (value) {
                        setState(() {
                          allowanceNumb = value;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'Введите текст',
                      ),
                    ),
                  ),
                  SizedBox(width: 16.0),
                  Container(
                    width: MediaQuery.of(context).size.width / 2 - 24,
                    child: GestureDetector(
                      onTap: () async {
                        final DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101),
                        );
                        if (pickedDate != dateOfAllowOrder) {
                          setState(() {
                            dateOfAllowOrder = pickedDate!;
                            allowanceDateOrderController = pickedDate;
                          });
                        }
                      },
                      child: ListTile(
                        title: Text('Дата принятия'),
                        subtitle: Text(
                            '${allowanceDateOrderController.toLocal()}'
                                .split(' ')[0]),
                        trailing: Icon(Icons.calendar_today),
                      ),
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  apiService.addAllowance(
                          AllowanceModel(
                          id: null,
                          sum: int.tryParse(allowanceSum),
                          dateOfSalary: dateOfAllowance,
                          numberOfOrder: int.tryParse(allowanceNumb),
                          dateOfOrder: dateOfAllowOrder,
                          employeeId: employee?.id));

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            Employee()),
                  );
                },
                child: Text('Отправить данные'),
              ),
              PopupMenuButton<String>(
                onSelected: (String value) {
                },
                itemBuilder: (BuildContext context) {
                  return allowanceList.map((AllowanceModel allowance) {
                    return PopupMenuItem<String>(
                      value: allowance.numberOfOrder.toString(),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("номер приказа: " +
                              allowance.numberOfOrder.toString()),
                          Row(
                            children: [
                              IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () async {
                                  final AllowanceModel result = await showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return EditAllowancePopup(
                                          allowanceModel: allowance /*employee?.id,*/);
                                    },
                                  );
                                  if (result != null) {

                                    setState(() {

                                      allowance.sum = result.sum;
                                      allowance.numberOfOrder =
                                          result.numberOfOrder;
                                      allowance.dateOfSalary =
                                          result.dateOfSalary;
                                      allowance.dateOfOrder =
                                          result.dateOfOrder;

                                    });
                                  }
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.delete), // Кнопка удаления
                                onPressed: () async {
                                  apiService.deleteAllowance(allowance.id);
                                  deleteAllowanceAndUpdateScreen(allowance.id);

                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }).toList();
                },
                child: Text("Посмотреть историю"), // Текст кнопки
              )
            ],
          ),
        ),
      ),
    );
  }
}
