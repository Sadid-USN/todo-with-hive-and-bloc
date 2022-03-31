import 'package:bloc_test/bloc/todo_bloc.dart';
import 'package:bloc_test/bloc/todo_event.dart';
import 'package:bloc_test/hive_database.dart';
import 'package:bloc_test/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'models/todo_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(TodoAdapter());
  final hiveDataBase = HiveDataBase();
  await hiveDataBase.openBox();
  runApp(MyApp(
    hiveDataBase: hiveDataBase,
  ));
}

class MyApp extends StatelessWidget {
  final HiveDataBase _hiveDataBase;
  const MyApp({Key? key, required HiveDataBase hiveDataBase})
      : _hiveDataBase = hiveDataBase,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _hiveDataBase,
      child: BlocProvider(
        create: ((context) =>
            TodoBloc(hiveDataBase: _hiveDataBase)..add(LoadTodos())),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Hive',
          theme: ThemeData(
            primaryColor: Colors.blue[900],
          ),
          home: const HomePage(),
        ),
      ),
    );
  }
}
