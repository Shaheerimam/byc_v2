import 'dart:ui';

import 'package:byc_v2/Home_page/pages.dart';
import 'package:byc_v2/Home_page/variables.dart';
import 'package:byc_v2/main.dart';
import 'package:byc_v2/pages/constitution.dart';
import 'package:byc_v2/pages/galaary.dart';
import 'package:byc_v2/pages/jogajog.dart';
import 'package:byc_v2/pages/kormoporishod.dart';
import 'package:byc_v2/pages/maintain.dart';
import 'package:byc_v2/pages/notice.dart';
import 'package:byc_v2/pages/pay.dart';
import 'package:byc_v2/pages/profile.dart';
import 'package:byc_v2/pages/sodossho.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// flutter run -d chrome --web-renderer html
class newhome extends StatefulWidget {
  final bool direct;
  String post;
  String nameban;
  double taka;
  newhome({
    required this.direct,
    required this.post,
    required this.nameban,
    required this.taka,
  });

  @override
  _newhomeState createState() => _newhomeState();
}

class _newhomeState extends State<newhome> with WidgetsBindingObserver {
  bool loading = true;
  // String _post = widget.direct?profile_Post:"সদস্য";
  // String _nameban = "সদস্য";
  List names = [];

  String text = '';

  late FirebaseMessaging messaging;
  // late List names;

  // List namesBan = [];
  // double taka = 0;
  Future getDatad() async {
    print(widget.direct);
    try {
      widget.direct
          ? null
          : await FirebaseFirestore.instance
              .collection('users')
              .doc(FirebaseAuth.instance.currentUser!.email)
              .get()
              .then((DocumentSnapshot snapshot) async {
              Map<String, dynamic> data =
                  snapshot.data() as Map<String, dynamic>;
              setState(() {
                profile_taka = data['Balance'] + 0.0;
                profile_Post = data['Post'];
                profile_name = data['নাম'];
                profile_url = data['Url'];
              });
              print(profile_url);
              if (kIsWeb != true) {
                print(profile_name);
                await FirebaseMessaging.instance
                    .subscribeToTopic(data['token']);
              }

              // gsheets(_nameban);
              if (kIsWeb != true) {
                if (profile_Post != "সদস্য") {
                  FirebaseMessaging.instance.subscribeToTopic("admin");
                } else {}
                if (profile_Post == "অর্থসম্পাদক") {
                  FirebaseMessaging.instance.subscribeToTopic("money_mana");
                } else {}
              }
            });
      await FirebaseFirestore.instance
          .collection('list')
          .doc("K3xCz4IOTllRKWPTNYJg")
          .get()
          .then((value3) {
        names = value3['names'];
        profile_names = value3['names'];
      });
    } catch (e) {
      showErrDialog(context, "Something went Wrong!___ please Retry");
      print(e);
      profile_taka = 0.0;
      return false;
    }
    setState(() {
      loading = false;
    });
  }

  int _page = 0;
  void initState() {
    super.initState();

    getDatad();
    if (kIsWeb != true) {
      FirebaseMessaging.instance.subscribeToTopic('memberas');
    }

    WidgetsBinding.instance!.addObserver(this);

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

  String title = 'অ্যাকাউন্ট';
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: size.width < 480 ? AppBar() : null,
        drawer: size.width < 480
            ? Drawer(
                child: drawer1(size),
              )
            : null,
        body: LayoutBuilder(builder: ((context, constraints) {
          print(constraints.maxWidth);
          if (constraints.maxWidth > 480) {
            return Row(
              children: [
                Expanded(flex: 2, child: drawer1(size)),
                Expanded(
                  flex: 8,
                  child: pages_new(
                      _page, profile_taka, profile_name, profile_Post, names),
                ),
              ],
            );
          } else
            return pages_new(
                _page, profile_taka, profile_name, profile_Post, names);
        })));
  }

  Container drawer1(Size size) {
    return Container(
      padding: EdgeInsets.all(0.5),
      decoration: size.width > 480
          ? BoxDecoration(
              // color: Colors.grey[200],
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              border: Border.all(
                width: 1,
                color: Colors.orange,
              ),
            )
          : null,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              otherAccountsPicturesSize: Size.square(0.0),
              decoration: const BoxDecoration(
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
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                ),
              ),
              currentAccountPicture: FittedBox(
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    border: Border.all(width: 2.0, color: Colors.white),
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
              accountName: Text(
                profile_name,
                // style: TextStyle(fontSize: 16),
              ),
              accountEmail: Text(
                profile_Post,
                // style: TextStyle(
                //     // fontSize: 16,
                //     // letterSpacing: profile_Post.length > 25 ? 1 : null,
                //     ),
              ),
            ),
            ListTile(
              shape: StadiumBorder(
                  side: BorderSide(
                width: 1,
                color: Colors.redAccent,
              )),
              tileColor: Colors.white70,
              // selectedColor: Colors.red,
              selectedTileColor: Colors.redAccent,
              dense: true,
              selected: _page == 0 ? true : false,
              hoverColor: Colors.red,
              onTap: () {
                SystemChrome.setApplicationSwitcherDescription(
                    ApplicationSwitcherDescription(
                        label: 'BYC-Account',
                        primaryColor: Theme.of(context).primaryColor.value));
                setState(() {
                  _page = 0;
                  size.width > 480 ? null : Navigator.of(context).pop();
                });
              },
              title: Text(
                'অ্যাকাউন্ট',
                style: TextStyle(
                  color: _page == 0 ? Colors.white : Colors.black87,
                  fontFamily: 'myfont',
                  fontSize: _page == 0 ? 25 : 20,
                ),
              ),
            ),
            Divider(),
            ListTile(
              shape: StadiumBorder(
                  side: BorderSide(
                width: 1,
                color: Colors.redAccent,
              )),
              tileColor: Colors.white70,
              // selectedColor: Colors.red,
              selectedTileColor: Colors.redAccent,
              dense: true,
              selected: _page == 1 ? true : false,
              hoverColor: _page == 1 ? null : Colors.red,
              onTap: () {
                SystemChrome.setApplicationSwitcherDescription(
                    ApplicationSwitcherDescription(
                        label: 'BYC-Notice',
                        primaryColor: Theme.of(context).primaryColor.value));
                setState(() {
                  _page = 1;
                  size.width > 480 ? null : Navigator.of(context).pop();
                });
              },

              title: Text(
                'নোটিশ',
                style: TextStyle(
                  color: _page == 1 ? Colors.white : Colors.black87,
                  fontFamily: 'myfont',
                  fontSize: _page == 1 ? 25 : 20,
                ),
              ),
            ),
            Divider(),
            ListTile(
              shape: StadiumBorder(
                  side: BorderSide(
                width: 1,
                color: Colors.redAccent,
              )),
              tileColor: Colors.white70,
              // selectedColor: Colors.red,
              selectedTileColor: Colors.redAccent,
              dense: true,
              selected: _page == 2 ? true : false,
              hoverColor: _page == 2 ? null : Colors.red,
              onTap: () {
                SystemChrome.setApplicationSwitcherDescription(
                    ApplicationSwitcherDescription(
                        label: 'BYC-pay/request',
                        primaryColor: Theme.of(context).primaryColor.value));
                setState(() {
                  _page = 2;
                  size.width > 480 ? null : Navigator.of(context).pop();
                });
              },
              title: Text(
                'Pay',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: _page == 2 ? Colors.white : Colors.black87,
                  // fontFamily: 'myfont',
                  fontSize: _page == 2 ? 25 : 20,
                ),
              ),
            ),
            Center(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("অন্যান্য"),
            )),
            ListTile(
              shape: StadiumBorder(
                  side: BorderSide(
                width: 1,
                color: Colors.redAccent,
              )),
              tileColor: Colors.white,
              // selectedColor: Colors.red,
              selectedTileColor: Colors.redAccent,
              dense: true,
              selected: _page == 3 ? true : false,
              hoverColor: _page == 3 ? null : Colors.red,
              onTap: () {
                SystemChrome.setApplicationSwitcherDescription(
                    ApplicationSwitcherDescription(
                        label: 'BYC-Member',
                        primaryColor: Theme.of(context).primaryColor.value));
                setState(() {
                  _page = 3;
                  size.width > 480 ? null : Navigator.of(context).pop();
                });
              },
              title: Text(
                'সদস্য',
                style: TextStyle(
                  color: _page == 3 ? Colors.white : Colors.black87,
                  fontFamily: 'myfont',
                  fontSize: _page == 3 ? 25 : 20,
                ),
              ),
            ),
            Divider(),
            ListTile(
              shape: StadiumBorder(
                  side: BorderSide(
                width: 1,
                color: Colors.redAccent,
              )),
              tileColor: Colors.white,
              // selectedColor: Colors.red,
              selectedTileColor: Colors.redAccent,
              dense: true,
              selected: _page == 4 ? true : false,
              hoverColor: _page == 4 ? null : Colors.red,
              onTap: () {
                SystemChrome.setApplicationSwitcherDescription(
                    ApplicationSwitcherDescription(
                        label: 'BYC-Constitution',
                        primaryColor: Theme.of(context).primaryColor.value));
                setState(() {
                  _page = 4;
                  size.width > 480 ? null : Navigator.of(context).pop();
                });
              },
              title: Text(
                'সংবিধান',
                style: TextStyle(
                  color: _page == 4 ? Colors.white : Colors.black87,
                  fontFamily: 'myfont',
                  fontSize: _page == 4 ? 25 : 20,
                ),
              ),
            ),
            Divider(),
            ListTile(
              shape: StadiumBorder(
                  side: BorderSide(
                width: 1,
                color: Colors.redAccent,
              )),
              tileColor: Colors.white,
              // selectedColor: Colors.red,
              selectedTileColor: Colors.redAccent,
              dense: true,
              selected: _page == 5 ? true : false,
              hoverColor: _page == 5 ? null : Colors.red,
              onTap: () {
                SystemChrome.setApplicationSwitcherDescription(
                    ApplicationSwitcherDescription(
                        label: 'BYC-Gallery',
                        primaryColor: Theme.of(context).primaryColor.value));
                setState(() {
                  _page = 5;
                  size.width > 480 ? null : Navigator.of(context).pop();
                });
              },
              title: Text(
                'গ্যালারি',
                style: TextStyle(
                  color: _page == 5 ? Colors.white : Colors.black87,
                  fontFamily: 'myfont',
                  fontSize: _page == 5 ? 25 : 20,
                ),
              ),
            ),
            Divider(),
            ListTile(
              shape: StadiumBorder(
                  side: BorderSide(
                width: 1,
                color: Colors.redAccent,
              )),
              tileColor: Colors.white,
              // selectedColor: Colors.red,
              selectedTileColor: Colors.redAccent,
              dense: true,
              selected: _page == 6 ? true : false,
              hoverColor: _page == 6 ? null : Colors.red,
              onTap: () {
                SystemChrome.setApplicationSwitcherDescription(
                    ApplicationSwitcherDescription(
                        label: 'BYC-Admins',
                        primaryColor: Theme.of(context).primaryColor.value));
                setState(() {
                  _page = 6;
                  size.width > 480 ? null : Navigator.of(context).pop();
                });
              },
              title: Text(
                'কর্মপরিষদ',
                style: TextStyle(
                  color: _page == 6 ? Colors.white : Colors.black87,
                  fontFamily: 'myfont',
                  fontSize: _page == 6 ? 25 : 20,
                ),
              ),
            ),
            Divider(),
            ListTile(
              shape: StadiumBorder(
                  side: BorderSide(
                width: 1,
                color: Colors.redAccent,
              )),
              tileColor: Colors.white,
              // selectedColor: Colors.red,
              selectedTileColor: Colors.redAccent,
              dense: true,
              selected: _page == 7 ? true : false,
              hoverColor: _page == 7 ? null : Colors.red,
              onTap: () {
                SystemChrome.setApplicationSwitcherDescription(
                    ApplicationSwitcherDescription(
                        label: 'BYC-Contact',
                        primaryColor: Theme.of(context).primaryColor.value));
                setState(() {
                  _page = 7;
                  size.width > 480 ? null : Navigator.of(context).pop();
                });
              },
              title: Text(
                'যোগাযোগ',
                style: TextStyle(
                  color: _page == 7 ? Colors.white : Colors.black87,
                  fontFamily: 'myfont',
                  fontSize: _page == 7 ? 25 : 20,
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .2,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: (MediaQuery.of(context).size.width > 768
                      ? MediaQuery.of(context).size.width * .04
                      : 0)),
              child: ListTile(
                shape: StadiumBorder(
                    side: BorderSide(
                  width: 1,
                  color: Colors.blueGrey,
                )),
                tileColor: Colors.white,
                // selectedColor: Colors.red,
                selectedTileColor: Colors.blueGrey,
                dense: true,
                selected: true,
                hoverColor: Colors.black,
                onTap: () async {
                  await FirebaseAuth.instance.signOut().then((value) =>
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => MyApp())));
                },
                title: Center(
                  child: FittedBox(
                    child: Text(
                      'লগ আউট',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'myfont',
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                trailing: Icon(
                  Icons.logout_outlined,
                  color: Colors.white70,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget pages_new(int index, double taka, String nam, String post, List names) {
  Widget questionWidget;
  switch (index) {
    case 0:
      questionWidget = userpage();
      break;
    case 1:
      questionWidget = notice();
      break;
    case 2:
      questionWidget = pay();
      break;
    case 3:
      questionWidget = sodossho();
      break;
    case 4:
      questionWidget = constitution();
      break;
    case 5:
      questionWidget = gallary();
      break;
    case 6:
      questionWidget = kormo();
      break;
    case 7:
      questionWidget = jogajog();
      break;

    default:
      questionWidget = userpage();
      break;
  }
  return questionWidget;
}
