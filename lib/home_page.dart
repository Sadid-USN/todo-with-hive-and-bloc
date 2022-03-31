import 'dart:math';

import 'package:bloc_test/bloc/todo_bloc.dart';
import 'package:bloc_test/bloc/todo_event.dart';
import 'package:bloc_test/bloc/todo_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'models/todo_model.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TodoBloc mainBloc = context.read<TodoBloc>();
    return Scaffold(
      backgroundColor: Colors.grey[100],
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text('Todo'),
        centerTitle: true,
      ),
      body: BlocBuilder<TodoBloc, TodoState>(builder: (context, state) {
        if (state is TodoLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is TodoLoaded) {
          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            physics: const BouncingScrollPhysics(),
            itemCount: state.todos.length,
            itemBuilder: (BuildContext context, index) {
              Todo todo = state.todos[index];
              return SingleChildScrollView(
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        _bottomSheet(
                          context: context,
                          todo: todo,
                        );
                      },
                      child: SizedBox(
                        height: 150,
                        child: Card(
                          child: ListTile(
                            title: Text(
                              todo.title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 20),
                            ),
                            subtitle: Text(
                              todo.description,
                              maxLines: 4,
                              overflow: TextOverflow.ellipsis,
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: Icon(
                                    Icons.task_alt_outlined,
                                    color: todo.isDon
                                        ? Colors.green[300]
                                        : Colors.blueGrey,
                                  ),
                                  onPressed: () {
                                    mainBloc.add(
                                      UpdateTodo(
                                        todo: todo.copyWith(
                                          isDon: !todo.isDon,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                IconButton(
                                  icon: Icon(
                                    Icons.edit,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  onPressed: () {
                                    _bottomSheet(
                                      context: context,
                                      todo: todo,
                                    );
                                  },
                                ),
                                IconButton(
                                  icon: Icon(
                                    Icons.delete,
                                    color: Colors.red[700],
                                  ),
                                  onPressed: () {
                                    mainBloc.add(
                                      DeleteTodo(
                                        todo: state.todos[index],
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        } else {
          return const Text('Somthing went wrong');
        }
      }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          _bottomSheet(
            context: context,
          );
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  void _bottomSheet({
    required BuildContext context,
    Todo? todo,
  }) {
    Random random = Random();
    TextEditingController titleController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();

    if (todo != null) {
      titleController.text = todo.title;
      descriptionController.text = todo.description;
    }

    showModalBottomSheet(
      isScrollControlled: true,
      isDismissible: true,
      context: context,
      elevation: 8,
      builder: (context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    TextField(
                      controller: titleController,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        labelText: 'title',
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: descriptionController,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        labelText: 'description',
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (todo != null) {
                          context.read<TodoBloc>().add(
                                UpdateTodo(
                                    todo: todo.copyWith(
                                  title: titleController.text,
                                  description: descriptionController.text,
                                )),
                              );
                        } else {
                          Todo todo = Todo(
                            id: '${random.nextInt(3000)}',
                            title: titleController.text,
                            description: descriptionController.text,
                            isDon: false,
                          );
                          context.read<TodoBloc>().add(
                                AddTodo(todo: todo),
                              );
                        }

                        Navigator.pop(context);
                      },
                      child: const Text('Save'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
