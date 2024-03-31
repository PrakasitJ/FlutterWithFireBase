import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:project/models/todo.dart';
import 'package:project/main.dart';

const String TODO_COLLECTION_REF = "todos";

class DatabaseService {
  final _firestore = FirebaseFirestore.instanceFor(app: app);

  late final CollectionReference _todosRef;

  DatabaseService() {
    _todosRef = _firestore.collection(TODO_COLLECTION_REF).withConverter<Todo>(
        fromFirestore: (snapshots, _) => Todo.fromJson(
              snapshots.data()!,
            ),
        toFirestore: (todo, _) => todo.toJson());
  }

  Stream<QuerySnapshot> getTodos() {
    return _todosRef.snapshots();
  }

  void addTodo(Todo todo) async {
    _todosRef.add(todo);
  }

  void updateTodo(String todoId, Todo todo) {
    _todosRef.doc(todoId).update(todo.toJson());
  }

  void deleteTodo(String todoId) {
    _todosRef.doc(todoId).delete();
  }
}