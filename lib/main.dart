import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_project/pages/employeeScreen.dart';
import 'package:http/http.dart' as http;


void main() => runApp(const AppBarApp());

class AppBarApp extends StatelessWidget {
  const AppBarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: AppBarExample(),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
    );
  }
}

class AppBarExample extends StatelessWidget {
  const AppBarExample({super.key});

  void routeToEmployee(BuildContext context){
    Navigator.pushNamed(context, '/employee');
    Future.delayed(Duration.zero, () {});
  }

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
                        onPressed: () {
                        },
                        child: const Text('Расчет'),
                      ),
                      TextButton(
                        style: style,
                        onPressed: () {
                          routeToEmployee(context);
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
              //   return CalculationScreen();
              case '/employee':
                return Employee();
              // case '/projects':
              //   return ProjectsScreen();
              // case '/expense':
              //   return ExpenseScreen();
              // case '/directory':
              //   return DirectoryScreen();
              default:
                return const SizedBox();
            }
          },
        );
      },
    );
  }
}
