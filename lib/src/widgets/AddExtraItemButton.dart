import 'package:flutter/material.dart';
import 'package:prova/src/widgets/modalPanel.dart';


class AddExtraButton extends StatefulWidget {
  final String product;
  AddExtraButton({Key? key,this.product = ""}) : super(key: key);

  @override
  State<AddExtraButton> createState() => _AddExtraButtonState();
}

class _AddExtraButtonState extends State<AddExtraButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.grey.shade200,
                                width: 1
                              )
                            )
                          ),
                          child: TextButton(
                            onPressed: () {
                              showModalBottomSheet(
                                isScrollControlled: true,
                                context: context, 
                                backgroundColor: Colors.transparent,
                                builder: (context) => modalPanel(product: widget.product,)
                              ).then((value) => null);
                            },
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.symmetric(horizontal: 15,vertical: 15),
                              alignment: Alignment.centerLeft,
                              primary: Colors.grey.shade500
                            ), 
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Aggiungi prodotto fuori lista",
                                  style: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                  ),
                                ),
                                
                              ],
                            )
                          )
                        );
  }
}