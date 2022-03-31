import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
part 'todo_model.g.dart';

@HiveType(typeId: 0)
class Todo extends Equatable {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String description;

  @HiveField(3)
  final bool isDon;

  const Todo({
    required this.id,
    required this.title,
    required this.description,
    required this.isDon,
  });

  Todo copyWith({
    String? id,
    String? title,
    String? description,
    bool? isDon,
  }) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isDon: isDon ?? this.isDon,
    );
  }

  @override
  List<Object?> get props => [id, title, description, isDon];
}
