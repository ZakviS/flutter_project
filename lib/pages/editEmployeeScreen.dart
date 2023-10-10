
import 'package:flutter/material.dart';
import 'package:flutter_project/Model/PositionModel.dart';
import 'package:flutter_project/Model/EmployeeModel.dart';
import 'package:flutter_project/Model/SalaryModel.dart';
import 'package:flutter_project/Service/PremiumService.dart';
import 'package:flutter_project/Service/employeeService.dart';
import 'package:flutter_project/Service/positionService.dart';
import 'package:flutter_project/Service/salaryService.dart';
import 'package:flutter_project/pages/employeeScreen.dart';
import 'package:flutter_project/pages/premiumEditScreen.dart';
import 'package:flutter_project/pages/salaryEditScreen.dart';



import '../Model/PremiumModel.dart';


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
  final salaryService = SalaryService();
  final premiumService = PremiumService();

  List<PositionModel> positionList = [];
  List<SalaryModel> salaryList = [];
  List<PremiumModel> premiumList = [];
  PositionModel? selectedPosition;
  EmployeeModel? employee;

  //контроллеры для подставления текста в поля
  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController secondSurnameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController beginningFieldController = TextEditingController();
  TextEditingController dismissalFieldController = TextEditingController();
  TextEditingController positionFieldController = TextEditingController();


  //поля для сохранения сотрудников
  String text1 = '';
  String text2 = '';
  String text3 = '';
  String text4 = '';
  String text5 = '';
  DateTime date1 = DateTime.now();
  DateTime? date2 = null ;



  String salarySum = '';
  String salaryNumb = '';
  DateTime dateOfSalary = DateTime.now();
  DateTime? dateOfSalOrder = DateTime.now() ;

  String premiumSum = '';
  String premiumNumb = '';
  DateTime dateOfPremium = DateTime.now();
  DateTime? dateOfPremOrder = DateTime.now() ;

  TextEditingController salarySumController = TextEditingController();
  DateTime salaryDateController = DateTime.now();
  TextEditingController salaryNumbController = TextEditingController();
  DateTime salaryDateOrderController = DateTime.now();

  TextEditingController premiumSumController = TextEditingController();
  DateTime premiumDateController = DateTime.now();
  TextEditingController premiumNumbController = TextEditingController();
  DateTime premiumDateOrderController = DateTime.now();


  @override
  void initState() {
    super.initState();
    employee = widget.employee;
    // fetchDataAndPrintName();
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
    await positionService.loadPosition();

    positionList.clear();
    // salaryList.clear();

    setState(() {
      positionList.addAll(positionService.getPositionList());

    });

    final employee = this.employee;
    await salaryService.loadSalary(employee?.id);
    await premiumService.loadPremium(employee?.id);


    premiumList.addAll(premiumService.getPremiumList());
    salaryList.addAll(salaryService.getSalaryList());
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
                  hintText: '${date2?.toLocal()}'.split(' ')[0], // Начальное значение или подсказка
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

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Employee()), // SecondScreen - ваша целевая страница
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey, // Устанавливаем цвет кнопки
                  ),
                  child: Text('Отмена'),
                ),
                SizedBox(width: 30),
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
                 // Пространство между кнопками

              ],
            ),



            SizedBox(height: 16),
            const Text(
              "Зарплата",
              // Указываем стиль текста с увеличенным размером шрифта
              style: TextStyle(
                fontSize: 15, // Устанавливаем размер шрифта в пунктах
                fontWeight: FontWeight.bold, // Жирный стиль текста (по желанию)
                // Другие настройки стиля текста, если необходимо
              ),
            ),

        Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width/2-24, // Установите желаемую фиксированную ширину
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
            SizedBox(width: 16.0),// Добавьте отступ между элементами
            Container(
              width: MediaQuery.of(context).size.width/2-24, // Установите желаемую фиксированную ширину
              child: GestureDetector(

                onTap: () async {
                  final DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if ( pickedDate != dateOfSalary)
                    setState(() {
                      dateOfSalary = pickedDate!;
                      salaryDateController = pickedDate!;
                    });
                },
                child: ListTile(
                  title: Text('Дата зарплаты'),
                  subtitle: Text('${salaryDateController.toLocal()}'.split(' ')[0]),
                  trailing: Icon(Icons.calendar_today),
                ),
              ),
            ),

          ],
        ),
            Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width/2-24, // Установите желаемую фиксированную ширину
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
                SizedBox(width: 16.0),// Добавьте отступ между элементами
                Container(
                  width: MediaQuery.of(context).size.width/2-24, // Установите желаемую фиксированную ширину
                  child: GestureDetector(

                    onTap: () async {
                      final DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101),
                      );
                      if ( pickedDate != dateOfSalOrder)
                        setState(() {
                          dateOfSalOrder = pickedDate!;
                          salaryDateOrderController = pickedDate;
                        });
                    },
                    child: ListTile(
                      title: Text('Дата принятия'),
                      subtitle: Text('${salaryDateOrderController.toLocal()}'.split(' ')[0]),
                      trailing: Icon(Icons.calendar_today),
                    ),
                  ),
                ),

              ],
            ),
            ElevatedButton(
              onPressed: () {
                // Здесь можно отправить данные на сервер или выполнить другие действия
                // Используйте значения text1, text2, и так далее
                print('Имя: $salarySum');
                print('Фамилия: $salaryNumb');
                print('Отчество: $dateOfSalary');
                print('Телефон: $dateOfSalOrder');

                salaryService.add("token", SalaryModel(id: null, sum: int.tryParse(salarySum), dateOfSalary: dateOfSalary, numbOfOrder: int.tryParse(salaryNumb), dateOfOrder: dateOfSalOrder, employeeId: employee?.id));

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Employee()), // SecondScreen - ваша целевая страница
                );
                // Navigator.pushNamed(context, '/employee',);
                // Future.delayed(Duration.zero, () {});

              },
              child: Text('Отправить данные'),
            ),
            PopupMenuButton<String>(
              onSelected: (String value) {
                // setState(() {
                //   selectedValue = value; // Обновляем выбранное значение
                // });
              },
              itemBuilder: (BuildContext context) {
                return salaryList.map((SalaryModel salary) {
                  return PopupMenuItem<String>(
                    value: salary.numbOfOrder.toString(), // Предположим, что у SalaryModel есть поле someValue
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("номер приказа: " + salary.numbOfOrder.toString() ), // Отображаем название элемента
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit), // Кнопка редактирования
                              onPressed: () async {
                                final SalaryModel result = await showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return EditSalaryPopup(id: employee?.id);
                                  },
                                );
                                if (result != null) {
                                  // Вот ваш код после закрытия всплывающего окна с результатом.
                                  // Например, можно обновить состояние родительского виджета с полученными данными.
                                  setState(() {
                                    // Обновите состояние с полученными данными из всплывающего окна.
                                    // Например, вы можете использовать эти данные для перерисовки или обновления виджета.
                                    salary.sum = result.sum;
                                    salary.numbOfOrder = result.numbOfOrder;
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
                                // Обработчик нажатия на кнопку удаления
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

            //premium
            SizedBox(height: 16),
            const Text(
              "Премия",
              // Указываем стиль текста с увеличенным размером шрифта
              style: TextStyle(
                fontSize: 15, // Устанавливаем размер шрифта в пунктах
                fontWeight: FontWeight.bold, // Жирный стиль текста (по желанию)
                // Другие настройки стиля текста, если необходимо
              ),
            ),
            Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width/2-24, // Установите желаемую фиксированную ширину
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
                SizedBox(width: 16.0),// Добавьте отступ между элементами
                Container(
                  width: MediaQuery.of(context).size.width/2-24, // Установите желаемую фиксированную ширину
                  child: GestureDetector(

                    onTap: () async {
                      final DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101),
                      );
                      if ( pickedDate != dateOfPremium)
                        setState(() {
                          dateOfPremium = pickedDate!;
                          premiumDateController = pickedDate!;
                        });
                    },
                    child: ListTile(
                      title: Text('Дата премии'),
                      subtitle: Text('${premiumDateController.toLocal()}'.split(' ')[0]),
                      trailing: Icon(Icons.calendar_today),
                    ),
                  ),
                ),

              ],
            ),
            Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width/2-24, // Установите желаемую фиксированную ширину
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
                SizedBox(width: 16.0),// Добавьте отступ между элементами
                Container(
                  width: MediaQuery.of(context).size.width/2-24, // Установите желаемую фиксированную ширину
                  child: GestureDetector(

                    onTap: () async {
                      final DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101),
                      );
                      if ( pickedDate != dateOfPremOrder)
                        setState(() {
                          dateOfPremOrder = pickedDate!;
                          premiumDateOrderController = pickedDate;
                        });
                    },
                    child: ListTile(
                      title: Text('Дата принятия'),
                      subtitle: Text('${premiumDateOrderController.toLocal()}'.split(' ')[0]),
                      trailing: Icon(Icons.calendar_today),
                    ),
                  ),
                ),

              ],
            ),
            ElevatedButton(
              onPressed: () {
                // Здесь можно отправить данные на сервер или выполнить другие действия
                // Используйте значения text1, text2, и так далее
                print('Имя: $premiumSum');
                print('Фамилия: $premiumNumb');
                print('Отчество: $dateOfPremium');
                print('Телефон: $dateOfPremOrder');

                salaryService.add("token", SalaryModel(id: null, sum: int.tryParse(premiumSum), dateOfSalary: dateOfPremium, numbOfOrder: int.tryParse(premiumNumb), dateOfOrder: dateOfPremOrder, employeeId: employee?.id));

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Employee()), // SecondScreen - ваша целевая страница
                );
                // Navigator.pushNamed(context, '/employee',);
                // Future.delayed(Duration.zero, () {});

              },
              child: Text('Отправить данные'),
            ),
            PopupMenuButton<String>(
              onSelected: (String value) {
                // setState(() {
                //   selectedValue = value; // Обновляем выбранное значение
                // });
              },
              itemBuilder: (BuildContext context) {
                return premiumList.map((PremiumModel premium) {
                  return PopupMenuItem<String>(
                    value: premium.numbOfOrder.toString(), // Предположим, что у SalaryModel есть поле someValue
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("номер приказа: " + premium.numbOfOrder.toString() ), // Отображаем название элемента
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit), // Кнопка редактирования
                              onPressed: () async {
                                final PremiumModel result = await showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return EditPremiumPopup(id: employee?.id);
                                  },
                                );
                                if (result != null) {
                                  // Вот ваш код после закрытия всплывающего окна с результатом.
                                  // Например, можно обновить состояние родительского виджета с полученными данными.
                                  setState(() {
                                    // Обновите состояние с полученными данными из всплывающего окна.
                                    // Например, вы можете использовать эти данные для перерисовки или обновления виджета.
                                    premium.sum = result.sum;
                                    premium.numbOfOrder = result.numbOfOrder;
                                    premium.dateOfSalary = result.dateOfSalary;
                                    premium.dateOfOrder = result.dateOfOrder;

                                    // ... остальные данные ...
                                  });
                                }
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.delete), // Кнопка удаления
                              onPressed: () {
                                // Обработчик нажатия на кнопку удаления
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
    );
  }
}