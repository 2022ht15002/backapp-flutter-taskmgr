import 'package:flutter/material.dart';
import 'package:bftaskmgr/services/api_service.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late String sessionToken;

  Future<List<dynamic>> loadTasks() async {
    return await ApiService.getTasks(sessionToken);
  }

  void _editTask(String objectId, String currentTitle) async {
    final ctrl = TextEditingController(text: currentTitle);

    final ok = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Edit Task"),
        content: TextField(controller: ctrl, decoration: InputDecoration(labelText: "Title")),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: Text("Cancel")),
          ElevatedButton(
              onPressed: () => Navigator.pop(context, true),
              child: Text("Save")),
        ],
      ),
    );

    if (ok == true) {
      final success = await ApiService.updateTask(sessionToken, objectId, ctrl.text);
      if (success) setState(() {}); // refresh list
    }
  }

  @override
  Widget build(BuildContext context) {
    sessionToken = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        title: Text("My Tasks"),
        centerTitle: true,
        backgroundColor: Colors.black87,
      ),
      backgroundColor: Colors.black,

      body: RefreshIndicator(
        color: Colors.blueAccent,
        onRefresh: () async => setState(() {}),
        child: FutureBuilder(
          future: loadTasks(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator(color: Colors.white));
            }

            final tasks = snapshot.data as List;

            if (tasks.isEmpty) {
              return Center(
                child: Text("No tasks yet", style: TextStyle(color: Colors.white54, fontSize: 16)),
              );
            }

            return ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final t = tasks[index];

                return Container(
                  margin: EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: Colors.grey[900],
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: Colors.white12),
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                    title: Text(t["title"] ?? "", style: TextStyle(color: Colors.white, fontSize: 18)),

                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit, color: Colors.blueAccent),
                          onPressed: () => _editTask(t["objectId"], t["title"]),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.redAccent),
                          onPressed: () async {
                            await ApiService.deleteTask(sessionToken, t["objectId"]);
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent,
        onPressed: () {
          Navigator.pushNamed(context, "/addtask", arguments: sessionToken)
              .then((_) => setState(() {}));
        },
        child: Icon(Icons.add, size: 28),
      ),
    );
  }
}
