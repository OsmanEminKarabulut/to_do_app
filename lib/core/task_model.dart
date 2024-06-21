import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/core/service/firebase_service.dart';

class TaskModel extends ChangeNotifier {
  List? tasks;

  Future<void> fetchTasks(BuildContext context) async {
    if (FirebaseService.loggedIn == true) {
      var firestore = Provider.of<FirebaseService>(context).firestore;
      var credential = Provider.of<FirebaseService>(context).credential;
      DocumentSnapshot documentSnapshot =
          await firestore.collection("users").doc(credential?.user?.uid).get();

      try {
        tasks = documentSnapshot.get("tasks");
      } catch (e) {
        tasks = null;
      }

      if (tasks == null) {
        await firestore
            .collection("users")
            .doc(credential?.user?.uid)
            .set({"tasks": []}, SetOptions(merge: true));
        tasks = [];
      }
    }
  }

  Future<void> addTask(Task task, context, User user) async {
    tasks?.add(task.toMap());
    try {
      await Provider.of<FirebaseService>(context, listen: false)
          .updateUserInformation(user, "tasks", tasks!);
      notifyListeners();
    } catch (e) {
      throw Exception(e);
    }
  }
}

class Task {
  String taskName;
  List<String> toDos;

  Task(this.taskName, this.toDos);

  Map<String, dynamic> toMap() {
    return {"taskName": taskName, "toDos": toDos};
  }
}
