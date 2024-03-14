import 'package:flutter/material.dart';

class AddTaskScreen extends StatefulWidget {
  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _detailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Task',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFF9395D3),
        iconTheme: IconThemeData(color: Colors.white), // Set the color of the return arrow to white
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                hintText: 'Title',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _detailController,
              decoration: InputDecoration(
                hintText: 'Detail',
              ),
            ),
            SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: () {
                final title = _titleController.text;
                final detail = _detailController.text;
                if (title.isNotEmpty && detail.isNotEmpty) {
                  Navigator.pop(context, {
                    'title': title,
                    'detail': detail,
                  });
                }
              },
              child: Text(
                'ADD',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF9395D3),
                padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _detailController.dispose();
    super.dispose();
  }
}
