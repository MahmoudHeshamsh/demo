import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_app/models/task_models.dart';
import 'package:todo_app/models/user_model.dart';

class FirebaseFunctions {
  static CollectionReference<UserModels> getUserCollection() =>
      FirebaseFirestore.instance.collection('users').withConverter<UserModels>(
            fromFirestore: (docSnapshot, _) =>
                UserModels.fromJson(docSnapshot.data()!),
            toFirestore: (usersModels, _) => usersModels.toJson(),
          );
  static CollectionReference<TaskModels> getTaskCollection(String userId) =>
      getUserCollection()
          .doc(userId)
          .collection('tasks')
          .withConverter<TaskModels>(
            fromFirestore: (docSnapshot, _) =>
                TaskModels.fromJson(docSnapshot.data()!),
            toFirestore: (taskModels, _) => taskModels.toJson(),
          );

  static Future<void> addTaskToFirestore(TaskModels task, String userId) {
    CollectionReference<TaskModels> taskCollection = getTaskCollection(userId);
    DocumentReference<TaskModels> doc = taskCollection.doc();
    task.id = doc.id;
    return doc.set(task);
  }

  static Future<List<TaskModels>> getTasksFromFireStore(String userId) async {
    CollectionReference<TaskModels> taskCollection = getTaskCollection(userId);
    QuerySnapshot<TaskModels> querySnapshot = await taskCollection.get();
    return querySnapshot.docs.map((docSnapshot) => docSnapshot.data()).toList();
  }

  static Future<void> deleteTaskFromFirestore(String taskId, String userId) {
    CollectionReference<TaskModels> taskCollection = getTaskCollection(userId);
    return taskCollection.doc(taskId).delete();
  }

  static Future<void> updateTaskFromFirestore(
      String taskId, String newTitle, String newDescription, String userId) {
    CollectionReference<TaskModels> taskCollection = getTaskCollection(userId);
    return taskCollection.doc(taskId).update({
      'title': newTitle,
      'description': newDescription,
    });
  }

  static Future<UserModels> register({
    required String name,
    required String email,
    required String password,
  }) async {
    UserCredential credential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);

    UserModels user =
        UserModels(id: credential.user!.uid, name: name, email: email);

    CollectionReference<UserModels> userCollection = getUserCollection();
    await userCollection.doc(user.id).set(user);
    return user;
  }

  static Future<UserModels> login({
    required String email,
    required String password,
  }) async {
    UserCredential credential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);

    CollectionReference<UserModels> userCollection = getUserCollection();

    DocumentSnapshot<UserModels> docSnapshot =
        await userCollection.doc(credential.user!.uid).get();
    return docSnapshot.data()!;
  }

  static Future<void> logout() => FirebaseAuth.instance.signOut();
}
