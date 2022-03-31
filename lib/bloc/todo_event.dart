import 'package:equatable/equatable.dart';

import '../models/todo_model.dart';

abstract class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object> get props => [];
}

class LoadTodos extends TodoEvent {}

class UpdateTodo extends TodoEvent {
  final Todo todo;
  const UpdateTodo({
    required this.todo,
  });

  @override
  List<Object> get props => [todo];
}

class AddTodo extends TodoEvent {
  final Todo todo;
  const AddTodo({required this.todo});
  @override
  List<Object> get props => [todo];
}

class DeleteTodo extends TodoEvent {
  final Todo todo;
  const DeleteTodo({required this.todo});
  @override
  List<Object> get props => [todo];
}

class DeleteAllTodo extends TodoEvent {}
