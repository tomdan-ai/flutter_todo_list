import 'package:flutter/material.dart'; // Importing the material package for Flutter UI components

class EditTaskScreen extends StatefulWidget { // Define a StatefulWidget for the edit task screen
  final String initialTitle; // Define a variable to hold the initial title of the task
  final String initialDetail; // Define a variable to hold the initial detail of the task

  EditTaskScreen({ // Constructor to initialize the initial title and detail of the task
    required this.initialTitle, // Required initial title parameter
    required this.initialDetail, // Required initial detail parameter
  });

  @override
  _EditTaskScreenState createState() => _EditTaskScreenState(); // Create state for the EditTaskScreen
}

class _EditTaskScreenState extends State<EditTaskScreen> { // Define state for the edit task screen
  late TextEditingController _titleController; // Define a controller for the title text field
  late TextEditingController _detailController; // Define a controller for the detail text field

  @override
  void initState() { // Initialize method called when the state is initialized
    super.initState();
    _titleController = TextEditingController(text: widget.initialTitle); // Initialize the title controller with the initial title
    _detailController = TextEditingController(text: widget.initialDetail); // Initialize the detail controller with the initial detail
  }

  @override
  Widget build(BuildContext context) { // Build method to create the UI for the edit task screen
    return Scaffold( // Scaffold widget provides a basic structure for the screen
      appBar: AppBar( // AppBar for the top navigation bar
        title: Text( // Text widget to display the title
          'Edit Task', // Title text
          style: TextStyle(color: Colors.white), // Style the text color to white
        ),
        backgroundColor: Color(0xFF9395D3), // Set the background color of the app bar
        iconTheme: IconThemeData(color: Colors.white), // Set arrow color to white
      ),
      body: Padding( // Padding widget to add padding around the content
        padding: EdgeInsets.all(16.0), // Set padding to 16 pixels on all sides
        child: Column( // Column widget to arrange children widgets vertically
          children: [ // List of children widgets
            TextField( // Text field widget for editing the task title
              controller: _titleController, // Set the controller to manage the text field
              decoration: InputDecoration( // Input decoration to customize the appearance of the text field
                hintText: 'Title', // Hint text to display when the field is empty
              ),
            ),
            SizedBox(height: 16.0), // SizedBox widget for adding vertical space
            TextField( // Text field widget for editing the task detail
              controller: _detailController, // Set the controller to manage the text field
              decoration: InputDecoration( // Input decoration to customize the appearance of the text field
                hintText: 'Detail', // Hint text to display when the field is empty
              ),
            ),
            SizedBox(height: 32.0), // SizedBox widget for adding vertical space
            Row( // Row widget to arrange children widgets horizontally
              mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Align children evenly along the main axis
              children: [ // List of children widgets
                ElevatedButton( // Elevated button widget for updating the task
                  onPressed: () { // Callback function called when the button is pressed
                    final updatedTitle = _titleController.text; // Get the updated title from the text field
                    final updatedDetail = _detailController.text; // Get the updated detail from the text field
                    if (updatedTitle.isNotEmpty && updatedDetail.isNotEmpty) { // Check if both title and detail are not empty
                      Navigator.pop(context, { // Close the current screen and pass updated data back to the previous screen
                        'title': updatedTitle, // Pass updated title
                        'detail': updatedDetail, // Pass updated detail
                      });
                    }
                  },
                  child: Text( // Text widget for the button label
                    'Update', // Button label text
                    style: TextStyle( // Style the button label text
                      color: Colors.white, // Set text color to white
                    ),
                  ),
                  style: ElevatedButton.styleFrom( // Style the elevated button
                    backgroundColor: Color(0xFF9395D3), // Set button color to the desired color
                    padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0), // Set padding for the button
                  ),
                ),
                ElevatedButton( // Elevated button widget for canceling the update
                  onPressed: () { // Callback function called when the button is pressed
                    Navigator.pop(context); // Close the current screen and go back to the previous screen
                  },
                  child: Text( // Text widget for the button label
                    'Cancel', // Button label text
                    style: TextStyle( // Style the button label text
                      color: Colors.white, // Set text color to white
                    ),
                  ),
                  style: ElevatedButton.styleFrom( // Style the elevated button
                    backgroundColor: Color(0xFF9395D3), // Set button color to the desired color
                    padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0), // Set padding for the button
                  ),
                ),
              ],
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
