import 'package:flutter/material.dart';
import 'package:flutter_todo_list/screens/add_task.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_todo_list/screens/edit_task.dart';
import 'package:flutter_todo_list/screens/completed_task.dart';

class TodoList extends StatefulWidget {
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  List<String> _todos = [];
  List<String> _completedTasks = [];
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _todos = prefs.getStringList('todos') ?? [];
      _completedTasks = prefs.getStringList('completedTasks') ?? [];
    });
  }

  Future<void> _saveTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('todos', _todos);
    await prefs.setStringList('completedTasks', _completedTasks);
  }

  void _addTask(String title, String detail) {
    setState(() {
      _todos.add('$title\n$detail');
      _saveTasks();
    });
  }

  void _completeTask(int index) {
    setState(() {
      _completedTasks.add(_todos[index]);
      _todos.removeAt(index);
      _saveTasks();
    });
  }

  void _deleteTask(int index) {
    setState(() {
      _todos.removeAt(index);
      _saveTasks();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
        children: [
            Text(
              'TODO APP',
              style: TextStyle(color: Colors.white),
            ),
            Spacer(), // Add spacer to push the calendar icon to the right
            IconButton(
              icon: Icon(Icons.calendar_today),
              color: Colors.white,
              onPressed: ()  {
                // Implement calendar icon functionality here
              },
            ),
          ],
        ),
        backgroundColor: Color(0xFF9395D3),
        
      ),
      body: _currentIndex == 0
          ? Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: _todos.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(bottom: 8.0),
                          child: Card(
                            margin: EdgeInsets.only(top: 8.0),
                            child: ListTile(
                              title: Text(
                                _todos[index],
                                style: TextStyle(fontSize: 18,
                                                  color: Color(0xFF9395D3),
                                ),
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.create_outlined),
                                                  color: Color(0xFF9395D3),
                                    onPressed: () async {
                                      final result = await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => EditTaskScreen(
                                            initialTitle: _todos[index].split('\n')[0],
                                            initialDetail: _todos[index].split('\n')[1],
                                          ),
                                        ),
                                      );
                                      if (result != null) {
                                        setState(() {
                                          _todos[index] = '${result['title']}\n${result['detail']}';
                                          _saveTasks();
                                        });
                                      }
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.delete_outline_rounded),
                                                  color: Color(0xFF9395D3),
                                    onPressed: () {
                                      _deleteTask(index);
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.check_circle_outline),
                                                  color: Color(0xFF9395D3),
                                    onPressed: () {
                                      _completeTask(index);
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
          : CompletedTasksScreen(completedTasks: _completedTasks),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddTaskScreen(),
            ),
          );
          if (result != null) {
            _addTask(result['title'], result['detail']);
          }
        },
        child: Icon(Icons.add),
        backgroundColor: Color(0xFF9395D3),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'All',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check),
            label: 'Completed',
          ),
        ],
      ),
    );
  }
}
