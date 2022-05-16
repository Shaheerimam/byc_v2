import 'package:byc_v2/Home_page/pages.dart';
import 'package:byc_v2/Home_page/variables.dart';
import 'package:byc_v2/pages/lendeneditpage.dart';
import 'package:byc_v2/pages/maintain.dart';
import 'package:byc_v2/pages/profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gsheets/gsheets.dart';
import 'package:rive/rive.dart';
import 'package:intl/intl.dart';

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

class info extends StatefulWidget {
  final String nam;
  double taka;
  info({required this.nam, required this.taka});

  @override
  _infoState createState() => _infoState();
}

class _infoState extends State<info> {
  bool _loading = false;
  Future gsheets1(String nam) async {
    await email1(nam).then((value) {
      setState(() {
        email = value;
      });
    });
  }

  // Future<DocumentSnapshot?> abc() async {
  //   email1(widget.nam).then((value3) async {
  //     // print(await FirebaseFirestore.instance
  //     // .collection('users')
  //     // .doc(value3)
  //     // .get());
  //     return await FirebaseFirestore.instance
  //         .collection('users')
  //         .doc(value3)
  //         .get();
  //     // return a;
  //   });
  //   // return null;
  // }

  String? email;

  @override
  void initState() {
    gsheets1(widget.nam);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // var email;
    // email1(widget.nam).then((value2) {
    //   print(value2);
    //   email = value2;
    // });
    // print(email);
    return Scaffold(
        appBar: AppBar(
          title: ListTile(
            title: Text(
              widget.nam,
              style: TextStyle(color: Colors.white),
            ),
            trailing: IconButton(
                onPressed: () => shownotice1(context, widget.nam, widget.taka),
                icon: Icon(
                  Icons.edit,
                  color: Colors.white,
                )),
            subtitle: Text(
              widget.taka.toString(),
              style: TextStyle(color: Colors.white),
            ),
            // subtitle: FutureBuilder(
            //     future: abc(),
            //     builder: (BuildContext context, AsyncSnapshot i) {
            //       print(i.toString());
            //       return Text("data");
            //     }),
            // subtitle: email != null
            //     ? StreamBuilder<DocumentSnapshot>(
            //         stream: FirebaseFirestore.instance
            //             .collection('users')
            //             .doc('imshaheer2004@gmail.com')
            //             .snapshots(),
            //         builder: (BuildContext context,
            //             AsyncSnapshot<DocumentSnapshot> snapshot) {
            //           if (snapshot.hasError) {
            //             print("object");
            //             return Text(
            //               "Error",
            //               style: TextStyle(color: Colors.white),
            //             );
            //           }

            //           if (snapshot.hasData) {
            //             dynamic a = snapshot.data!.data();
            //             return Text(
            //               a['Balance'].toString(),
            //               style: TextStyle(color: Colors.white),
            //             );
            //           }
            //           return Text("loading...");
            //         },
            //       )
            //     : Text(
            //         profile_taka.toString(),
            //         style: TextStyle(color: Colors.white),
            //       ),
          ),
        ),
        body: MediaQuery.of(context).size.width > 768
            ? Center(
                child: PhysicalModel(
                  color: Colors.white,
                  elevation: 8,
                  shadowColor: Colors.grey,
                  borderRadius: BorderRadius.circular(30),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.7,
                    width: MediaQuery.of(context).size.width > 1190
                        ? MediaQuery.of(context).size.width * 0.3
                        : MediaQuery.of(context).size.width * 0.5,
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
                    child: mainpart(),
                  ),
                ),
              )
            : mainpart());
  }

  Padding mainpart() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(email)
            .collection('balanceHIS')
            .orderBy('month', descending: true)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            // ignore: prefer_const_constructors
            return Center(child: Text("Something went Wrong!"));
          }
          if (snapshot.hasData) {
            return ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: snapshot.data.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  // DateTime dateTime = dateFormat.parse("2019-07-19 8:40:23");
                  DateTime date =
                      DateTime.parse(snapshot.data.docs[index]['month']);
                  // print(DateFormat.yMMMM('en_US')
                  //     .format(date));
                  var def = (DateTime.now().compareTo(date));
                  // /print(snapshot.data.docs[index].id);
                  return GestureDetector(
                    onLongPress: (() {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                                title: Text('এই লেন্দেনের সাথে কি করতে চান?'),
                                actions: [
                                  TextButton(
                                      onPressed: () async {
                                        // updateUser1(email!, Currentbalance, jorimana, fee, collection)
                                        await FirebaseFirestore.instance
                                            .collection('users')
                                            .doc(email)
                                            .collection('balanceHIS')
                                            .doc(snapshot.data.docs[index].id)
                                            .delete();
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('সম্পূর্ণ বাতিল?')),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    lendenedit(
                                                      fee: snapshot.data
                                                                  .docs[index]
                                                              ['fee'] +
                                                          0.0,
                                                      collection: snapshot.data
                                                                  .docs[index]
                                                              ['collection'] +
                                                          0.0,
                                                      id: snapshot
                                                          .data.docs[index].id,
                                                      nam: widget.nam,
                                                      email: email!,
                                                      month: date,
                                                    )));
                                      },
                                      child: Text('এডিট?'))
                                ],
                              ));
                    }),
                    child: Container(
                        padding:
                            const EdgeInsets.only(left: 6, top: 6, right: 6),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        margin: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.04,
                          top: 4,
                          bottom: 3,
                          right: MediaQuery.of(context).size.width * 0.04,
                        ),
                        height: MediaQuery.of(context).size.height * 0.13,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                                                    fontFamily: 'myfont',
                                                    color: Color(0xFF455A64),
                                                    // color: Color(
                                                    //     0xFF43aa8b),
                                                    fontSize: 100,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  children: [
                                                TextSpan(text: "মাস :- "),
                                                TextSpan(
                                                    text:
                                                        "${DateFormat.yMMMM('en_US').format(date)}",
                                                    style: TextStyle(
                                                        color: def > 0
                                                            ? Color(0xFF455A64)
                                                            : Color(
                                                                0xFF43aa8b))),
                                                def < 0
                                                    ? TextSpan(
                                                        text: " Advance*",
                                                        style: TextStyle(
                                                          fontSize: 60,
                                                          color:
                                                              Color(0xFF43aa8b),
                                                        ))
                                                    : TextSpan(),
                                              ])),
                                          Text(
                                            "মাধ্যম :- ${snapshot.data.docs[index]['maddom']}",
                                            style: TextStyle(
                                              fontFamily: 'myfont',
                                              color: Color(0xFF455A64),
                                              fontSize: snapshot.data
                                                                  .docs[index]
                                                              ['maddom'] ==
                                                          "মোবাইল ব্যাংকিং" ||
                                                      snapshot.data.docs[index]
                                                              ['maddom'] ==
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
                                    width: MediaQuery.of(context).size.width *
                                        0.01,
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: FittedBox(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            "+${snapshot.data.docs[index]['fee'].round().toString()} ৳",
                                            style: const TextStyle(
                                              fontFamily: "myfont",
                                              fontWeight: FontWeight.bold,
                                              fontSize: 100,
                                              color: Colors.green,
                                            ),
                                          ),
                                          snapshot.data.docs[index]
                                                      ['collection'] !=
                                                  0.0
                                              ? Text(
                                                  "+${snapshot.data.docs[index]['collection']}৳",
                                                  style: const TextStyle(
                                                    fontFamily: "myfont",
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 90,
                                                    color: Colors.amber,
                                                  ),
                                                )
                                              : FittedBox(),
                                          snapshot.data.docs[index]
                                                      ['jorimana'] ==
                                                  true
                                              ? Text(
                                                  "+20৳",
                                                  style: TextStyle(
                                                    fontFamily: "myfont",
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 80,
                                                    color: Colors.redAccent,
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
                        )),
                  );
                });
          }
          return Center(
            child: Column(
              children: [
                Expanded(
                    child: RiveAnimation.asset(
                        "assets/501-961-document-icon.riv")),
                Text(
                  "লোড হচ্ছে...",
                  style: TextStyle(
                      fontFamily: "myfont", fontSize: 20, color: Colors.white),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Future addbalance5(
    String nam,
    int row,
    BuildContext context,
  ) async {
    try {
      // init GSheets
      final gsheets = GSheets(_credentials);
      // // fetch spreadsheet by its id
      // final ss = await gsheets.spreadsheet(_spreadsheetId);
      final ss2 = await gsheets
          .spreadsheet("1b0qyJ6325WcDOB-v4jacprX7g1KZFRa-oRf4PY2eUDc");

      var sheet2 = ss2.worksheetByTitle(nam);
      // create worksheet if it does not exist yet
      sheet2 ??= await ss2.addWorksheet(nam);

      sheet2.deleteRow(row).then((value) {
        setState(() {
          _loading = false;
        });
      });
    } catch (e) {
      print(e);
      showErrDialog(context, "$e");
    }
  }

  void shownotice1(BuildContext context, String name, double Balance) {
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
            name,
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
                onPressed: () {
                  setState(() {
                    profile_taka = newbalance + 0.0;
                  });
                  Navigator.of(context).pop();
                  email1(name).then((value) async {
                    await FirebaseFirestore.instance
                        .collection('users')
                        .doc(value)
                        .update({
                      'Balance': newbalance,
                    });
                  });
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
