import 'package:flutter/material.dart';

class BuildDrawerHeader extends StatelessWidget {
  const BuildDrawerHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
        margin: EdgeInsets.zero,
        padding: EdgeInsets.zero,
        decoration: BoxDecoration(color: Colors.cyan[900]),
        child: Stack(children: const <Widget>[
          Positioned(
              bottom: 20.0,
              left: 20.0,
              child: Text("UnderMatch",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500))),
        ]));
  }
}
