import 'package:flutter/material.dart';

class SearchListItem extends StatefulWidget {
  SearchListItem({Key? key}) : super(key: key);

  @override
  State<SearchListItem> createState() => _SearchListItemState();
}

class _SearchListItemState extends State<SearchListItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 7),
      child: TextButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
          overlayColor: MaterialStateProperty.all<Color>(Colors.black12),
          alignment: Alignment.centerLeft,
          padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.symmetric(horizontal: 10, vertical: 15)),          
        ),
        onPressed: (() {}), 
        child: Text(
          "ELEMENTO LISTA",
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey.shade700
            ),
          ),
        ),
      decoration: BoxDecoration(
        border: Border(
          //bottom: BorderSide(color: Colors.grey.shade600)
        ),
      ),
    );
  }
}