import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  SearchBar({Key? key}) : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBarState();
}
/**TextButton(
              onPressed: () {}, 
              style: TextButton.styleFrom(
                primary: Colors.black
              ),
              child: Text(
                  "Cancel",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w300
                  ),
                )
              ) */


class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(50, 50, 50, 0.21),
              offset: Offset(2, 2),
              blurRadius: 10.0
            )
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
              decoration: InputDecoration(
                icon: Icon(
                  Icons.search,
                  size: 30,
                ),
                border: InputBorder.none,
                hintText: 'Inserisci il prodotto',
                hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 16),
              ),
            ),
          ),
          TextButton(
              onPressed: () {}, 
              style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 10),
                primary: Colors.black
              ),
              child: Text(
                  "Cancella",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w300
                  ),
                )
              )
        ],
      )
    );
  }
}