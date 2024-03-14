import 'package:flutter/material.dart'; // Importing the material package for Flutter UI components
import 'package:flutter_todo_list/screens/add_task.dart'; // Importing the add task screen
import 'package:flutter_todo_list/screens/edit_task.dart'; // Importing the edit task screen
import 'package:flutter_todo_list/screens/completed_task.dart'; // Importing the completed task screen
import 'package:shared_preferences/shared_preferences.dart'; // Importing shared preferences for data persistence

class TodoList extends StatefulWidget { // Define a StatefulWidget for the todo list
  @override
  _TodoListState createState() => _TodoListState(); // Create state for the TodoList
}

class _TodoListState extends State<TodoList> { // Define state for the todo list
  List<String> _todos = []; // List to hold todo tasks
  List<String> _completedTasks = []; // List to hold completed tasks
  int _currentIndex = 0; // Index to track the current screen

  @override
  void initState() { // Initialize method called when the state is initialized
    super.initState();
    _loadTasks(); // Load tasks from shared preferences
  }

  Future<void> _loadTasks() async { // Function to load tasks from shared preferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _todos = prefs.getStringList('todos') ?? []; // Get todo tasks from shared preferences, if empty set to empty list
      _completedTasks = prefs.getStringList('completedTasks') ?? []; // Get completed tasks from shared preferences, if empty set to empty list
    });
  }

  Future<void> _saveTasks() async { // Function to save tasks to shared preferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('todos', _todos); // Save todo tasks to shared preferences
    await prefs.setStringList('completedTasks', _completedTasks); // Save completed tasks to shared preferences
  }

  void _addTask(String title, String detail) { // Function to add a new task
    setState(() {
      _todos.add('$title\n$detail'); // Add new task to the todo list
      _saveTasks(); // Save tasks to shared preferences
    });
  }

  void _completeTask(int index) { // Function to mark a task as completed
    setState(() {
      _completedTasks.add(_todos[index]); // Move task from todo list to completed tasks
      _todos.removeAt(index); // Remove completed task from todo list
      _saveTasks(); // Save tasks to shared preferences
    });
  }

  void _deleteTask(int index) { // Function to delete a task
    setState(() {
      _todos.removeAt(index); // Remove task from the todo list
      _saveTasks(); // Save tasks to shared preferences
    });
  }

  @override
  Widget build(BuildContext context) { // Build method to create the UI for the todo list
    return Scaffold( // Scaffold widget provides a basic structure for the screen
      appBar: _currentIndex == 0 // Show app bar only on the main screen
          ? AppBar( // AppBar for the top navigation bar
              title: Row( // Row widget to arrange children widgets horizontally
                children: [
                  Text( // Text widget to display the title
                    'TODO APP', // Title text
                    style: TextStyle(color: Colors.white), // Style the text color to white
                  ),
                  Spacer(), // Spacer widget to fill remaining space
                  IconButton( // IconButton widget for calendar icon
                    icon: Icon(Icons.calendar_today), // Calendar icon
                    color: Colors.white, // Set icon color to white
                    onPressed: () {
                      // Implement calendar icon functionality here
                    },
                  ),
                ],
              ),
              backgroundColor: Color(0xFF9395D3), // Set the background color of the app bar
            )
          : null, // Set app bar to null if not on the main screen
      body: _currentIndex == 0 // Show todo list on the main screen
          ? Padding( // Padding widget to add padding around the content
              padding: EdgeInsets.symmetric(horizontal: 16.0), // Set padding to 16 pixels on horizontal axis
              child: Column( // Column widget to arrange children widgets vertically
                children: [
                  Expanded( // Expanded widget to fill remaining space
                    child: ListView.builder( // ListView builder to create a scrollable list of tasks
                      itemCount: _todos.length, // Set the number of items in the list to the length of todo tasks
                      itemBuilder: (context, index) { // Item builder function to build each item in the list
                        return Padding( // Padding widget to add padding around the list item
                          padding: EdgeInsets.only(bottom: 12.0), // Set padding to 12 pixels at the bottom
                          child: Card( // Card widget to display each task
                            margin: EdgeInsets.only(top: 12.0), // Set margin to 12 pixels at the top
                            child: ListTile( // ListTile widget to display each task as a list item
                              title: Text( // Text widget to display the task title
                                _todos[index].split('\n')[0], // Get the task title from the todo list
                                style: TextStyle( // Style the text
                                  fontSize: 18, // Set font size to 18
                                  color: Color(0xFF9395D3), // Set text color to purple
                                ),
                              ),
                              subtitle: Text( // Text widget to display the task detail
                                _todos[index].split('\n')[1], // Get the task detail from the todo list
                                style: TextStyle( // Style the text
                                  color: Colors.black, // Set text color to black
                                ),
                              ),
                              trailing: Row( // Row widget to arrange children widgets horizontally
                                mainAxisSize: MainAxisSize.min, // Set the main axis size to minimum
                                children: [
                                  IconButton( // IconButton widget for edit icon
                                    icon: Icon(Icons.create_outlined), // Edit icon
                                    color: Color(0xFF9395D3), // Set icon color to purple
                                    onPressed: () async { // Callback function called when the button is pressed
                                      final result = await Navigator.push( // Navigate to the edit task screen
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => EditTaskScreen( // EditTaskScreen widget
                                            initialTitle: _todos[index].split('\n')[0], // Pass initial title of the task
                                            initialDetail: _todos[index].split('\n')[1], // Pass initial detail of the task
                                          ),
                                        ),
                                      );
                                      if (result != null) { // Check if result is not null
                                        setState(() { // Update the state with new task data
                                          _todos[index] = '${result['title']}\n${result['detail']}'; // Update task in the todo list
                                          _saveTasks(); // Save tasks to shared preferences
                                        });
                                      }
                                    },
                                  ),
                                  IconButton( // IconButton widget for delete icon
                                    icon: Icon(Icons.delete_outline_rounded), // Delete icon
                                    color: Color(0xFF9395D3), // Set icon color to purple
                                    onPressed: () { // Callback function called when the button is pressed
                                      _deleteTask(index); // Delete the task
                                    },
                                  ),
                                  IconButton( // IconButton widget for complete icon
                                    icon: Icon(Icons.check_circle_outline), // Complete icon
                                    color: Color(0xFF9395D3), // Set icon color to purple
                                    onPressed: () { // Callback function called when the button is pressed
                                      _completeTask(index); // Mark task as completed
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            )
          : CompletedTasksScreen(completedTasks: _completedTasks), // Show completed tasks screen
      floatingActionButton: _currentIndex == 0 // Show floating action button only on the main screen
          ? ClipOval( // ClipOval widget to clip the child widget in oval shape
              child: Material( // Material widget for elevation and ink effects
                color: Color(0xFF9395D3), // Set background color to purple
                child: InkWell( // InkWell widget for tap animation
                  child: SizedBox( // SizedBox widget for fixed size
                    width: 56, // Set width to 56 pixels
                    height: 56, // Set height to 56 pixels
                    child: Icon(Icons.add, color: Colors.white), // Icon widget for add icon with white color
                  ),
                  onTap: () async { // Callback function called when the button is tapped
                    final result = await Navigator.push( // Navigate to the add task screen
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddTaskScreen(), // AddTaskScreen widget
                      ),
                    );
                    if (result != null) { // Check if result is not null
                      _addTask(result['title'], result['detail']); // Add new task
                    }
                  },
                ),
              ),
            )
          : null, // Hide FloatingActionButton on CompletedTasksScreen
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat, // Set floating action button location to end float
      bottomNavigationBar: BottomNavigationBar( // BottomNavigationBar widget for bottom navigation
        currentIndex: _currentIndex, // Set the current index of the bottom navigation bar
        onTap: (index) { // Callback function called when an item is tapped
          setState(() { // Update the state with new index
            _currentIndex = index; // Set current index to the tapped index
          });
        },
        items: [ // List of BottomNavigationBarItem widgets
          BottomNavigationBarItem( // BottomNavigationBarItem for all tasks
            icon: Icon(Icons.list), // Icon for all tasks
            label: 'All', // Label for all tasks
          ),
          BottomNavigationBarItem( // BottomNavigationBarItem for completed tasks
            icon: Icon(Icons.check), // Icon for completed tasks
            label: 'Completed', // Label for completed tasks
          ),
        ],
      ),
    );
  }
}
