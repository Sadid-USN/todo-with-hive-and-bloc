import 'package:bloc_test/bloc/todo_event.dart';
import 'package:bloc_test/bloc/todo_state.dart';
import 'package:bloc/bloc.dart';
import 'package:bloc_test/hive_database.dart';
import 'package:hive_flutter/adapters.dart';

import '../models/todo_model.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final HiveDataBase hiveDataBase;
  TodoBloc({required this.hiveDataBase}) : super(TodoLoading()) {
    on<LoadTodos>(_onLoadeTodo);

    on<UpdateTodo>(_onUpdateTodo);

    on<AddTodo>(_onAddTodo);

    on<DeleteAllTodo>(_onDeleteAllTodo);

    on<DeleteTodo>(_onDeleteOneTodo);
  }
  void _onLoadeTodo(
    LoadTodos event,
    Emitter<TodoState> emit,
  ) async {
    Future<void>.delayed(const Duration(seconds: 1));
    Box box = await hiveDataBase.openBox();
    List<Todo> todos = hiveDataBase.getTodo(box);
    emit(TodoLoaded(todos: todos));
  }

  void _onUpdateTodo(
    UpdateTodo event,
    Emitter<TodoState> emit,
  ) async {
    Box box = await hiveDataBase.openBox();
    if (state is TodoLoaded) {
      await hiveDataBase.updateTodo(box, event.todo);
      emit(
        TodoLoaded(
          todos: hiveDataBase.getTodo(box),
        ),
      );
    }
  }

  void _onAddTodo(
    AddTodo event,
    Emitter<TodoState> emit,
  ) async {
    Box box = await hiveDataBase.openBox();
    if (state is TodoLoaded) {
      await hiveDataBase.addTodo(box, event.todo);
      emit(
        TodoLoaded(
          todos: hiveDataBase.getTodo(box),
        ),
      );
    }
  }

  void _onDeleteAllTodo(
    DeleteAllTodo event,
    Emitter<TodoState> emit,
  ) async {
    Box box = await hiveDataBase.openBox();
    if (state is TodoLoaded) {
      hiveDataBase.deleteAllTodo(box);
      emit(
        TodoLoaded(
          todos: hiveDataBase.getTodo(box),
        ),
      );
    }
  }

  void _onDeleteOneTodo(
    DeleteTodo event,
    Emitter<TodoState> emit,
  ) async {
    Box box = await hiveDataBase.openBox();
    if (state is TodoLoaded) {
      hiveDataBase.deleteOneTodo(box, event.todo);
      emit(
        TodoLoaded(
          todos: hiveDataBase.getTodo(box),
        ),
      );
    }
  }
}
