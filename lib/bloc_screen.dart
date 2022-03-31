import 'package:bloc_test/color_bloc.dart';
import 'package:flutter/material.dart';

class BlocScreen extends StatefulWidget {
  const BlocScreen({Key? key}) : super(key: key);

  @override
  State<BlocScreen> createState() => _BlocScreenState();
}

class _BlocScreenState extends State<BlocScreen> {
  final ColorBloc _bloc = ColorBloc();
  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bloc with Stream'),
        centerTitle: true,
      ),
      body: Center(
        child: StreamBuilder(
          stream: _bloc.outputStateStream,
          initialData: Colors.blueGrey,
          builder: (context, snapshot) {
            return AnimatedContainer(
              height: 200,
              width: 200,
              color: snapshot.data as Color,
              duration: const Duration(milliseconds: 300),
            );
          },
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            child: const Icon(Icons.colorize),
            backgroundColor: Colors.orange,
            onPressed: () {
              _bloc.inputEventSink.add(ColorEvent.orange);
            },
          ),
          const SizedBox(
            width: 15,
          ),
          FloatingActionButton(
            child: const Icon(Icons.colorize),
            backgroundColor: Colors.green,
            onPressed: () {
              _bloc.inputEventSink.add(ColorEvent.green);
            },
          ),
        ],
      ),
    );
  }
}
