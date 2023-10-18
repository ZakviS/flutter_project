import 'package:flutter/material.dart';

class Project extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ProjectState();
  }
}

class ProjectState extends State<Project> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Проект'),
        centerTitle: true,
      ),
    );
  }
}
