import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gsheets/gsheets.dart';
import 'package:rive/rive.dart' as rive;
import 'package:url_launcher/url_launcher.dart';

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

class sodossho extends StatelessWidget {
  Future<List> loaddata() async {
    // init GSheets
    // final gsheets = GSheets(_credentials);
    // // fetch spreadsheet by its id
    // final ss = await gsheets.spreadsheet(_spreadsheetId);
    // var sheet = ss.worksheetByTitle('users');
    List<User> lis = [];

    // var sodossophone1 = await sheet!.values.column(
    //   3,
    //   fromRow: 9,
    // );

    // var names = await sheet.values.column(
    //   1,
    //   fromRow: 9,
    // );
    // var pics = await sheet.values.column(
    //   6,
    //   fromRow: 9,
    // );

    var a = await FirebaseFirestore.instance
        .collection('list')
        .doc('K3xCz4IOTllRKWPTNYJg')
        .get();
    var names = a['names'];
    var b =
        await FirebaseFirestore.instance.collection('list').doc('pic').get();
    var pics = b['pics'];
    var c =
        await FirebaseFirestore.instance.collection('list').doc('phone').get();
    var phone = c['phone'];
    for (var i = 0; i < names.length; i++) {
      User user = User(name: names[i], phone: phone[i], pic: pics[i]);
      lis.add(user);
    }
    return lis;
  }

  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        // ignore: prefer_const_constructors
        title: Hero(
          tag: "sod",
          child: const Text(
            "সদস্য",
            style: TextStyle(
              fontFamily: "myfont",
              fontSize: 18,
              color: Colors.black,
            ),
          ),
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
                  child: asjkdfhasjkfh(),
                ),
              ),
            )
          : asjkdfhasjkfh(),
    );
  }

  FutureBuilder<List<dynamic>> asjkdfhasjkfh() {
    return FutureBuilder(
        future: loaddata(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Text("Something went wrong");
          }

          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.length - 7,
                itemBuilder: (context, i) {
                  try {
                    return ExpansionTile(
                      // backgroundColor: Colors.amber,
                      textColor: Colors.black,
                      // iconColor: Colors.green,
                      maintainState: true,
                      expandedCrossAxisAlignment: CrossAxisAlignment.center,
                      expandedAlignment: Alignment.topLeft,

                      leading: Container(
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                          border: Border.all(width: 2.0, color: Colors.teal),
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(snapshot.data[i + 7].pic),
                          ),
                        ),
                      ),
                      title: Text(
                        "${snapshot.data[i + 7].name}",
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontFamily: "myfont",
                        ),
                      ),
                      subtitle: Text('সদস্য'),
                      // ignore: prefer_const_literals_
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "    যোগাযোগঃ ${snapshot.data[i + 7].phone}",
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                  color: Colors.teal, fontSize: 16),
                            ),
                            IconButton(
                                onPressed: () => _makePhoneCall(
                                    'tel:${snapshot.data[i + 7].phone}'),
                                icon: const Icon(
                                  Icons.phone,
                                  color: Colors.teal,
                                )),
                          ],
                        ),
                      ],
                    );
                  } catch (e) {
                    return Container();
                  }
                });
          }
          return Center(
            child: Column(
              children: [
                SizedBox(
                    height: 400,
                    width: 400,
                    child: rive.RiveAnimation.asset(
                        "assets/501-961-document-icon.riv")),
                Text(
                  "লোড হচ্ছে...",
                  style: TextStyle(
                      fontFamily: "myfont",
                      fontSize: 20,
                      color: Colors.redAccent),
                )
              ],
            ),
          );
        });
  }
}

class User {
  final String name;
  final String phone;
  final String pic;
  User({required this.name, required this.phone, required this.pic});
}
