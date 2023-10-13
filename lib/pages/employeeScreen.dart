import 'package:flutter/material.dart';
import 'package:flutter_project/Model/EmployeeModel.dart';
import 'package:flutter_project/Model/EmployeeResponse.dart';
import 'package:flutter_project/Model/EmployeeSearchModel.dart';
import 'package:flutter_project/Model/PositionModel.dart';
import 'package:flutter_project/Service/employeeService.dart';
import 'package:flutter_project/Service/positionService.dart';
import 'package:flutter_project/pages/addEmployeeScreen.dart';


import '../main.dart';
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

  TextEditingController searchController = TextEditingController();
  String filter = '';
  bool hideDismissed = false; // Изначально не скрываем уволенных


  final ScrollController _scrollController = ScrollController();
  // EmployeeSearchModel
  int page = 0;
  bool isLoading = false;

  // int count = 0;
  // int pageSize = 5;
  // EmployeeSearchModel(surname: '', working: false, page: 0,  elementPerPage: 5,  direction: "dsc",  key: "surname");


  @override
  void initState(){
    super.initState();
    employeeList = <EmployeeModel>[];
    positionList = <PositionModel>[];
    fetchDataAndPrintName();
    loadNextPage(page,"",hideDismissed);

    _scrollController.addListener(() {
      if (_scrollController.position.atEdge) {
        if (_scrollController.position.pixels == 0) {
          // Верхний край списка
          print("asd");
        } else {
          // Нижний край списка
          print("object");
          loadNextPage(page,"",hideDismissed); // Загрузка следующей страницы данных
        }
      }
    });
  }

  void onSearchTextChanged(String text) {
    setState(() {
      filter = text;
      employeeList.clear();
      page = 0;
      loadNextPage(page,filter,hideDismissed);
    });
  }


  Future<void> loadNextPage(int page,String surname,bool work) async {
    if (!isLoading) {
      // Устанавливаем isLoading в true, чтобы предотвратить дополнительные запросы
      isLoading = true;

      // Здесь вы можете выполнить запрос к серверу для загрузки следующей страницы данных
      try {
        EmployeeResponse newData = await employeeService.searchEmployee(EmployeeSearchModel(
            surname: surname,
            working: work,
            page: page,
            elementPerPage: 12,
            direction: "dsc",
            key: "surname")); // Загружаем новые данные, замените на вашу логику

        setState(() {
          employeeList.addAll(newData.employee); // Добавляем новые данные к текущему списку
          this.page++;
        });
      } catch (error) {
        print("Error loading next page: $error");
      } finally {
        // Устанавливаем isLoading обратно в false, чтобы разрешить следующий запрос
        isLoading = false;
      }
    }
  }


  Future<void> fetchDataAndPrintName() async {
    // await employeeService.loadEmployee();
    await positionService.loadPosition();

    setState(() {
      // employeeList.addAll(employeeService.getEmployeeList());
      positionList.addAll(positionService.getPositionList());
    });
  }


  @override
  Widget build(BuildContext context) {


    return WillPopScope(
      onWillPop: () async {
        // Ваш код для определения действия при нажатии кнопки "назад"
        // Например, перенаправление на определенный экран:
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => AppBarApp(), // Замените YourTargetScreen на целевой экран
          ),
        );
        // Возвращаем false, чтобы предотвратить обычное закрытие экрана "назад"
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Штат'),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: 'Поиск...',
                  border: OutlineInputBorder(),
                ),
                onChanged: onSearchTextChanged,
              ),
            ),
            CheckboxListTile(
              title: Text('Скрыть уволенных:'),
              value: hideDismissed,
              onChanged: (newValue) {
                setState(() {
                  hideDismissed = newValue!;
                  // В этом месте вы можете обновить список сотрудников, основываясь на значении hideDismissed
                  print(hideDismissed);
                  employeeList.clear();
                  page = 0;
                  loadNextPage(page, searchController.text, hideDismissed);
                });
              },
            ),
            Expanded(
              child: ListView.builder(
            controller: _scrollController,
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
            } //item
        ),
      ),
      ],
    ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blue,
          onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => addEmployee()), // SecondScreen - ваша целевая страница
            );

          },
          child: Icon(
            Icons.add,

          ),
        ),

      )

    );


  }
  
}