import 'package:flutter/material.dart';

class newCheck extends StatefulWidget {
  bool value;
  newCheck({Key? key, required bool this.value}) : super(key: key);

  @override
  State<newCheck> createState() => _newCheckState();
}

class _newCheckState extends State<newCheck> {
  @override
  Widget build(BuildContext context) {
    return Center(
          child: InkWell(
            splashColor: Colors.white,
        onTap: () {
          
        },
        child: AnimatedContainer(
          duration: Duration(milliseconds: 200),
          decoration: BoxDecoration(
            border: Border.all(
              width: 1.2,
              color: widget.value ? Colors.transparent : Color.fromRGBO(50, 50, 50, 0.11)
              ),
            shape: BoxShape.circle, 
            color: widget.value ? Color.fromARGB(255, 129, 227, 134) : Color.fromARGB(255, 255, 255, 255),
            boxShadow: <BoxShadow> [BoxShadow(
                color: widget.value ? Color.fromRGBO(50, 50, 50, 0.31) : Color.fromRGBO(50, 50, 50, 0.21),
                offset: Offset(2, 2),
                blurRadius: 10.0
            )]
          ),
          child: Padding(
            padding: const EdgeInsets.all(5.5),
            child: widget.value
                ? Icon(
                    Icons.check,
                    size: 22.0,
                    color: Colors.white,
                  )
                : Icon(
                    Icons.check_box_outline_blank,
                    size: 22.0,
                    color: Colors.transparent,
                  ),
          ),
        ),
      )
    );
  }
}