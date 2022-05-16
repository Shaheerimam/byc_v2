import 'package:byc_v2/Home_page/home.dart';
import 'package:byc_v2/pages/maintain.dart';
import 'package:byc_v2/pages/notice.dart';
import 'package:byc_v2/pages/pay.dart';
import 'package:byc_v2/pages/profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gsheets/gsheets.dart';

const _credentials = r'''
{
  "type": "service_account",
  "project_id": "byc-2021",
  "private_key_id": "67aabacb2be8a8675902f4fa7946d96a55f0f380",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvwIBADANBgkqhkiG9w0BAQEFAASCBKkwggSlAgEAAoIBAQDlXbGoOwrTIfm9\nU0sFqJKEBAJ5rPBVeVEUC629vhbljyYlVF8SJoZEhiYTrlm5bC7jk47Wu9yvC4Lx\non5a4HKslBystWmIi9p6ugi4eEs7Ha53EVLIbBQ8vMDwAc2f9MWs+7vp6cIicQSp\nUkSxHslorRAuuFpP2s4X5IqdgvIChH6+TAf/U5f9Mfp8CwwlLYZzjt3lvu/RIffy\nA2mj5XrsVACiPs33896MQOk54urYqtw+ycj0kTp4cH71GTHdIzjM5CTiJl0bdfwX\nOwF28lsZmikbNl/CZqKIY+vcfbLMhJBa+iV8SitW1kBSNKLvuDA1rllSgJFQSGf/\nxItVxpcVAgMBAAECggEANQ/nbUV3fB/EkHWoCf+VIcBxuCd3lDaUOMB46cgDsQjc\naM9rjR3newvT3EK+FCUAdfqplWjxpXdSzEbs12ZMcTt0pMn1R7cfDLxkDxUZRmxX\n88jIr4A9cE20jvHD2cj9QEcekn9XP7OIwgk7xgQa0UIUV9KjZgz3F9Tx8n2cMlN3\nZ5aZCig10FYrSkyyZO3SXjF/YqxhAhGxdUvsSBrV7pb+GJZbRlEd2e08wVyc7kHH\nUPurSiX8iJLDhu/fAvDPqGpQxdedu2zuf2BdsDJE3ZyUsQgIm/Gfs6oZe56yeEmq\nPx5cPWuk3I3SrH4f9CaRqgkjRZnmYB0l2MCgGO2oswKBgQD91rVLJpeDXiTxbrUB\nVl1poAuZnuk0nIJduL6N4YSDubDrRCQUVEUg/2likSpZhGTgbNw0R6KuV6SEX6sO\nWMm3qqgypyhHyvXkgGYmuqywIYAZSBC9JyDpF8BHgdWToWJtnIKqZs8R0BPM+llO\nNwomz04IIVJYolvPJGvjI50lhwKBgQDnUaSFoyEjEu6deHzbdebpHbUIlfYdB2kq\nRvTH1a0beejMR7LvqNwQpfk5oxVppLwVa+juzTYGww4ux6fvwEs+VVYwyUZXP8o+\nTQ4pHSzWbKRgqMMeNm6VU6sLJUFZt5ADcW+mCvAu371fcGTVdJmCAby/igaeStW+\nfIef9IlFgwKBgQDh/4CH+UMaff5sSkGzgB5JBWpuirJc2h+jq/FURv4BfZlLze5F\nf0XQ/DXqwQ4whxR9T866aTEpAfUCul6Etn5aHQIFnxfY25YTrFHGl5tacWkomSX2\nEtlVToUt5SWvfBczOg6IAmLIHDcU36wVXCGYriduS6SSL3OIOIgpwbKPDwKBgQCF\ntFotaHpJ5LKJ0NASphafXi161ftZEiSGbFcmfuq9O/0Evti90FPLR7RDzXEeDDsv\nAp20EmeNBwfWoE8AtJyJXhggwOZonhWPZ0itGREGq+tjd4i4mOvYYnE2UwVwDzst\n0k6foijsXyT92mBeRTRJwilQaT6kFktv/FkEavtBcwKBgQDLJa479GcOov23pmwt\nsP7TJBmBbK1vCaz2Qumg7db/8KyEbyEz2P1QJMj2+5h4HQhCkeaL1iFzeJGCLlqR\n8wR7kK742QhpgCaqymdC/WzN/3CRUwEkSQnqwI9SJv2tl300Mkin3GeStXwPaatG\nCaFt1U395y71VjUksK+U37uQrw==\n-----END PRIVATE KEY-----\n",
  "client_email": "byc-v2@byc-2021.iam.gserviceaccount.com",
  "client_id": "100990858525852203699",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/byc-v2%40byc-2021.iam.gserviceaccount.com"
}
''';
const _spreadsheetId = '1BYV-ZoFD9IkaIjuLTzCcPIJxjVn33d5PdCo12vCdhos';

class controller extends StatefulWidget {
  final bool direct;
  final String post;
  final String nameban;
  final double taka;
  controller({
    required this.direct,
    required this.post,
    required this.nameban,
    required this.taka,
  });
  @override
  _controllerState createState() => _controllerState();
}

class _controllerState extends State<controller> with WidgetsBindingObserver {
  bool loading = true;
  String _post = "সদস্য";
  String _nameban = "সদস্য";
  List names = [];

  String text = '';

  late FirebaseMessaging messaging;
  // late List names;

  // List namesBan = [];
  double taka = 0;
  Future getDatad() async {
    try {
      widget.direct
          ? await FirebaseFirestore.instance
              .collection('users')
              .doc(FirebaseAuth.instance.currentUser!.email)
              .get()
              .then((DocumentSnapshot snapshot) async {
              Map<String, dynamic> data =
                  snapshot.data() as Map<String, dynamic>;
              setState(() {
                taka = data['Balance'] + 0.0;
                _post = data['Post'];
                _nameban = data['নাম'];
              });

              // gsheets(_nameban);
              if (kIsWeb != true) {
                if (_post != "সদস্য") {
                  FirebaseMessaging.instance.subscribeToTopic("admin");
                } else {}
                if (_post == "অর্থসম্পাদক") {
                  FirebaseMessaging.instance.subscribeToTopic("money_mana");
                } else {}
              }
            })
          : null;
      await FirebaseFirestore.instance
          .collection('list')
          .doc("K3xCz4IOTllRKWPTNYJg")
          .get()
          .then((value3) {
        names = value3['names'];
      });
    } catch (e) {
      showErrDialog(context, "Something went Wrong!___ please Retry");
      print(e);
      taka = 0.0;
      return false;
    }
    setState(() {
      loading = false;
    });
    if (kIsWeb != true) {
      await token(_nameban).then((value2) {
        FirebaseMessaging.instance.subscribeToTopic(value2);
      });
    }
  }

  final _controller = PageController(initialPage: 0);
  @override
  void initState() {
    super.initState();
    if (kIsWeb != true) {
      FirebaseMessaging.instance.subscribeToTopic('memberas');
    }

    WidgetsBinding.instance!.addObserver(this);
    getDatad();
    if (kIsWeb != true) {
      messaging = FirebaseMessaging.instance;
      FirebaseMessaging.onMessageOpenedApp.listen((message1) {
        if (message1.data['route'] == 'notice') {
          print(message1.data['route']);
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => notice()));
        } else if (message1.data['route'] == 'route') {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => userpage()));
        } else {}
      });
      FirebaseMessaging.onMessage.listen((RemoteMessage event) {
        print(event.data);
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                backgroundColor: Colors.redAccent,
                title: Text(
                  event.notification!.title.toString(),
                  style: TextStyle(fontFamily: "myfont", color: Colors.white),
                ),
                content: Text(
                  event.notification!.body!,
                  style: TextStyle(fontFamily: "myfont", color: Colors.white),
                ),
              );
            });
      });
    }

    // messaging.subscribeToTopic("shaheer");
  }

  int _counter = 0;
  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    names;
    _nameban;
    getDatad();
    taka;
    _controller;
    _post;
    _counter;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Container(
            color: Colors.white,
            child: Column(
              children: [
                Spacer(),
                Expanded(
                  child: AnimatedContainer(
                    height: 200,

                    // ignore: prefer_const_constructors
                    decoration: BoxDecoration(
                      // ignore: prefer_const_constructors
                      image: DecorationImage(
                        // ignore: prefer_const_constructors
                        image: AssetImage(
                          'assets/byc_logo.png',
                        ),
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                    duration: Duration(milliseconds: 200),
                  ),
                ),
                Spacer(),
                const CircularProgressIndicator(),
                Spacer(),
              ],
            ),
          )
        : Scaffold(
            body: PageView(
              physics: BouncingScrollPhysics(),
              children: [
                home(
                  post: _post,
                  name: _nameban,
                  names: names,
                ),
                notice(),
                pay(),
                userpage(),
              ],
              controller: _controller,
              onPageChanged: (index) {
                setState(() {
                  _counter = index;
                });
              },
            ),
            // ignore: prefer_const_literals_to_create_immutables
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              fixedColor: Colors.redAccent,
              elevation: 0,
              // ignore: prefer_const_constructors
              selectedIconTheme: IconThemeData(size: 30),
              // ignore: prefer_const_constructors
              unselectedIconTheme: IconThemeData(size: 22),
              selectedFontSize: 10,
              // unselectedItemColor: Colors.grey,
              backgroundColor: Colors.transparent,
              currentIndex: _counter,
              // ignore: prefer_const_constructors
              // unselectedLabelStyle: TextStyle(color: Colors.black),
              // ignore: prefer_const_literals_to_create_immutables
              items: [
                const BottomNavigationBarItem(
                    icon: Icon(Icons.home_outlined),
                    label: "Home",
                    activeIcon: Icon(Icons.home_filled),
                    backgroundColor: Colors.white),
                // const BottomNavigationBarItem(
                //     icon: FaIcon(FontAwesomeIcons.rocket),
                //     label: "Skill",
                //     backgroundColor: Colors.white),
                const BottomNavigationBarItem(
                    icon: Icon(Icons.notifications_none_outlined),
                    activeIcon: Icon(Icons.notifications),
                    label: "Notice",
                    backgroundColor: Colors.white),
                const BottomNavigationBarItem(
                    icon: Icon(Icons.paid_outlined),
                    activeIcon: Icon(Icons.paid_rounded),
                    label: "Pay",
                    backgroundColor: Colors.white),
                const BottomNavigationBarItem(
                    icon: Icon(Icons.person_outline),
                    activeIcon: Icon(Icons.person_rounded),
                    label: "Account",
                    backgroundColor: Colors.white),
              ],
              onTap: (index) {
                setState(() {
                  _counter = index;
                  // ignore: prefer_const_constructors
                  _controller.animateToPage(_counter,
                      // ignore: prefer_const_constructors
                      duration: Duration(milliseconds: 200),
                      curve: Curves.easeInOut);
                });
              },
            ),
          );
  }
}

Future addlist(String date, String maddom, bool Y, String nam, String status,
    double taka) async {
  // init GSheets
  final gsheets = GSheets(_credentials);
  // fetch spreadsheet by its id
  final ss = await gsheets.spreadsheet(_spreadsheetId);
  var sheet1 = ss.worksheetByTitle('users');
  var sheet = ss.worksheetByTitle(date);
  var values = await sheet1!.values.column(
    1,
    fromRow: 2,
  );
  var a = await sheet1.values.rowByKey(nam);
  print(a![3]);

  // create worksheet if it does not exist yet
  sheet ??= await ss.addWorksheet(date);
  await sheet.values
      .insertRow(1, ["নাম", "তারিখ", "মাধ্যম", "জরিমানা", "Status"]);
  await sheet.values.insertColumn(1, values, fromRow: 2);
  // await sheet.values.insertRow(1, values, fromRow: 2);
  sheet.values
      .insertRowByKey(nam, ["${DateTime.now().toString()}", maddom, Y, status]);
}

Future addbalance1(String nam, String maddom, bool Y, String date,
    BuildContext context, String status, String date_time) async {
  try {
    // init GSheets
    // final gsheets = GSheets(_credentials);
    // // // fetch spreadsheet by its id
    // // final ss = await gsheets.spreadsheet(_spreadsheetId);
    // final ss2 = await gsheets
    //     .spreadsheet("1b0qyJ6325WcDOB-v4jacprX7g1KZFRa-oRf4PY2eUDc");

    // var sheet2 = ss2.worksheetByTitle(nam);
    // // create worksheet if it does not exist yet
    // sheet2 ??= await ss2.addWorksheet(nam);

    // await sheet2.values
    //     .insertRow(1, ["মাস-বছর", "মাধ্যম", "জরিমানা", "তারিখ", "Status"]);
    // sheet2.values.insertRowByKey(date, [maddom, Y, date_time, status]);

  } catch (e) {
    print(e);
    showErrDialog(context, "$e");
  }
}

Future<String> token(String nam) async {
  // init GSheets
  try {
    // final gsheets = GSheets(_credentials);
    // // fetch spreadsheet by its id
    // final ss = await gsheets.spreadsheet(_spreadsheetId);
    // // get worksheet by its title
    // var sheet = ss.worksheetByTitle('users');
    // var a = await sheet!.values.rowByKey(nam);
    // if (a?[2] == null) {
    //   return 'nam';
    // } else {
    //   print(a![2]);
    //   return a[2];
    // }
    var a = '';
    await FirebaseFirestore.instance
        .collection('users')
        .where('নাম', isEqualTo: nam)
        .get()
        .then(
      (value) {
        print(value.docs[0]['token']);
        a = value.docs[0]['token'].toString();
      },
    );
    return a;
  } on Exception catch (e) {
    print('$e ohho!');
    return '';
  }
}

Future<String> email1(String nam) async {
  // init GSheets
  try {
    // final gsheets = GSheets(_credentials);
    // // fetch spreadsheet by its id
    // final ss = await gsheets.spreadsheet(_spreadsheetId);
    // // get worksheet by its title
    // var sheet = ss.worksheetByTitle('users');
    // var a = await sheet!.values.rowByKey(nam);
    // if (a?[3] == null) {
    //   return nam;
    // } else {
    //   return await a![3];
    // }
    var a = '';
    await FirebaseFirestore.instance
        .collection('users')
        .where('নাম', isEqualTo: nam)
        .get()
        .then(
      (value) {
        print(value.docs[0].id);
        a = value.docs[0].id;
      },
    );
    return a;
  } on Exception catch (e) {
    print(e);
    return '';
  }
}

CollectionReference users = FirebaseFirestore.instance.collection('notice');

Future<void> addnotice(
    String title, String body, String topic, String name, String tonam) async {
  print('$tonam to');
  CollectionReference user = FirebaseFirestore.instance
      .collection('users')
      .doc(await email1(tonam))
      .collection('notice');
  return user.doc(DateTime.now().toString()).set({
    'title': title,
    'body': body,
    "date": DateTime.now().toString(),
    "from": name,
    'to': topic,
  });
}

Future<void> addnotice1(String title, String body, String topic, String name,
    String tonam, String url) async {
  CollectionReference user = FirebaseFirestore.instance.collection('notice');
  return user.doc(DateTime.now().toString()).set({
    'title': title,
    'body': body,
    "date": DateTime.now().toString(),
    "from": name,
    'to': topic,
    'img': url,
  });
}

Future approval(String nam, String maddom, bool Y, String date, String date1,
    double taka, String token) async {
  CollectionReference approve =
      FirebaseFirestore.instance.collection('Approvals');
  return approve.doc(date1).set({
    "Balance": taka,
    "Name": nam,
    "মাধ্যম": maddom,
    "তারিখ": date,
    "date": date1,
    "জরিমানা": Y,
    "token": token
  });
}

Future test(String nam, String maddom, bool Y, String date, String date_time,
    String status) async {
  try {
    // init GSheets
    final gsheets = GSheets(_credentials);
    // fetch spreadsheet by its id
    final ss2 = await gsheets
        .spreadsheet("1b0qyJ6325WcDOB-v4jacprX7g1KZFRa-oRf4PY2eUDc");
    // get worksheet by its title

    // get worksheet by its title
    var sheet2 = ss2.worksheetByTitle(nam);
    // var c = (await sheet2!.values.allRows()).length;
    // final cell = (await sheet2.cells.cell(column: 5, row: c)).post("accept");
    await sheet2!.values.insertRowByKey(date, [maddom, Y, date_time, status]);

    // create worksheet if it does not exist yet
  } catch (e) {}
}
