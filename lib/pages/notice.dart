import 'dart:math';

import 'package:byc_v2/Home_page/variables.dart';
import 'package:byc_v2/pages/message.dart';
import 'package:byc_v2/pages/noticeview.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:rive/rive.dart' as rive;
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:ui';

class notice extends StatelessWidget {
  const notice({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var lmt = 3;
    // print(size.height);
    // print(widget.li2[1]['title'].length);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => createmsg())),
        child: Icon(Icons.edit_notifications_outlined),
      ),
      body: SafeArea(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          // shrinkWrap: true,
          children: [
            const SizedBox(
              height: 10,
            ),
            Flexible(
              flex: 1,
              child: FittedBox(
                child: Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          stops: [
                            .65,
                            1
                          ],
                          colors: [
                            Color(0xFFff5e62),
                            Color(0xFFff9966),
                          ]),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.red.withOpacity(0.3),
                          offset: Offset(4, 4),
                          blurRadius: 15,
                          spreadRadius: 1.5,
                        ),
                        BoxShadow(
                          color: Colors.white,
                          offset: Offset(-4, -4),
                          blurRadius: 15,
                          spreadRadius: 1.5,
                        ),
                      ],
                      border: Border.all(width: 2, color: Colors.white),
                      borderRadius: BorderRadius.all(Radius.circular(50))),
                  child: Text(
                    "সাংগঠনিক নোটিশ",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'myfont',
                      fontWeight: FontWeight.bold,
                      fontSize: 100,
                    ),
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 4,
              child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("notice")
                      // .orderBy('date', descending: true)

                      .orderBy('date', descending: true)
                      .limit(lmt)
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {}

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (snapshot.data!.docs.isEmpty) {
                      return const Center(
                        child: FittedBox(
                          child: rive.RiveAnimation.asset(
                              "assets/501-961-document-icon.riv"),
                        ),
                      );
                    } else {
                      return Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: CarouselSlider(
                          items: snapshot.data!.docs
                              .map((DocumentSnapshot document) {
                            Map<String, dynamic> data1 =
                                document.data() as Map<String, dynamic>;
                            RegExp re = RegExp(r"(\w+)");
                            List li = [];
                            Iterable matches = re.allMatches(data1['date']);
                            matches.forEach((match) {
                              //         // print(a['date'].substring(match.start, match.end));
                              li.add(data1['date']
                                  .substring(match.start, match.end));
                            });
                            var _color = Colors.primaries[
                                    Random().nextInt(Colors.primaries.length)]
                                [Random().nextInt(9) * 100];
                            // var colorsa=invert

                            return data1['img'] != null
                                ? GestureDetector(
                                    onTap: (() {
                                      shownotice(
                                          data1['title'],
                                          data1['body'],
                                          context,
                                          false,
                                          '${li[2]}-${li[1]}-${li[0]}');
                                    }),
                                    child: Container(
                                      // height: MediaQuery.of(context).size.height * 0.2,
                                      // width: MediaQuery.of(context).size.width * 0.6,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)),
                                        image: DecorationImage(
                                            image: NetworkImage(data1['img']),
                                            fit: MediaQuery.of(context)
                                                        .size
                                                        .width >
                                                    480
                                                ? BoxFit.fill
                                                : BoxFit.fill),
                                      ),
                                    ),
                                  )
                                : GestureDetector(
                                    onTap: (() {
                                      shownotice(
                                          data1['title'],
                                          data1['body'],
                                          context,
                                          false,
                                          '${li[2]}-${li[1]}-${li[0]}');
                                    }),
                                    child: Container(
                                      padding: EdgeInsets.all(30),
                                      decoration: BoxDecoration(
                                          color: _color,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20))),
                                      child: Center(
                                        child: FittedBox(
                                            child: Text(
                                          '${data1['title']}',
                                          style: TextStyle(
                                              // color: Colors.
                                              fontSize: 100,
                                              fontFamily: 'myfont'),
                                        )),
                                      ),
                                    ),
                                  );
                          }).toList(),
                          options: options(context),
                        ),
                      );
                    }
                    // oldnt(li, data1),
                  }),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: (() {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => noticeview()));
                }),
                child: Text(
                  'View All',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Divider(),
            Flexible(
              flex: 6,
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFFFF512F),
                        Color(0xFFDD2476),
                      ]),
                ),
                margin: EdgeInsets.symmetric(
                    horizontal: size.width > 900
                        ? (size.width * 0.1)
                        : (size.width * 0.01)),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                // color: Colors.amber,
                // height: MediaQuery.of(context).size.height,
                child: Column(
                  children: [
                    FittedBox(
                      child: Text(
                        "ব্যক্তিগত নোটিশঃ",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'myfont',
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                      ),
                    ),
                    Expanded(
                      child: StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('users')
                            .doc(FirebaseAuth.instance.currentUser!.email)
                            .collection("notice")
                            .orderBy('date', descending: true)
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasError) {}

                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: rive.RiveAnimation.asset(
                                  "assets/501-961-document-icon.riv"),
                            );
                          }
                          if (snapshot.data!.docs.isEmpty) {
                            return Center(
                              child: Column(
                                children: [
                                  rive.RiveAnimation.asset(
                                      "assets/501-961-document-icon.riv"),
                                  Text(
                                    "কোনো নোটিশ নেই!",
                                    style: TextStyle(
                                        fontFamily: "myfont",
                                        fontSize: 16,
                                        color: Colors.white),
                                  )
                                ],
                              ),
                            );
                          } else {
                            return ListView(
                                children: snapshot.data!.docs
                                    .map((DocumentSnapshot document) {
                              Map<String, dynamic> data =
                                  document.data() as Map<String, dynamic>;
                              RegExp re = RegExp(r"(\w+)");
                              List li = [];
                              Iterable matches = re.allMatches(data['date']);
                              matches.forEach((match) {
                                //         // print(a['date'].substring(match.start, match.end));
                                li.add(data['date']
                                    .substring(match.start, match.end));
                              });

                              return GestureDetector(
                                onTap: () {
                                  shownotice(
                                      data['title'],
                                      data['body'],
                                      context,
                                      true,
                                      "${li[2]}-${li[1]}-${li[0]}");
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20)),
                                  margin: const EdgeInsets.all(5),
                                  height: size.height * 0.13,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Flexible(
                                        flex: 1,
                                        child: FittedBox(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "   ${li[2]}-${li[1]}-${li[0]}",
                                                style: const TextStyle(
                                                  fontFamily: 'myfont',
                                                  color: Color(0xFF455A64),
                                                  fontSize: 50,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              data['to'] == "admin"
                                                  ? Icon(
                                                      Icons.shield_outlined,
                                                      color: Colors.green,
                                                    )
                                                  : SizedBox(),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: FittedBox(
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(left: 30),
                                            child: Text(
                                              "${data['title']}",
                                              maxLines: 2,
                                              style: TextStyle(
                                                fontFamily: 'myfont',
                                                color: Colors.black,
                                                fontSize: 80,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Flexible(
                                        flex: 1,
                                        child: Align(
                                          alignment: Alignment.bottomRight,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                right: 10),
                                            child: FittedBox(
                                              child: Text(
                                                "~${data['from']}",
                                                style: TextStyle(
                                                  fontSize: 30,
                                                  fontFamily: "myfont",
                                                  color: Colors.blueGrey,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }).toList());
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container oldnt(List<dynamic> li, Map<String, dynamic> data1) {
    return Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            color: Colors.redAccent, borderRadius: BorderRadius.circular(20)),
        margin: EdgeInsets.only(left: 5, right: 5),
        width: 240,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "   ${li[2]}-${li[1]}-${li[0]}",
                  style: const TextStyle(
                    fontFamily: 'myfont',
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                data1['to'] == "admin"
                    ? Icon(
                        Icons.shield_outlined,
                        color: Colors.white,
                      )
                    : FittedBox(),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  "${data1['title']}",
                  style: TextStyle(
                    fontFamily: 'myfont',
                    color: Colors.white,
                    fontSize: data1['title'].length > 50 ? 12 : 16,
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "${data1['from']}",
                  style: TextStyle(
                    fontFamily: "myfont",
                    color: Colors.white70,
                  ),
                ),
                Icon(
                  Icons.short_text_outlined,
                  color: Colors.white,
                )
              ],
            )
          ],
        ));
  }

  CarouselOptions options(BuildContext context) {
    return CarouselOptions(
      height: MediaQuery.of(context).size.height * 0.4,
      aspectRatio: 1 / 1,
      viewportFraction: MediaQuery.of(context).size.width < 480 ? 0.6 : 0.4,
      initialPage: 0,
      // enableInfiniteScroll: true,
      reverse: false,
      autoPlay: true,
      // autoPlayInterval: Duration(seconds: 3),
      autoPlayAnimationDuration: const Duration(milliseconds: 800),
      autoPlayCurve: Curves.fastOutSlowIn,
      enlargeCenterPage: true,
      // onPageChanged: callbackFunction,
      scrollDirection: Axis.horizontal,
    );
  }
}

void shownotice(
    String title, String body, BuildContext context, bool per, String date) {
  showDialog(
    context: context,
    builder: (_) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        backgroundColor: per ? Colors.white : Colors.redAccent,
        // backgroundColor:colo

        title: Row(
          children: [
            Expanded(
              child: Text(
                '$title',
                style: TextStyle(
                    color: per ? const Color(0xFF455A64) : Colors.white,
                    fontFamily: "myfont",
                    fontSize: 23),
              ),
            ),
            Text(
              '$date',
              style: TextStyle(
                color: per ? const Color(0xFF455A64) : Colors.white,
                fontFamily: "myfont",
                fontSize: 16,
              ),
            ),
          ],
        ),
        content: SingleChildScrollView(
            child: Text(
          '$body',
          style: TextStyle(
              color: per ? const Color(0xFF455A64) : Colors.white,
              fontFamily: "myfont",
              fontSize: 20),
        )),
      );
    },
  );
}
