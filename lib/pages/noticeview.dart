import 'dart:math';

import 'package:byc_v2/Home_page/variables.dart';
import 'package:byc_v2/pages/notice.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart' as rive;

class noticeview extends StatelessWidget {
  const noticeview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('সাংগঠনিক নোটিশ'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
        child: StreamBuilder<QuerySnapshot>(
          stream: profile_Post != "সদস্য"
              ? FirebaseFirestore.instance
                  .collection("notice")
                  .orderBy('date', descending: true)
                  .snapshots()
              : FirebaseFirestore.instance
                  .collection("notice")
                  .where("to", isEqualTo: "member")
                  .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {}

            if (snapshot.connectionState == ConnectionState.waiting) {
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
                  children:
                      snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data() as Map<String, dynamic>;
                RegExp re = RegExp(r"(\w+)");
                List li = [];
                Iterable matches = re.allMatches(data['date']);
                matches.forEach((match) {
                  //         // print(a['date'].substring(match.start, match.end));
                  li.add(data['date'].substring(match.start, match.end));
                });

                return GestureDetector(
                  onTap: () {
                    shownotice(data['title'], data['body'], context, true,
                        "${li[2]}-${li[1]}-${li[0]}");
                  },
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            stops: [
                              .65,
                              1
                            ],
                            colors: [
                              Color(0xFFf5f7fa),
                              Color(0xFFb8c6db),
                            ]),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white.withOpacity(0.3),
                            offset: Offset(4, 4),
                            blurRadius: 10,
                            spreadRadius: 1,
                          ),
                          BoxShadow(
                            color: Colors.white,
                            offset: Offset(-4, -4),
                            blurRadius: 10,
                            spreadRadius: 1,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(20)),
                    margin: const EdgeInsets.all(5),
                    height: size.height * 0.13,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          flex: 1,
                          child: FittedBox(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              padding: const EdgeInsets.only(left: 30),
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
                              padding: const EdgeInsets.only(right: 10),
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
    );
  }
}
