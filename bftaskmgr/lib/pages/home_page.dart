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

  @override
  Widget build(BuildContext context) {
    sessionToken = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        title: Text("My Tasks"),
        centerTitle: true,
      ),

      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {});
        },

        child: FutureBuilder(
          future: loadTasks(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }

            final tasks = snapshot.data as List;

            if (tasks.isEmpty) {
              return Center(
                child: Text(
                  "No tasks yet",
                  style: TextStyle(color: Colors.white54, fontSize: 16),
                ),
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
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 16,
                    ),

                    title: Text(
                      t["title"] ?? "",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),

                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.redAccent),
                      onPressed: () async {
                        await ApiService.deleteTask(
                            sessionToken, t["objectId"]);

                        setState(() {}); // refresh UI
                      },
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, "/addtask",
              arguments: sessionToken);
        },
        child: Icon(Icons.add, size: 28),
      ),
    );
  }
}
