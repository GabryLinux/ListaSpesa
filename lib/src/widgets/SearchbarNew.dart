import 'package:flutter/material.dart';

class FlatSearchBar extends StatefulWidget {
  final TextEditingController queryText;
  FlatSearchBar({Key? key,required this.queryText}) : super(key: key);

  @override
  State<FlatSearchBar> createState() => _FlatSearchBarState();
}

class _FlatSearchBarState extends State<FlatSearchBar> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.queryText,
      decoration: InputDecoration(
        isDense: true,
        prefixIcon: Icon(Icons.search),
        contentPadding: EdgeInsets.only(left: 100),
        hintText: "Inserisci qui il prodotto",
        filled: true,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7), 
            borderSide: BorderSide.none
          ),
        fillColor: Colors.grey.shade200
      ),
      style: TextStyle(
        color: Colors.grey.shade700,
      ),
    );
  }
}