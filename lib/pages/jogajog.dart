import 'package:flutter/material.dart';

class jogajog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,

          centerTitle: true,
          // ignore: prefer_const_constructors
          title: Text(
            "যোগাযোগ",
            style: TextStyle(
                fontFamily: "myfont", fontSize: 18, color: Colors.black),
          ),
        ),
        body: Column(
          children: [
            Image(image: AssetImage("assets/20210604_204426.png")),
            SelectableText("ফোনঃ ০১৮৩৫১১৭৯০৮"),
            SelectableText("ইমেইলঃ byc_2021@outlook.com"),
          ],
        ));
  }
}
