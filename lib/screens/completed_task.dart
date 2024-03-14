import 'package:flutter/material.dart';

class CompletedTasksScreen extends StatefulWidget {
  final List<String> completedTasks;

  CompletedTasksScreen({required this.completedTasks});

  @override
  _CompletedTasksScreenState createState() => _CompletedTasksScreenState();
}

class _CompletedTasksScreenState extends State<CompletedTasksScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Completed Tasks',
        style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFF9395D3),
        leading: IconButton(
          icon: Icon(Icons.arrow_back,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          color: Colors.white, // Set the color of the return arrow to white
        ),
      ),
      body: ListView.builder(
        itemCount: widget.completedTasks.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(
                widget.completedTasks[index],
                style: TextStyle(fontSize: 18),
              ),
            ),
          );
        },
      ),
    );
  }
}
