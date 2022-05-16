import 'package:byc_v2/Home_page/variables.dart';
import 'package:byc_v2/pages/info.dart';
import 'package:byc_v2/pages/maintain.dart';
import 'package:byc_v2/pages/newhome.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:mime_type/mime_type.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gsheets/gsheets.dart';

import 'package:image_picker/image_picker.dart';
import 'package:rive/rive.dart' as rive;
import 'package:intl/intl.dart';

import 'package:path/path.dart' as Path;

const _credentials = r'''
{
  "type": "service_account",
  "project_id": "byc-2021",
  "private_key_id": "b0059c89311ae3e2b791b762a28feaf836844ce3",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQCsUQAOAP9I3Phs\nXZF1YKqD+hb6GhXpSvuLtOJN5LrrVAK9koh2bVf/+WVnVm1bMeq/14t5I6bO868D\nW5z/E8r4vUNq5hXnkrBrb5G00ji8QbMnhysywG40tl0xVfGjowIecSB7FqdzR+yi\nc4sZed2HZkcoj6/hSuOkBnHBtOlIEzHe7XsRTDeBwF8nF34h9kowuelrrwgkv/Tx\n16PbqNdRZueC/YGGh+p5iY5fEEsGasIs/xUPdkmx2qCAKnMTXS62MPlcZg72yAOc\nqva0t38QuANAAjEzDrP09cF/zRVWv2CjqIxUE8SVoGxoVtkxYKAxRZYSGQjs5fip\nZOgzFMRLAgMBAAECggEAPluXtfmlaJRSsECSJZSEUHtd+kcbW8//RNkCNmcKP6Qo\n07ql+JlsSZ1SlXlg3KotRhx2BDIjKOxljsUGBQcAIlC3h4VZMvLSNibrZzDWSEZM\nU4cmWljp6Nh/1B1Cc1HHsAWHWBPkKCNEnqtKkL8ZrGiWYrbQ0qpbw91zKELUUvjK\nhYhFxhXQ4xz09otQqOD5AySeTfvK6tvdJui+WJsGmzmELG5qVD3Id7bM+Nmozbat\nj64XIpkhBR8yEjPTx+r/21z7CLQ4N/phnP+PftTDprQAr4qlmSwCRVV3mPCiarjp\nRmNrLKZmWHPisgE50hRGKPsc1sfLGtRwangxCQMvdQKBgQDn8IjnpPxyJvrfSv25\nQpcAZWEUkqNF/WwTN1568mJCIMBlxlbJlvuxuo66hsEhwWudAxZYdEFkdh04SWqL\nrtdPCUt7kbqLSAQbT1volvB2OzXqJkMUPsYZs2FjqiIoND7IrLcTom/VSKO/kK4H\nd06wZ85NGQel48n76Z/qdAj2nQKBgQC+MRegVZ8MjF3zO7fEO80hhR/Ew29YtYhP\nFi0iOdK+KXnzFOoLWfX8ccQkaTmXwTBwbtmRSYeX/jHPMl+pyENy5gmDPD+5gBLw\n/hrM9V3fWjRnHW8+2ZKABcsgSYpmTQiAyUrn6TJ6Lh5bVjjTgSxG+sPxGqcOAM7h\nwl6mzsw+BwKBgQCa1YIvUX6NHeR/x+oVEJUJWKQ0Paftgz3wnhfeb4yUpJSL3Jn3\nPWmMvgOmFWs8g4i5amQybHly/T6IYspTsUZeps/TD/e+HzdOm+25GXoxE1nsk9pX\n24gXhB5RkDP5Ltdy04nr+5Y4haN6sLTcmxLWxJV99mWaorQmDVIKC6goKQKBgQCX\nvJb65hSUcFBsRBKizosj2Q+1ba6h+YKchjbP/Y3zBSg0FVV8ZPNpymIQIps+RXUd\n3nJaBW3Wh4i5o5jK3elh+8FPIHw+xL1X44MCTifskA0Kz2L3o6HL3dNnGQUABSlp\nhi7qwxPwgmbZu/puU7o9jsdQzlDFTUPAvc/CCW7NdQKBgDjsp6U9Wa8HAaV5Fkwy\nRfvoO0rLoBff2i26AJVYOQeNRaHuNxhP1yeOM6cH0LCfiYxyKaCZkaE7u6/rjdHB\nbJRwJyd5WLF6WwE4bmnrfFiLD0lBRmLLdv1u7CUCtl9lDP6xAaMxrtbB1LMjGVJC\n27pTa7clw95UyGWoQF6V39hM\n-----END PRIVATE KEY-----\n",
  "client_email": "byc-375@byc-2021.iam.gserviceaccount.com",
  "client_id": "114041014632448038455",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/byc-375%40byc-2021.iam.gserviceaccount.com"
}
''';
const _spreadsheetId = '1BYV-ZoFD9IkaIjuLTzCcPIJxjVn33d5PdCo12vCdhos';

class tran_his {
  String month;
  String maddom;
  String date;
  String status;
  String jorimana;
  double fee;
  double collection;

  tran_his({
    required this.month,
    required this.maddom,
    required this.date,
    required this.status,
    required this.jorimana,
    required this.fee,
    required this.collection,
  });
}

class userpage extends StatefulWidget {
  const userpage({Key? key}) : super(key: key);

  @override
  State<userpage> createState() => _userpageState();
}

class _userpageState extends State<userpage> {
  bool loading1 = false;
  Future gsheets1(String nam) async {
    // await Future.delayed(const Duration(seconds: 2));
    try {
      // init GSheets
      final gsheets = GSheets(_credentials);
      final ss2 = await gsheets
          .spreadsheet("1b0qyJ6325WcDOB-v4jacprX7g1KZFRa-oRf4PY2eUDc");
      var sheet2 = ss2.worksheetByTitle(nam);
      sheet2 ??= await ss2.addWorksheet(nam);
      var histime1 = await sheet2.values.column(
        4,
        fromRow: 2,
      );
      var hismaddom1 = await sheet2.values.column(
        2,
        fromRow: 2,
      );
      var hismash1 = await sheet2.values.column(
        1,
        fromRow: 2,
      );
      var hisstatus1 = await sheet2.values.column(
        5,
        fromRow: 2,
      );
      var hisjorimana = await sheet2.values.column(
        3,
        fromRow: 2,
      );
      var hisfee1 = await sheet2.values.column(
        6,
        fromRow: 2,
      );
      var hiscollection1 = await sheet2.values.column(
        7,
        fromRow: 2,
      );

      List<dynamic> li = [];
      for (var i = 0; i < histime1.length; i++) {
        tran_his user = tran_his(
          month: hismash1[i],
          maddom: hismaddom1[i],
          date: histime1[i],
          status: hisstatus1[i],
          jorimana: hisjorimana[i],
          collection: double.parse(hiscollection1[i]),
          fee: double.parse(hisfee1[i]),
        );
        li.add(user);
      }

      return li.reversed.toList();
    } catch (e) {
      AlertDialog(
        title: Text("some thing went wrong"),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: size.width > 480
          ? main234(context, size)
          : Column(
              children: [
                focus(context, loading1),
                Expanded(
                  child: Container(
                    // margin: EdgeInsets.symmetric(horizontal: 60),
                    margin: EdgeInsets.symmetric(
                        horizontal: size.width > 900
                            ? (size.width * 0.05)
                            : (size.width * 0.01)),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey[500]!,
                          offset: Offset(4, 4),
                          blurRadius: 20,
                          spreadRadius: 1.5,
                        ),
                        const BoxShadow(
                          color: Colors.white,
                          offset: Offset(-4, -4),
                          blurRadius: 20,
                          spreadRadius: 1.5,
                        ),
                      ],
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15)),
                      gradient: const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomRight,
                          // stops: [
                          //   0.1,
                          //   0.2,
                          //   0.3,
                          //   0.4
                          // ],
                          colors: [
                            Color(0xFFFF512F),
                            Color(0xFFDD2476),

                            // Color(0xFFb5179e),
                            // Color(0xFFf72585),
                          ]),
                    ),

                    child: Stack(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.05,
                          child: FittedBox(
                            child: Row(
                              children: [
                                Icon(
                                  Icons.history,
                                  color: Colors.white,
                                  size: 100,
                                ),
                                Text(
                                  "লেনদেন সমুহঃ",
                                  style: TextStyle(
                                    fontFamily: 'myfont',
                                    color: Colors.white,
                                    fontSize: 100,
                                    // fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.06),
                          child: FutureBuilder(
                            future: FirebaseFirestore.instance
                                .collection('users')
                                .doc(FirebaseAuth.instance.currentUser!.email
                                    .toString())
                                .collection('balanceHIS')
                                .orderBy('month', descending: true)
                                .get(),
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              if (snapshot.hasError) {
                                // ignore: prefer_const_constructors
                                // return Center(child: Text("Something went Wrong!"));

                              }
                              if (snapshot.hasData) {
                                return ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    itemCount: snapshot.data.docs.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      // DateTime dateTime = dateFormat.parse("2019-07-19 8:40:23");
                                      DateTime date = DateTime.parse(
                                          snapshot.data.docs[index]['month']);
                                      // print(DateFormat.yMMMM('en_US')
                                      //     .format(date));
                                      var def =
                                          (DateTime.now().compareTo(date));

                                      return Container(
                                          padding: const EdgeInsets.only(
                                              left: 6, top: 6, right: 6),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          margin: EdgeInsets.only(
                                            left: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.04,
                                            top: 4,
                                            bottom: 3,
                                            right: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.04,
                                          ),
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.13,
                                          child: Column(
                                            // crossAxisAlignment:
                                            //     CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                flex: 3,
                                                child: Row(
                                                  // crossAxisAlignment:
                                                  //     CrossAxisAlignment
                                                  //         .center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Expanded(
                                                      flex: 1,
                                                      child: FittedBox(
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            RichText(
                                                                text: TextSpan(
                                                                    style:
                                                                        TextStyle(
                                                                      fontFamily:
                                                                          'myfont',
                                                                      color: Color(
                                                                          0xFF455A64),
                                                                      // color: Color(
                                                                      //     0xFF43aa8b),
                                                                      fontSize:
                                                                          100,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    ),
                                                                    children: [
                                                                  TextSpan(
                                                                      text:
                                                                          "মাস :- "),
                                                                  TextSpan(
                                                                      text:
                                                                          "${DateFormat.yMMMM('en_US').format(date)}",
                                                                      style: TextStyle(
                                                                          color: def > 0
                                                                              ? Color(0xFF455A64)
                                                                              : Color(0xFF43aa8b))),
                                                                  def < 0
                                                                      ? TextSpan(
                                                                          text:
                                                                              " Advance*",
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                60,
                                                                            color:
                                                                                Color(0xFF43aa8b),
                                                                          ))
                                                                      : TextSpan(),
                                                                ])),
                                                            Text(
                                                              "মাধ্যম :- ${snapshot.data.docs[index]['maddom']}",
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    'myfont',
                                                                color: Color(
                                                                    0xFF455A64),
                                                                fontSize: snapshot.data.docs[index]['maddom'] ==
                                                                            "মোবাইল ব্যাংকিং" ||
                                                                        snapshot.data.docs[index]['maddom'] ==
                                                                            "অর্থ সম্পাদক"
                                                                    ? 70
                                                                    : 60,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.01,
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child: FittedBox(
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceAround,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                              "+${snapshot.data.docs[index]['fee'].round().toString()} ৳",
                                                              style:
                                                                  const TextStyle(
                                                                fontFamily:
                                                                    "myfont",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 100,
                                                                color: Colors
                                                                    .green,
                                                              ),
                                                            ),
                                                            snapshot.data.docs[
                                                                            index]
                                                                        [
                                                                        'collection'] !=
                                                                    0.0
                                                                ? Text(
                                                                    "+${snapshot.data.docs[index]['collection'].round()}৳",
                                                                    style:
                                                                        const TextStyle(
                                                                      fontFamily:
                                                                          "myfont",
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          80,
                                                                      color: Colors
                                                                          .amber,
                                                                    ),
                                                                  )
                                                                : FittedBox(),
                                                            snapshot.data.docs[
                                                                            index]
                                                                        [
                                                                        'jorimana'] ==
                                                                    true
                                                                ? Text(
                                                                    "+20৳",
                                                                    style:
                                                                        TextStyle(
                                                                      fontFamily:
                                                                          "myfont",
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          80,
                                                                      color: Colors
                                                                          .redAccent,
                                                                    ),
                                                                  )
                                                                : FittedBox(),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Align(
                                                    alignment:
                                                        Alignment.bottomRight,
                                                    child: Padding(
                                                      padding: EdgeInsets.only(
                                                          right: 10),
                                                      child: FittedBox(
                                                        child: Text(
                                                          "তালিকা ভুক্ত ${snapshot.data.docs[index]['date']}",
                                                          style: TextStyle(
                                                            fontSize: 50,
                                                            fontFamily:
                                                                "myfont",
                                                            color: Color(
                                                                0xFF455A64),
                                                          ),
                                                        ),
                                                      ),
                                                    )),
                                              )
                                            ],
                                          ));
                                    });
                              }
                              return Center(
                                child: Column(
                                  children: [
                                    Expanded(
                                        child: rive.RiveAnimation.asset(
                                            "assets/501-961-document-icon.riv")),
                                    Text(
                                      "লোড হচ্ছে...",
                                      style: TextStyle(
                                          fontFamily: "myfont",
                                          fontSize: 20,
                                          color: Colors.white),
                                    )
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  ListView main234(BuildContext context, Size size) {
    return ListView(
      children: [
        focus(context, loading1),
        Container(
          // margin: EdgeInsets.symmetric(horizontal: 60),
          margin: EdgeInsets.symmetric(
              horizontal:
                  size.width > 900 ? (size.width * 0.05) : (size.width * 0.01)),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey[500]!,
                offset: Offset(4, 4),
                blurRadius: 20,
                spreadRadius: 1.5,
              ),
              const BoxShadow(
                color: Colors.white,
                offset: Offset(-4, -4),
                blurRadius: 20,
                spreadRadius: 1.5,
              ),
            ],
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15), topRight: Radius.circular(15)),
            gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomRight,
                // stops: [
                //   0.1,
                //   0.2,
                //   0.3,
                //   0.4
                // ],
                colors: [
                  Color(0xFFFF512F),
                  Color(0xFFDD2476),

                  // Color(0xFFb5179e),
                  // Color(0xFFf72585),
                ]),
          ),

          // color: Colors.amber,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.05,
                child: FittedBox(
                  child: Row(
                    children: [
                      Icon(
                        Icons.history,
                        color: Colors.white,
                        size: 100,
                      ),
                      Text(
                        "লেনদেন সমুহঃ",
                        style: TextStyle(
                          fontFamily: 'myfont',
                          color: Colors.white,
                          fontSize: 100,
                          // fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.06),
                child: FutureBuilder(
                  future: FirebaseFirestore.instance
                      .collection('users')
                      .doc(FirebaseAuth.instance.currentUser!.email.toString())
                      .collection('balanceHIS')
                      .orderBy('month', descending: true)
                      .get(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasError) {
                      // ignore: prefer_const_constructors
                      // return Center(child: Text("Something went Wrong!"));

                    }
                    if (snapshot.hasData) {
                      return ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: snapshot.data.docs.length,
                          itemBuilder: (BuildContext context, int index) {
                            // DateTime dateTime = dateFormat.parse("2019-07-19 8:40:23");
                            DateTime date = DateTime.parse(
                                snapshot.data.docs[index]['month']);
                            // print(DateFormat.yMMMM('en_US')
                            //     .format(date));
                            var def = (DateTime.now().compareTo(date));

                            return Container(
                                padding: const EdgeInsets.only(
                                    left: 6, top: 6, right: 6),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                margin: EdgeInsets.only(
                                  left:
                                      MediaQuery.of(context).size.width * 0.04,
                                  top: 4,
                                  bottom: 3,
                                  right:
                                      MediaQuery.of(context).size.width * 0.04,
                                ),
                                height:
                                    MediaQuery.of(context).size.height * 0.13,
                                child: Column(
                                  // crossAxisAlignment:
                                  //     CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Row(
                                        // crossAxisAlignment:
                                        //     CrossAxisAlignment
                                        //         .center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            flex: 2,
                                            child: FittedBox(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  RichText(
                                                      text: TextSpan(
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'myfont',
                                                            color: Color(
                                                                0xFF455A64),
                                                            // color: Color(
                                                            //     0xFF43aa8b),
                                                            fontSize: 100,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                          children: [
                                                        TextSpan(
                                                            text: "মাস :- "),
                                                        TextSpan(
                                                            text:
                                                                "${DateFormat.yMMMM('en_US').format(date)}",
                                                            style: TextStyle(
                                                                color: def > 0
                                                                    ? Color(
                                                                        0xFF455A64)
                                                                    : Color(
                                                                        0xFF43aa8b))),
                                                        def < 0
                                                            ? TextSpan(
                                                                text:
                                                                    " Advance*",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 60,
                                                                  color: Color(
                                                                      0xFF43aa8b),
                                                                ))
                                                            : TextSpan(),
                                                      ])),
                                                  Text(
                                                    "মাধ্যম :- ${snapshot.data.docs[index]['maddom']}",
                                                    style: TextStyle(
                                                      fontFamily: 'myfont',
                                                      color: Color(0xFF455A64),
                                                      fontSize: snapshot.data.docs[
                                                                          index]
                                                                      [
                                                                      'maddom'] ==
                                                                  "মোবাইল ব্যাংকিং" ||
                                                              snapshot.data.docs[
                                                                          index]
                                                                      [
                                                                      'maddom'] ==
                                                                  "অর্থ সম্পাদক"
                                                          ? 70
                                                          : 60,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.01,
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: FittedBox(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "+${snapshot.data.docs[index]['fee'].round().toString()} ৳",
                                                    style: const TextStyle(
                                                      fontFamily: "myfont",
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 100,
                                                      color: Colors.green,
                                                    ),
                                                  ),
                                                  snapshot.data.docs[index]
                                                              ['collection'] !=
                                                          0.0
                                                      ? Text(
                                                          "+${snapshot.data.docs[index]['collection'].round()}৳",
                                                          style:
                                                              const TextStyle(
                                                            fontFamily:
                                                                "myfont",
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 90,
                                                            color: Colors.amber,
                                                          ),
                                                        )
                                                      : FittedBox(),
                                                  snapshot.data.docs[index]
                                                              ['jorimana'] ==
                                                          'true'
                                                      ? Text(
                                                          "+20৳",
                                                          style: TextStyle(
                                                            fontFamily:
                                                                "myfont",
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 80,
                                                            color: Colors
                                                                .redAccent,
                                                          ),
                                                        )
                                                      : FittedBox(),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Align(
                                          alignment: Alignment.bottomRight,
                                          child: Padding(
                                            padding: EdgeInsets.only(right: 10),
                                            child: FittedBox(
                                              child: Text(
                                                "তালিকা ভুক্ত ${snapshot.data.docs[index]['date']}",
                                                style: TextStyle(
                                                  fontSize: 50,
                                                  fontFamily: "myfont",
                                                  color: Color(0xFF455A64),
                                                ),
                                              ),
                                            ),
                                          )),
                                    )
                                  ],
                                ));
                          });
                    }
                    return Center(
                      child: Column(
                        children: [
                          Expanded(
                              child: rive.RiveAnimation.asset(
                                  "assets/501-961-document-icon.riv")),
                          Text(
                            "লোড হচ্ছে...",
                            style: TextStyle(
                                fontFamily: "myfont",
                                fontSize: 20,
                                color: Colors.white),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  focus(BuildContext context, bool loading) {
    return loading
        ? SizedBox(
            height: MediaQuery.of(context).size.height * 0.4,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Container(
            height: MediaQuery.of(context).size.width > 480
                ? MediaQuery.of(context).size.height * 0.4
                : MediaQuery.of(context).size.height * 0.3,
            // width: 300,
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey[500]!,
                    offset: Offset(4, 4),
                    blurRadius: 20,
                    spreadRadius: 1.5,
                  ),
                  BoxShadow(
                    color: Colors.white,
                    offset: Offset(-4, -4),
                    blurRadius: 20,
                    spreadRadius: 1.5,
                  ),
                ],
                // color: Colors.amber,
                gradient: const LinearGradient(
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
                borderRadius: BorderRadius.circular(25)),
            margin: EdgeInsets.only(
              top: MediaQuery.of(context).size.width < 480
                  ? (MediaQuery.of(context).size.height * 0.03)
                  : MediaQuery.of(context).size.height * 0.08,
              left: MediaQuery.of(context).size.width * 0.1,
              right: MediaQuery.of(context).size.width * 0.1,
              bottom: MediaQuery.of(context).size.width < 480
                  ? (MediaQuery.of(context).size.height * 0.02)
                  : MediaQuery.of(context).size.height * 0.05,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      // height: MediaQuery.of(context).size.height * 0.1,
                      // width: MediaQuery.of(context).size.width * 0.24,
                      child: FittedBox(
                        child: Text(
                          'ব্যক্তিগত সঞ্চয়',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'myfont',
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Spacer(),
                  Expanded(
                    flex: 3,
                    child: Container(
                      // height: MediaQuery.of(context).size.height * 0.08,
                      // width: MediaQuery.of(context).size.width * 0.2,
                      child: FittedBox(
                        child: Row(
                          children: [
                            Column(
                              children: [
                                GestureDetector(
                                  onTap: updatepic,
                                  child: Container(
                                    height: 80,
                                    width: 80,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 2.0, color: Colors.white),
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                          profile_url,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                TextButton(
                                    onPressed: updatepic,
                                    child: Text(
                                      'Update Profile',
                                      style: TextStyle(color: Colors.white70),
                                    ))
                              ],
                            ),
                            SizedBox(
                              width: 3,
                            ),
                            Text(
                              "$profile_name",
                              style: const TextStyle(
                                  fontFamily: "myfont",
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  Expanded(
                    flex: 4,
                    child: AnimatedContainer(
                      duration: Duration(seconds: 2),
                      child: TweenAnimationBuilder(
                        // child: const Center(
                        //   child: Text("hii"),
                        // ),
                        tween:
                            Tween<double>(begin: 0.00, end: profile_taka + 0.0),
                        duration: const Duration(seconds: 2),
                        builder:
                            (BuildContext context, double _val, Widget? child) {
                          int a = _val.round();
                          return Center(
                            child: FittedBox(
                              child: Text("$a৳",
                                  style: TextStyle(
                                      fontFamily: "myfont",
                                      fontWeight: FontWeight.bold,
                                      fontSize: a.isEven ? 100 : 80,
                                      color: Colors.white)),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  profile_Post == "অর্থসম্পাদক"
                      ? Expanded(
                          flex: 1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                height: 30,
                                width: 30,
                                child: IconButton(
                                  onPressed: () => Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context) => edit())),
                                  icon: Icon(
                                    Icons.shield_outlined,
                                    color: Colors.white70,
                                    size: 24,
                                  ),
                                ),
                              ),
                              FittedBox(
                                child: Text(
                                  "April 2021 - ${DateFormat.yMMMM('en_US').format(DateTime.now())}",
                                  style: TextStyle(
                                      color: Colors.white60, fontSize: 30),
                                ),
                              ),
                            ],
                          ),
                        )
                      : Expanded(
                          flex: 1,
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: FittedBox(
                              child: Text(
                                "April 2021 - ${DateFormat.yMMMM('en_US').format(DateTime.now())}",
                                style: TextStyle(
                                    color: Colors.white60, fontSize: 30),
                              ),
                            ),
                          ),
                        )
                ],
                // সাংগঠনিক সঞ্চয়ঃ
              ),
            ),
          );
  }

  Future<void> updatepic() async {
    var pickedfile = await ImagePicker().pickImage(
      source: ImageSource.gallery,

      // maxWidth: maxWidth,
      // maxHeight: maxHeight,
      imageQuality: 100,
    );

    if (pickedfile != null) {
      print('${mime(pickedfile.name)}');
      setState(() {
        loading1 = true;
      });

      if (mime(pickedfile.name) == 'image/jpeg') {
        Reference _reference = FirebaseStorage.instance
            .ref()
            .child('profiles/${Path.basename(pickedfile.path)}');
        await _reference
            .putData(
          await pickedfile.readAsBytes(),
          SettableMetadata(contentType: 'image/jpeg'),
        )
            .whenComplete(() async {
          await _reference.getDownloadURL().then((value1) async {
            await FirebaseFirestore.instance
                .collection('users')
                .doc(FirebaseAuth.instance.currentUser!.email)
                .update({
              'Url': value1,
            });

            setState(() {
              loading1 = false;
            });
            await FirebaseStorage.instance.refFromURL(profile_url).delete();
            profile_url = value1;
          }).then((value) => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => newhome(
                  direct: false,
                  post: profile_Post,
                  nameban: profile_name,
                  taka: profile_taka))));
        });
      } else {
        setState(() {
          loading1 = false;
        });
        showErrDialog(context, 'Image must be in a jpeg format');
      }
    } else {
      setState(() {
        loading1 = false;
      });
    }
  }
}

class edit extends StatelessWidget {
  const edit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
      ),
      // backgroundColor: Colors.amberAccent,
      body: MediaQuery.of(context).size.width > 768
          ? Center(
              child: PhysicalModel(
                color: Colors.white,
                elevation: 8,
                shadowColor: Colors.grey,
                borderRadius: BorderRadius.circular(30),
                child: Container(
                    height: MediaQuery.of(context).size.height * 0.7,
                    width: MediaQuery.of(context).size.width * 0.3,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      // boxShadow: [
                      //   BoxShadow(
                      //     color: Colors.white.withOpacity(0.3),
                      //     offset: Offset(4, 4),
                      //     blurRadius: 15,
                      //     spreadRadius: 1.5,
                      //   ),
                      //   BoxShadow(
                      //     color: Colors.white.withOpacity(0.3),
                      //     offset: Offset(-4, -4),
                      //     blurRadius: 15,
                      //     spreadRadius: 1.5,
                      //   ),
                      // ],
                      // border: Border.all(width: 1.5, color: Colors.redAccent),
                      borderRadius: BorderRadius.all(
                        Radius.circular(30),
                      ),
                    ),
                    child: edit1(context)),
              ),
            )
          : edit1(context),
    );
  }

  Column edit1(BuildContext context) {
    return Column(
      // crossAxisAlignment: CrossAxisAlignment.center,
      // mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * .03,
        ),
        Center(
          child: Text(
            "মোট সাংগঠনিক সঞ্চয়ঃ",
            style: TextStyle(
                fontSize: 25,
                color: Colors.black,
                fontFamily: "myfont",
                fontWeight: FontWeight.bold),
          ),
        ),
        StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance
                .collection("list")
                .doc('balance')
                .snapshots(),
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Loading...');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    // "Total: ${snapshot.data!['Total']}",

                    "${snapshot.data!['Total']}৳",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black, fontSize: 45),
                  ),
                  IconButton(
                      onPressed: () => shownotice5(
                          context,
                          snapshot.data!['Total'],
                          'balance',
                          "মোট সাংগঠনিক সঞ্চয়ঃ"),
                      icon: Icon(Icons.edit))
                ],
              );
            }),
        StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance
                .collection("list")
                .doc('balance2')
                .snapshots(),
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Loading...');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    // "Total: ${snapshot.data!['Total']}",

                    "মোট জরিমানাঃ ${snapshot.data!['Total']}৳",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 20,
                        fontFamily: "myfont"),
                  ),
                  IconButton(
                      onPressed: () {
                        shownotice5(context, snapshot.data!['Total'] + .0,
                            "balance2", 'মোট জরিমানাঃ');
                      },
                      icon: Icon(Icons.edit))
                ],
              );
            }),
        // Divider(),
        Expanded(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.75,
            child: StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('users').snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text("Loading");
                }

                return ListView(
                  children:
                      snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data =
                        document.data()! as Map<String, dynamic>;
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => info(
                                  nam: data['নাম'],
                                  taka: data['Balance'] + 0.0,
                                )));
                      },
                      child: ListTile(
                        trailing: IconButton(
                            onPressed: () =>
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => info(
                                          nam: data['নাম'],
                                          taka: data['Balance'] + 0.0,
                                        ))),
                            // shownotice1(
                            //     context, data['নাম'], data['Balance'] + .0),
                            icon: Icon(Icons.edit)),
                        leading: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                                border:
                                    Border.all(width: 2.0, color: Colors.white),
                                shape: BoxShape.circle,
                                image: new DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(data['Url'])))),
                        title: Text(
                          data['নাম'],
                          style: TextStyle(color: Colors.black),
                        ),
                        subtitle: Text(
                          'Balance: ${data['Balance'].toString()}৳',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  void shownotice5(
      BuildContext context, double Balance, String nam, String heading) {
    showDialog(
      context: context,
      builder: (_) {
        var newbalance;
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          backgroundColor: Colors.redAccent,
          title: Text(
            heading,
            style: TextStyle(color: Colors.white70, fontFamily: 'myfont'),
          ),
          content: TextFormField(
            autofocus: true,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
                labelStyle: TextStyle(color: Colors.white),
                // border: new OutlineInputBorder(
                //     borderRadius: const BorderRadius.all(
                //         const Radius.circular(30.0))),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent)),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                  color: Colors.white,
                )),
                fillColor: Colors.amber,
                labelText: Balance.toString()),
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
//                inputFormatters: <TextInputFormatter>[
//     FilteringTextInputFormatter.digitsOnly
// ],
//             // initialValue: Balance,
            onChanged: (val) {
              var myInt = int.parse(val);
              assert(myInt is int);
              newbalance = myInt;
            },
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  "Cancel",
                  style: TextStyle(color: Colors.white),
                )),
            TextButton(
                onPressed: () async {
                  // print(newbalance);
                  Navigator.of(context).pop();

                  await FirebaseFirestore.instance
                      .collection('list')
                      .doc(nam)
                      .update({
                    'Total': newbalance,
                  }).then((value) => Fluttertoast.showToast(
                          msg: "সফল হয়েছে!",
                          backgroundColor: Colors.redAccent));
                },
                child: Text(
                  "update",
                  style: TextStyle(color: Colors.white),
                )),
          ],
          // backgroundColor:colo
        );
      },
    );
  }
}
