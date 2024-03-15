// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart'; // Importing the material package for Flutter UI components

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({Key? key}) : super(key: key);
 // Define a StatefulWidget for the add task screen
  @override
  _AddTaskScreenState createState() => _AddTaskScreenState(); // Create state for the AddTaskScreen
}

class _AddTaskScreenState extends State<AddTaskScreen> { // Define state for the add task screen
  final TextEditingController _titleController = TextEditingController(); // Define a controller for the title text field
  final TextEditingController _detailController = TextEditingController(); // Define a controller for the detail text field

  @override
  Widget build(BuildContext context) { // Build method to create the UI for the add task screen
    return Scaffold( // Scaffold widget provides a basic structure for the screen
      appBar: AppBar( // AppBar for the top navigation bar
        title: const Text( // Text widget to display the title
          'Add Task', // Title text
          style: TextStyle(color: Colors.white), // Style the text color to white
        ),
        backgroundColor: const Color(0xFF9395D3), // Set the background color of the app bar
        iconTheme: const IconThemeData(color: Colors.white), // Set arrow color to white
      ),
      body: Padding( // Padding widget to add padding around the content
        padding: const EdgeInsets.all(16.0), // Set padding to 16 pixels on all sides
        child: Column( // Column widget to arrange children widgets vertically
          children: [ // List of children widgets
            TextField( // Text field widget for entering the task title
              controller: _titleController, // Set the controller to manage the text field
              decoration: const InputDecoration( // Input decoration to customize the appearance of the text field
                hintText: 'Title', // Hint text to display when the field is empty
              ),
            ),
            const SizedBox(height: 16.0), // SizedBox widget for adding vertical space
            TextField( // Text field widget for entering the task detail
              controller: _detailController, // Set the controller to manage the text field
              decoration: const InputDecoration( // Input decoration to customize the appearance of the text field
                hintText: 'Detail', // Hint text to display when the field is empty
              ),
            ),
            const SizedBox(height: 32.0), // SizedBox widget for adding vertical space
            ElevatedButton( // Elevated button widget for adding the task
              onPressed: () { // Callback function called when the button is pressed
                final title = _titleController.text; // Get the title from the text field
                final detail = _detailController.text; // Get the detail from the text field
                if (title.isNotEmpty && detail.isNotEmpty) { // Check if both title and detail are not empty
                  Navigator.pop(context, { // Close the current screen and pass the task data back to the previous screen
                    'title': title, // Pass the title of the task
                    'detail': detail, // Pass the detail of the task
                  });
                }
              },
              style: ElevatedButton.styleFrom( // Style the elevated button
                backgroundColor: const Color(0xFF9395D3), // Set button color to the desired color
                padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0), // Set padding for the button
              ),
              child: const Text( // Text widget for the button label
                'ADD', // Button label text
                style: TextStyle( // Style the button label text
                  color: Colors.white, // Set text color to white
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() { // Dispose method called when the state is disposed
    _titleController.dispose(); // Dispose the title controller to release resources
    _detailController.dispose(); // Dispose the detail controller to release resources
    super.dispose();
  }
}
