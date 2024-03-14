import 'package:flutter/material.dart'; // Importing the material package for Flutter UI components

class CompletedTasksScreen extends StatefulWidget { // Define a StatefulWidget for the completed tasks screen
  final List<String> completedTasks; // Define a list to hold completed tasks

  CompletedTasksScreen({required this.completedTasks}); // Constructor to initialize the completed tasks list

  @override
  _CompletedTasksScreenState createState() => _CompletedTasksScreenState(); // Create state for the CompletedTasksScreen
}

class _CompletedTasksScreenState extends State<CompletedTasksScreen> { // Define state for the completed tasks screen
  @override
  Widget build(BuildContext context) { // Build method to create the UI for the completed tasks screen
    return Scaffold( // Scaffold widget provides a basic structure for the screen
      appBar: AppBar( // AppBar for the top navigation bar
        title: Text( // Text widget to display the title
          'Completed Tasks', // Title text
          style: TextStyle(color: Colors.white), // Style the text color to white
        ),
        backgroundColor: Color(0xFF9395D3), // Set the background color of the app bar
        iconTheme: IconThemeData(color: Colors.white), // Set the color of the return arrow to white
      ),
      body: ListView.builder( // ListView builder to create a scrollable list of completed tasks
        itemCount: widget.completedTasks.length, // Set the number of items in the list to the length of the completed tasks list
        itemBuilder: (context, index) { // Item builder function to build each item in the list
          return Card( // Card widget to display each completed task
            child: ListTile( // ListTile widget to display each task as a list item
              title: Text( // Text widget to display the task name
                widget.completedTasks[index], // Get the task name from the completed tasks list
                style: TextStyle(fontSize: 18), // Style the text size
              ),
            ),
          );
        },
      ),
    );
  }
}
