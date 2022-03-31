import 'package:equatable/equatable.dart';
import '../models/todo_model.dart';

abstract class TodoState extends Equatable {
  const TodoState();

  @override
  List<Object> get props => [];
}

class TodoLoading extends TodoState {}

class TodoLoaded extends TodoState {
  final List<Todo> todos;
  const TodoLoaded({required this.todos});

  @override
  List<Object> get props => [todos];
}
