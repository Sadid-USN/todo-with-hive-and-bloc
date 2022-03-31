// ignore_for_file: curly_braces_in_flow_control_structures

import 'dart:async';

import 'package:flutter/material.dart';

enum ColorEvent { orange, green }

class ColorBloc {
  late Color _color;
  final _inputColorController = StreamController<ColorEvent>();
  StreamSink<ColorEvent> get inputEventSink => _inputColorController.sink;

  final _outputStateController = StreamController<Color>();

  Stream<Color> get outputStateStream => _outputStateController.stream;

  void _mapEventToState(ColorEvent event) {
    if (event == ColorEvent.orange) {
      _color = Colors.orange;
    } else if (event == ColorEvent.green) {
      _color = Colors.green;
    } else
      throw Exception('Чёт пошло не так');

    _outputStateController.sink.add(_color);
  }

  ColorBloc() {
    _inputColorController.stream.listen(_mapEventToState);
  }
  void dispose() {
    _inputColorController.close();
    _outputStateController.close();
  }
}
