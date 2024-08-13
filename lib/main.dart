import 'package:flutter/material.dart';
import 'utils.dart';

void main() {
  runApp(TodoListApp());
}

class TodoListApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'To-Do List App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TodoListPage(),
    );
  }
}

class TodoListPage extends StatefulWidget {
  @override
  _TodoListPageState createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  final List<Map<String, dynamic>> _tasks = [];
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  void _addTask() {
    setState(() {
      _tasks.add({
        'title': _titleController.text,
        'description': _descriptionController.text,
        'completed': false,
      });
      _titleController.clear();
      _descriptionController.clear();
    });
    Navigator.of(context).pop();
  }

  void _editTask(int index) {
    setState(() {
      _tasks[index]['title'] = _titleController.text;
      _tasks[index]['description'] = _descriptionController.text;
    });
    _titleController.clear();
    _descriptionController.clear();
    Navigator.of(context).pop();
  }

  void _toggleCompletion(int index) {
    setState(() {
      _tasks[index]['completed'] = !_tasks[index]['completed'];
    });
  }

  void _deleteTask(int index) {
    setState(() {
      _tasks.removeAt(index);
    });
  }

  void _showTaskDialog({int? index}) {
    if (index != null) {
      _titleController.text = _tasks[index]['title'];
      _descriptionController.text = _tasks[index]['description'];
    }
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(index == null ? 'Add Task' : 'Edit Task'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                if (index == null) {
                  _addTask();
                } else {
                  _editTask(index);
                }
              },
              child: Text(index == null ? 'Add' : 'Save'),
            ),
            ElevatedButton(
              onPressed: () {
                _titleController.clear();
                _descriptionController.clear();
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        toolbarHeight: size.height * 0.13,
        centerTitle: true,
        title: titleWidget(size),
      ),
      body: Stack(
        children: [
          Opacity(
            opacity: 0.7,
            child: Image.asset("assets/img1.jpg",width: size.width,
              height: size.height,
              fit: BoxFit.fill,),
          ),
          Container(
            width: size.width * 0.95,
            margin: EdgeInsets.symmetric(horizontal: size.width * 0.05),
            child: _tasks.isEmpty
                ? const Padding(
              padding: EdgeInsets.fromLTRB(10, 50, 10, 10),
              child: ListTile(
                leading: Icon(Icons.task_alt, color: Colors.blue),
                title: Text(
                  'Add your first task...',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
                : ListView.builder(
              itemCount: _tasks.length,
              itemBuilder: (context, index) {
                final task = _tasks[index];
                return ListTile(
                  leading: Checkbox(
                    value: task['completed'],
                    onChanged: (value) {
                      _toggleCompletion(index);
                    },
                  ),
                  title: Text(
                    task['title'],
                    style: TextStyle(
                      decoration: task['completed']
                          ? TextDecoration.lineThrough
                          : null,
                    ),
                  ),
                  subtitle: Text(task['description']),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          _showTaskDialog(index: index);
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          _deleteTask(index);
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {
          _showTaskDialog();
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 40,
        ),
      ),
    );
  }
}
