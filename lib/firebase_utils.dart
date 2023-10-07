import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:to_do/task/tasks.dart';

class FirebaseUlils {
  static CollectionReference<Tasks> getTasksCollection() {
    return FirebaseFirestore.instance.collection('tasks').withConverter<Tasks>(
        fromFirestore: (snapshot, options) =>
            Tasks.fromFirestore(snapshot.data()!),
        toFirestore: (task, options) => task.toFirestore());
  }

  static Future<void> addTaskToFirestore(Tasks tasks) {
    var taskCollection = getTasksCollection();
    DocumentReference<Tasks> DocRef = taskCollection.doc();
    tasks.id = DocRef.id;
    return DocRef.set(tasks);
  }

  static Future<void> deleteTaskFromFirestore(Tasks task) {
    return getTasksCollection().doc(task.id).delete();
  }

  static Future<void> IsDoneTaskFromFirestore(Tasks task, bool newCondition) {
    return getTasksCollection().doc(task.id).update({'isDone': newCondition});
  }

  static Future<void> EditTaskFromFirestore(
      {required Tasks task,
      required String title,
      required String description}) {
    return getTasksCollection()
        .doc(task.id)
        .update({'title': title, "description": description});
  }
}
