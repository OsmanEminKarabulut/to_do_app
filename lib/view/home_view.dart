import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/core/service/firebase_service.dart';
import 'package:to_do_app/core/task_model.dart';
import 'package:to_do_app/view/shared/constants.dart';

class HomeView extends StatefulWidget with ColorPalette {
  HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with ColorPalette {
  void addTask() {}

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Provider.of<TaskModel>(context).fetchTasks(context);
  }

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<FirebaseService>(context).auth.currentUser;
    var doc = Provider.of<FirebaseService>(context).getSnapshot(user?.uid);
    List? tasks = Provider.of<TaskModel>(context).tasks;
    return Scaffold(
        backgroundColor: Colors.white,
        body: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              toolbarHeight: MediaQuery.of(context).size.height / 3,
              stretch: true,
              backgroundColor: backgroundColor,
              title: Center(
                child: Column(
                  children: [
                    const Icon(Icons.alarm),
                    FutureBuilder(
                      future: doc,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        }
                        var data =
                            snapshot.data?.data() as Map<String, dynamic>;
                        return Text(data["full name"]);
                      },
                    ),
                    ElevatedButton(
                        onPressed: () {
                          Provider.of<FirebaseService>(context, listen: false)
                              .signOut();
                          context.go("/sign_in");
                        },
                        child: const Text("Log Out")),
                    IconButton(
                        onPressed: () {
                          Provider.of<TaskModel>(context, listen: false)
                              .addTask(Task("123", []), context, user!);
                        },
                        icon: Icon(Icons.add)),
                  ],
                ),
              ),
            ),
            SliverList.builder(
              itemCount: tasks?.length ?? 0,
              itemBuilder: (context, index) {
                return TaskCard(taskName: tasks?[index]["taskName"]);
              },
            )
          ],
        ));
  }
}

class TaskCard extends StatelessWidget {
  const TaskCard({super.key, required this.taskName});
  final String taskName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        color: Colors.white,
        elevation: 10,
        child: SizedBox(
          height: MediaQuery.of(context).size.height / 3.5,
          width: MediaQuery.of(context).size.width / 3.5,
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(taskName),
                    Spacer(),
                    Icon(Icons.add),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
