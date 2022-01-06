import 'dart:convert';
import 'dart:io';

import 'package:shelf_router/shelf_router.dart';
import 'package:shelf/shelf.dart';

final router = Router()
  ..get('/todos', _getTodos)
  ..get('/todo/<id>', _getTodoByID)
  ..post('/add-todo', _addTodo)
  ..patch('/todo-done/<id>', _todoDone)
  ..delete('/delete-todo/<id>', _deleteTodo)
  ..put('/update-todo', _updateTodo);

final List allTodos =
    json.decode(File('bin/data/todos.json').readAsStringSync());

Response _getTodos(Request request) {
  return Response.ok(json.encode(allTodos),
      headers: {'Content-Type': 'application/json'});
}

Response _getTodoByID(Request request, String id) {
  final parsedId = int.tryParse(id);
  final todo =
      allTodos.firstWhere((todo) => todo['id'] == parsedId, orElse: () => null);

  if (todo != null) {
    return Response.ok(json.encode(todo),
        headers: {'Content-Type': 'application/json'});
  }
  return Response.notFound('Todo not found!');
}

Future<Response> _addTodo(Request request) async {
  final payload = await request.readAsString();
  allTodos.add(json.decode(payload));
  return Response.ok(payload, headers: {'Content-Type': 'application/json'});
}

Response _deleteTodo(Request request, String id) {
  final parsedId = int.tryParse(id);
  allTodos.removeWhere((todo) => todo['id'] == parsedId);
  return Response.ok('Todo Deleted');
}

Future<Response> _updateTodo(Request request) async {
  final payload = await request.readAsString();
  final todo = json.decode(payload);
  final parsedId = todo['id'];
  allTodos[allTodos.indexWhere((element) => element['id'] == parsedId)] = todo;
  return Response.ok('Todo Updated');
}

Future<Response> _todoDone(Request request, String id) async {
  final parsedId = int.tryParse(id);
  final payload = await request.readAsString();
  final todoStatus = json.decode(payload);
  final updatedTodo = allTodos[allTodos.indexWhere((element) => element['id'] == parsedId)]['isDone'] = todoStatus['isDone'];

  if (updatedTodo == false) {
    return Response.ok('Todo is not done!');
  } else {
    return Response.ok('Todo is done!');
  }
}
