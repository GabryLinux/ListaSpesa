import 'package:flutter/material.dart';
import 'package:prova/src/widgets/Searchlist.dart';


class Searchlistpanel extends StatefulWidget {
  Searchlistpanel({Key? key}) : super(key: key);

  @override
  State<Searchlistpanel> createState() => _SearchlistpanelState();
}

class _SearchlistpanelState extends State<Searchlistpanel> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(50, 50, 50, 0.21),
                offset: Offset(2, 2),
                blurRadius: 10.0
              )
            ]
          ),
          margin: EdgeInsets.symmetric(vertical: 15,horizontal: 20),
          child: SearchList(),
        )
      ],
    );
  }
}