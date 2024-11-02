import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/models/task_models.dart';

class FirebaseFunctions {
  static CollectionReference<TaskModels> getTaskCollection() =>
      FirebaseFirestore.instance.collection('tasks').withConverter<TaskModels>(
            fromFirestore: (docSnapshot, _) =>
                TaskModels.fromJson(docSnapshot.data()!),
            toFirestore: (taskModels, _) => taskModels.toJson(),
          );

  static Future<void> addTaskToFirestore(TaskModels task) {
    CollectionReference<TaskModels> taskCollection = getTaskCollection();
    DocumentReference<TaskModels> doc = taskCollection.doc();
    task.id = doc.id;
    return doc.set(task);
  }

  static Future<List<TaskModels>> getTasksFromFireStore() async {
    CollectionReference<TaskModels> taskCollection = getTaskCollection();
    QuerySnapshot<TaskModels> querySnapshot = await taskCollection.get();
    return querySnapshot.docs.map((docSnapshot) => docSnapshot.data()).toList();
  }

  static Future<void> deleteTaskFromFirestore(String taskId) {
    CollectionReference<TaskModels> taskCollection = getTaskCollection();
    return taskCollection.doc(taskId).delete();
  }

  static Future<void> updateTaskFromFirestore(String taskId, String newTitle ,String newDescription) {
    CollectionReference<TaskModels> taskCollection = getTaskCollection();
    return taskCollection.doc(taskId).update({
      'title': newTitle,
      'description':newDescription,
    });
  }
}
