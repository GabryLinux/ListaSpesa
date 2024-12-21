import 'package:flutter/material.dart';

class FlatSearchBar extends StatefulWidget {
  FlatSearchBar({Key? key}) : super(key: key);

  @override
  State<FlatSearchBar> createState() => _FlatSearchBarState();
}

class _FlatSearchBarState extends State<FlatSearchBar> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        isDense: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        fillColor: Colors.grey.shade300,
        hintText: "Inserisci qui il prodotto da aggiungere"
      ),
      style: TextStyle(
        color: Colors.grey.shade700
      ),
    );
  }
}