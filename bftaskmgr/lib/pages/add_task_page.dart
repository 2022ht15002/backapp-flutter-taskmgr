import 'package:flutter/material.dart';
import 'package:bftaskmgr/services/api_service.dart';

class AddTaskPage extends StatelessWidget {
  final titleCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final sessionToken =
        ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        title: Text("Add Task"),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20.0),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            Text(
              "Create New Task",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),

            SizedBox(height: 20),

            // Input Field
            TextField(
              controller: titleCtrl,
              decoration: InputDecoration(
                labelText: "Task Title",
                prefixIcon: Icon(Icons.title, color: Colors.grey),
              ),
            ),

            SizedBox(height: 30),

            // Save Button
            ElevatedButton(
              onPressed: () async {
                if (titleCtrl.text.trim().isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Enter a task title.")),
                  );
                  return;
                }

                final ok =
                    await ApiService.createTask(sessionToken, titleCtrl.text);

                if (ok) {
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Task creation failed")),
                  );
                }
              },
              child: Text("Save Task"),
            )
          ],
        ),
      ),
    );
  }
}
