// ignore: file_names
// ignore: file_names
// ignore: file_names
// ignore: file_names
// ignore: file_names

import 'package:flutter/material.dart';

// ignore: camel_case_types
class name extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  name({Key? key}) : super(key: key);

  @override
  State<name> createState() => _nameState();
}

// ignore: camel_case_types
class _nameState extends State<name> {
  double value = 0;



  @override
  Widget build(BuildContext context) {
    double _value = 20;
    return Row(
      children: [
        StatefulBuilder(builder: (context,state)=> Slider(
                      value: _value,
                      min: 0.0,
                      max: 100.0,
                      label: "asd",
                      onChanged: (val) {
                        state(() {
                          _value = val;
                        });
                      }
        ),)
        
      ]
    );
  }
}