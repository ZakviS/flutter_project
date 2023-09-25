import 'package:flutter/material.dart';
import 'package:flutter_project/pages/employeeScreen.dart';
import 'package:flutter_project/pages/projectScreen.dart';
import 'package:flutter_project/Service/employeeService.dart';
import 'package:flutter_localizations/flutter_localizations.dart';



import 'dart:convert' as convert;

import 'package:http/http.dart' as http;

/// Flutter code sample for [AppBar].

void main() => runApp(const AppBarApp());

class AppBarApp extends StatelessWidget {
  const AppBarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: AppBarExample(),
      //
      // supportedLocales: [
      //   const Locale('en', 'US'), // Английский (США)
      //   const Locale('ru', 'RU'), // Русский (Россия)
      // ],
      localizationsDelegates: [
        // ... другие делегаты локализации
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
    );
  }
}

class AppBarExample extends StatelessWidget {
  const AppBarExample({super.key});

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = TextButton.styleFrom(
      foregroundColor: Theme.of(context).colorScheme.onPrimary,
    );
    return Navigator(
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) {
            switch (settings.name) {
              case '/':
                return Scaffold(
                  appBar: AppBar(
                    title: const Text('Cyberton'),
                    actions: <Widget>[
                      TextButton(
                        style: style,
                        onPressed: () async {


                          final token = 'MTY5NTU3MDUyNzMxOTo5ZGY5NzJhZTE2NGIwYmQxODdlMGYxOGM1NTA2ZDUyYTFkNjg2YWJlNGQ2NWJlMjQyMzU2ZDdjNTI2ZjM2ZTYwOnpha3ZpczEyMzQ1OjMzZDhkOGRmZGIzZDU4M2RiOTJmMTQxZjQzZWViNTFiNDY1YmY5OTdiZWFiNmFlZGE0ZmJjMDQ2YzNkMjk0ODFiYTI5ZmZkOGE4NGUwZGZiN2QwY2U3MWE1ODlmNGJhZDM1NmVhOWUzYWQ5MjQzYjY4Yzg0MWIyZmE3OWZmYzE4'; // Замените на ваш токен
                          // final url = Uri.parse('http://localhost:8080/hello/admin');
                          final url = Uri.parse('http://localhost:8080/premium/get/3');

                          final response = await http.get(
                            url,
                            headers: {
                              'Authorization': '$token',
                            },
                          );

                          if (response.statusCode == 200) {
                            // Обработка успешного ответа
                            print('Response data: ${response.body}');
                          } else {
                            // Обработка ошибки
                            print('Request failed with status: ${response.statusCode}');
                          }
                        },
                        child: const Text('Расчет'),
                      ),
                      TextButton(
                        style: style,
                        onPressed: () {
                          Navigator.pushNamed(context, '/employee');
                          Future.delayed(Duration.zero, () {

                          });
                        },
                        child: const Text('Штат'),
                      ),
                      TextButton(
                        style: style,
                        onPressed: () {
                          // Navigator.pushNamed(context, '/projects');
                        },
                        child: const Text('Проекты'),
                      ),
                      TextButton(
                        style: style,
                        onPressed: () {
                          // Navigator.pushNamed(context, '/expense');
                        },
                        child: const Text('Расход'),
                      ),
                      TextButton(
                        style: style,
                        onPressed: () {
                          // Navigator.pushNamed(context, '/directory');
                        },
                        child: const Text('Справочник'),
                      ),
                    ],
                  ),
                );
              // case '/calculation':
              //   return CalculationScreen(); // Ваш экран для "Расчет"
              case '/employee':
                return Employee(); // Ваш экран для "Штат"
              // case '/projects':
              //   return ProjectsScreen(); // Ваш экран для "Проекты"
              // case '/expense':
              //   return ExpenseScreen(); // Ваш экран для "Расход"
              // case '/directory':
              //   return DirectoryScreen(); // Ваш экран для "Справочник"
              default:
                return const SizedBox(); // По умолчанию ничего не показывать
            }
          },
        );
      },
    );
  }
}
