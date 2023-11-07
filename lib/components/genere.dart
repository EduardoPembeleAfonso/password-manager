import 'package:flutter/material.dart';

class GeneratePassword extends StatefulWidget {
  const GeneratePassword({super.key});

  @override
  State<GeneratePassword> createState() => _GeneratePasswordState();
}

class _GeneratePasswordState extends State<GeneratePassword> {
  double _currentSliderValue = 10;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Slider(
        value: _currentSliderValue,
        max: 100,
        divisions: 5,
        label: _currentSliderValue.round().toString(),
        onChanged: (double value) {
          setState(() {
            _currentSliderValue = value;
          });
        },
      ),
    );
  }
}
