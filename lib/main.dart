import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-do List Application',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        primaryColor: Color(0xFF9395D3), // Set primary color to #9395D3
      ),
      home: TodoList(),
      debugShowCheckedModeBanner: false, // Hide debug banner
    );
  }
}
