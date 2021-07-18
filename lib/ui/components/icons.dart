import 'package:flutter/material.dart';

class IconsRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15), topRight: Radius.circular(15))),
        height: 35,
        width: MediaQuery.of(context).size.height * 1.5,
        child: Card(
          elevation: 10,
          color: Colors.amber[200],
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15), topRight: Radius.circular(15))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Icon(Icons.facebook)],
          ),
        ),
      ),
    );
  }
}
