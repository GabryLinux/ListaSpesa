
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:prova/src/widgets/customCheck.dart';


class ListaItem extends StatefulWidget {
  bool checkValue;
  final String product;
  final VoidCallback onChangeCheck;
  String details;
  String quantity;
  ListaItem({Key? key, required bool this.checkValue, required String this.product, required this.onChangeCheck, this.details = "",this.quantity = ""}) : super(key: key);

  @override
  State<ListaItem> createState() => _ListaItemState();
}



class _ListaItemState extends State<ListaItem> {
  @override
  Widget build(BuildContext context) {
    return 
        Container(
          margin: EdgeInsets.only(left:10.0, right: 10.0, top: 7,bottom: 7),
          decoration: BoxDecoration(
            boxShadow: [BoxShadow(
                color: Color.fromRGBO(50, 50, 50, 0.21),
                offset: Offset(2, 2),
                blurRadius: 10.0
              )],
              borderRadius: BorderRadius.all(Radius.circular(100.0))
          ),
          child: ElevatedButton(
            onPressed: () {
              Future.delayed(
                Duration(milliseconds: 200),
                () {
                    
                      widget.onChangeCheck();
                    
                },
              );
              
            }, 
            style: ElevatedButton.styleFrom(
              primary: Colors.white,
              onPrimary: Color.fromARGB(0, 59, 59, 59),
              shape: StadiumBorder(),             
            ),
            child: AnimatedContainer(
              duration: Duration(milliseconds: 200),
              height: 55,
              padding: EdgeInsets.only(left: 10, right: 2),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.product,
                            overflow: TextOverflow.fade,
                            style: TextStyle(
                              color: widget.checkValue ? Color.fromARGB(120, 37, 37, 37) : Color.fromARGB(200, 37, 37, 37),
                              fontSize: 20,
                              fontWeight: FontWeight.w300,
                              decoration: widget.checkValue ? TextDecoration.lineThrough : TextDecoration.none
                              ),
                            ),
                          Text(
                            !widget.checkValue ? widget.quantity : widget.details,
                            style: TextStyle(
                              color:  Color.fromARGB(150, 37, 37, 37) ,
                              fontSize: 13,
                              fontWeight: FontWeight.w300,
                              ),
                            ),
                        ],
                      ),
                    )
                  ),
                  newCheck(value: widget.checkValue)//it's a styled checkbox
                ],
              ),
            )
          ),
        );
      
  }
}



/**
 * 
 * decoration: BoxDecoration(
              boxShadow: [BoxShadow(
                color: Color.fromRGBO(50, 50, 50, 0.21),
                offset: Offset(2, 2),
                blurRadius: 10.0
              )],
              borderRadius: BorderRadius.all(Radius.circular(100.0))
            ), 
 */
