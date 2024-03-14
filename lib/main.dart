import 'package:flutter/material.dart'; // Importing the material package for Flutter UI components
import 'screens/home_screen.dart'; // Importing the home screen widget

void main() { // Main function, entry point of the application
  runApp(const TodoApp()); // Run the TodoApp widget as the root of the widget tree
}

class TodoApp extends StatelessWidget { // Define a StatelessWidget for the TodoApp
  const TodoApp({Key? key}) : super(key: key); // Constructor for the TodoApp

  @override
  Widget build(BuildContext context) { // Build method to create the UI for the TodoApp
    return MaterialApp( // MaterialApp widget for the root of the application
      title: 'To-do List Application', // Set the title of the application
      theme: ThemeData( // ThemeData to define the overall theme of the application
        primarySwatch: Colors.purple, // Set the primary swatch color to purple
        primaryColor: Color(0xFF9395D3), // Set primary color to #9395D3
      ),
      home: TodoList(), // Set the home screen of the application to TodoList widget
      debugShowCheckedModeBanner: false, // Hide debug banner
    );
  }
}
