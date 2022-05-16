import 'package:byc_v2/Home_page/pages.dart';
import 'package:byc_v2/Home_page/variables.dart';
import 'package:byc_v2/pages/constitution.dart';
import 'package:byc_v2/pages/galaary.dart';
import 'package:byc_v2/pages/jogajog.dart';
import 'package:byc_v2/pages/kormoporishod.dart';
import 'package:byc_v2/pages/messanging.dart';
import 'package:byc_v2/pages/notice.dart';
import 'package:byc_v2/pages/sodossho.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/animation.dart';
import 'package:gsheets/gsheets.dart';
import 'package:rive/rive.dart' as rive;
import 'package:ink_page_indicator/ink_page_indicator.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

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

class home extends StatelessWidget {
  // const notice({Key? key}) : super(key: key);
  final String post;

  final String name;
  final List names;

  home({
    required this.post,
    required this.name,
    required this.names,
  });
  DateTime time = DateTime.now();

  @override
  Widget build(BuildContext context) {
    // print(namesgsheet.values.column(2, fromRow: 2));
    return WillPopScope(
      onWillPop: pop,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [
                    0.1,
                    0.9
                  ],
                  colors: <Color>[
                    Color(0xFFFF512F),
                    Color(0xFFDD2476),
                  ]),
            ),
          ),
          title: const Text("বনরুপা ইয়ুথ কমিউনিটি",
              style: TextStyle(fontFamily: "myfont")),
          centerTitle: true,
        ),
        body: Stack(
          children: [
            Column(
              children: [
                Spacer(
                  flex: 2,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    constitution_(context),
                    gallary_(context),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    sodossho_(context),
                    kormo_(context),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    notice_(context),
                    jogajog_(context),
                  ],
                ),
                Spacer(
                  flex: 2,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  GestureDetector jogajog_(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => jogajog()));
      },
      child: Container(
        height: 85,
        width: 125,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.redAccent,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.4), //color of shadow
              spreadRadius: 4, //spread radius
              blurRadius: 9, // blur radius
              offset: Offset(0, 2), // changes position of shadow
              //first paramerter of offset is left-right
              //second parameter is top to down
            ),
            //you can set more BoxShadow() here
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => jogajog()));
                // a(names);
              },
              icon: Icon(Icons.supervisor_account_outlined),
              iconSize: 35,
              color: Colors.white,
            ),
            const Text(
              "যোগাযোগ",
              style: TextStyle(
                  fontFamily: "myfont",
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  GestureDetector notice_(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => notice()));
      },
      child: Container(
        height: 85,
        width: 125,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.redAccent,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.4), //color of shadow
              spreadRadius: 4, //spread radius
              blurRadius: 9, // blur radius
              offset: Offset(0, 2), // changes position of shadow
              //first paramerter of offset is left-right
              //second parameter is top to down
            ),
            //you can set more BoxShadow() here
          ],
        ),
        child: Column(
          // mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => notice()));
              },
              icon: Icon(Icons.circle_notifications_outlined),
              iconSize: 35,
              color: Colors.white,
            ),
            // ignore: prefer_const_constructors
            const Text(
              "নোটিশ",
              style: TextStyle(
                  fontFamily: "myfont",
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  GestureDetector kormo_(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => kormo()));
      },
      child: Container(
        height: 85,
        width: 125,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.redAccent,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.4), //color of shadow
              spreadRadius: 4, //spread radius
              blurRadius: 9, // blur radius
              offset: Offset(0, 2), // changes position of shadow
              //first paramerter of offset is left-right
              //second parameter is top to down
            ),
            //you can set more BoxShadow() here
          ],
        ),
        child: Column(
          // mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => kormo()));
              },
              icon: Icon(Icons.shield_outlined),
              iconSize: 35,
              color: Colors.white,
            ),
            const Text(
              "কর্মপরিষদ",
              style: TextStyle(
                  fontFamily: "myfont",
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            // SizedBox(
            //   width: 3,
            // ),
          ],
        ),
      ),
    );
  }

  GestureDetector sodossho_(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => sodossho()));
      },
      child: Container(
        height: 85,
        width: 125,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.redAccent,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.4), //color of shadow
              spreadRadius: 4, //spread radius
              blurRadius: 9, // blur radius
              offset: Offset(0, 2), // changes position of shadow
              //first paramerter of offset is left-right
              //second parameter is top to down
            ),
            //you can set more BoxShadow() here
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => sodossho()));
              },
              icon: Icon(Icons.groups_outlined),
              iconSize: 35,
              color: Colors.white,
            ),
            Hero(
              tag: "sodosso",
              child: const Text(
                "সদস্য",
                style: TextStyle(
                    fontFamily: "myfont",
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  GestureDetector gallary_(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => gallary(),
        ));
      },
      child: Container(
        height: 85,
        width: 125,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.redAccent,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.4), //color of shadow
              spreadRadius: 4, //spread radius
              blurRadius: 9, // blur radius
              offset: Offset(0, 2), // changes position of shadow
              //first paramerter of offset is left-right
              //second parameter is top to down
            ),
            //you can set more BoxShadow() here
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => gallary(),
                ));
              },
              icon: Icon(Icons.photo_library_outlined),
              iconSize: 35,
              color: Colors.white,
            ),
            const Text(
              "গ্যালারি",
              style: TextStyle(
                  fontFamily: "myfont",
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  GestureDetector constitution_(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        if (post == "আইটি,প্রচার ও প্রকাশনা সম্পাদক") {
          a();
        }
      },
      onTap: () => Navigator.push(
          context, MaterialPageRoute(builder: (context) => constitution())),
      child: Container(
        height: 85,
        width: 125,

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.redAccent,
          // ignore: prefer_const_literals_to_create_immutables
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.4), //color of shadow
              spreadRadius: 4, //spread radius
              blurRadius: 9, // blur radius
              offset: Offset(0, 2), // changes position of shadow
              //first paramerter of offset is left-right
              //second parameter is top to down
            ),
            //you can set more BoxShadow() here
          ],
        ),
        // border: Border.all(color: Colors.transparent, width: 3)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => constitution())),
              icon: Icon(Icons.auto_stories_outlined),
              iconSize: 35,
              color: Colors.white,
            ),
            const Text(
              "সংবিধান",
              style: TextStyle(
                  fontFamily: "myfont",
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> pop() async {
    final difference = DateTime.now().difference(time);
    final isexit = difference >= Duration(seconds: 2);
    time = DateTime.now();
    if (isexit) {
      final message = "পুনরাই ব্যাক বাটন চাপুন";
      Fluttertoast.showToast(
          msg: message, fontSize: 18, backgroundColor: Colors.redAccent);
      return false;
    } else {
      return true;
    }
  }
}

Future<void> showreq(BuildContext context, String nam, List names) async {
  showDialog(
      context: context,
      builder: (_) {
        return abc(
          nam: nam,
          names: names,
        );
      });
}

Future accept(
    List values,
    String currentSelectedValue,
    String maddom,
    bool Y,
    String date,
    BuildContext context,
    double taka,
    String nam,
    String date1,
    String _token) async {
  await FirebaseFirestore.instance.collection("Approvals").doc(date1).delete();
  test(currentSelectedValue, maddom, Y, date, date1, "accept");
  // print(currentSelectedValue);
  // var email2 = await email1(currentSelectedValue);
  // updateUser(email2, taka);
  DateTime date2 = DateTime.parse(date);
  addlist(DateFormat.yMMMM('en_US').format(date2), maddom, Y,
      currentSelectedValue, "accept", taka);
  print(_token);

  final response = await Messaging.sendToTopic(
    title: "অ্যাকাউন্ট আপডেট হয়েছে!",
    body:
        "আপনার ${DateFormat.yMMMM('en_US').format(date2)} এর মাসিক সঞ্চয় যুক্ত করা হয়েছে।",
    topic: _token,
    route: "route",
    url: '',
  );
  // print("${await token(currentSelectedValue)}");
  if (response.statusCode != 200) {
    print("error");
  }
  addnotice(
          "অ্যাকাউন্ট আপডেট হয়েছে!",
          "আপনার ${DateFormat.yMMMM('en_US').format(date2)} এর মাসিক সঞ্চয় যুক্ত করা হয়েছে।",
          await token(currentSelectedValue),
          nam,
          currentSelectedValue)
      .then((value) {
    Fluttertoast.showToast(
        msg: "সফল হয়েছে!", backgroundColor: Colors.redAccent);
  });
}

class abc extends StatefulWidget {
  final String nam;
  final List names;
  abc({required this.nam, required this.names});

  @override
  State<abc> createState() => _abcState();
}

class _abcState extends State<abc> {
  PageIndicatorController controller = PageIndicatorController();

  final ValueNotifier<double> page = ValueNotifier(0.0);

  int _counter = 0;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 1,
      backgroundColor: Colors.amber,
      insetAnimationCurve: Curves.fastOutSlowIn,
      insetAnimationDuration: Duration(seconds: 1),
      child: Container(
        height: 330,
        width: 230,
        child: loading
            ? Center(child: CircularProgressIndicator())
            : StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('Approvals')
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text('Empty'));
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  print(snapshot.data!.docs.length);

                  if (snapshot.data!.docs.length == 0) {
                    return Column(
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        const Center(
                          child: SizedBox(
                            height: 300,
                            width: 300,
                            child: rive.RiveAnimation.asset(
                                "assets/501-961-document-icon.riv"),
                          ),
                        ),
                        Text("আর কোনো নিবেদন নেই")
                      ],
                    );
                  }

                  return Stack(
                    children: [
                      PageView(
                        physics: BouncingScrollPhysics(),
                        controller: controller,
                        children: snapshot.data!.docs
                            .map((DocumentSnapshot document) {
                          Map<String, dynamic> data =
                              document.data() as Map<String, dynamic>;
                          DateTime date_ = DateTime.parse(data['তারিখ']);
                          var def = (DateTime.now().compareTo(date_));
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            // mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.person_outline,
                                        size: 36,
                                      ),
                                      Text(
                                        data['Name'],
                                        style: TextStyle(
                                          fontFamily: "myfont",
                                          fontSize: 18,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 10, left: 20),
                                child: RichText(
                                    text: TextSpan(
                                        style: TextStyle(
                                          fontFamily: 'myfont',
                                          color: Colors.black,
                                          // color: Color(
                                          //     0xFF43aa8b),
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        children: [
                                      TextSpan(text: "মাস :- "),
                                      TextSpan(
                                          text:
                                              "${DateFormat.yMMMM('en_US').format(date_)}",
                                          style: TextStyle(
                                              color: def < 0
                                                  ? Colors.redAccent
                                                  : Colors.black)),
                                      def < 0
                                          ? TextSpan(
                                              text: " Advance*",
                                              style: TextStyle(
                                                fontSize: 10,
                                                color: Colors.black,
                                              ))
                                          : TextSpan(),
                                    ])),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 10, left: 20),
                                child: Text(
                                  "মাধ্যমঃ ${data['মাধ্যম']}",
                                  style: TextStyle(
                                    fontFamily: "myfont",
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 10, left: 20),
                                child: Text(
                                  "জরিমানাঃ ${data['জরিমানা'] ? "হ্যাঁ" : "না"}",
                                  style: TextStyle(
                                    fontFamily: "myfont",
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              Spacer(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        primary: Colors.redAccent),
                                    onPressed: () async {
                                      setState(() {
                                        loading = true;
                                      });
                                      test(
                                              data['Name'],
                                              data['মাধ্যম'],
                                              data['জরিমানা'],
                                              data['তারিখ'],
                                              data['date'],
                                              "Cancelled")
                                          .then((value) async {
                                        await FirebaseFirestore.instance
                                            .collection("Approvals")
                                            .doc(data['date'])
                                            .delete();
                                      }).then((value) {
                                        setState(() {
                                          loading = false;
                                        });
                                      });
                                    },
                                    child: Text("বাতিল"),
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        primary: Colors.green),
                                    onPressed: () async {
                                      setState(() {
                                        loading = true;
                                      });
                                      var email = await email1(data['Name']);
                                      DocumentSnapshot user =
                                          await FirebaseFirestore.instance
                                              .collection('users')
                                              .doc(email)
                                              .get();
                                      Map<String, dynamic> data1 =
                                          user.data() as Map<String, dynamic>;
                                      var taka = data1['Balance'];
                                      print(data['token']);
                                      accept(
                                              profile_names,
                                              data['Name'],
                                              data['মাধ্যম'],
                                              data['জরিমানা'],
                                              data['তারিখ'],
                                              context,
                                              taka + 0.0,
                                              widget.nam,
                                              data['date'],
                                              data["token"])
                                          .then((value) {
                                        setState(() {
                                          loading = false;
                                        });
                                      });
                                    },
                                    child: Text("মঞ্জুর"),
                                  ),
                                ],
                              ),
                              Spacer(
                                flex: 2,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: InkWell(
                                  onTap: () {
                                    _counter = _counter + 1;

                                    controller.animateToPage(
                                      controller.page !=
                                              snapshot.data!.docs.length - 1
                                          ? snapshot.data!.docs.length - 1
                                          : 0,
                                      duration:
                                          const Duration(milliseconds: 600),
                                      curve: Curves.easeInOut,
                                    );
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    // ignore: prefer_const_literals_to_create_immutables
                                    children: [
                                      const Text("পরবর্তি"),
                                      const Icon(Icons.arrow_forward)
                                    ],
                                  ),
                                ),
                              )
                            ],
                          );
                        }).toList(),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 250),
                        child: InkPageIndicator(
                          controller: controller,
                          gap: 7,
                          padding: 5,
                          shape: IndicatorShape.circle(5),
                          page: page,
                          pageCount: snapshot.data!.docs.length,
                          activeShape: IndicatorShape.circle(7),
                          inactiveColor: Colors.grey.shade500,
                          activeColor: Colors.black,
                          inkColor: Colors.black54,
                          style: InkStyle.simple,
                        ),
                      ),
                    ],
                  );
                }),
      ),
    );
  }
}

Future a() async {
  // print("object");
  final gsheets = GSheets(_credentials);
  // fetch spreadsheet by its id
  final ss = await gsheets.spreadsheet(_spreadsheetId);
  var sheet = ss.worksheetByTitle('users');

  List pics = await sheet!.values.column(
    6,
    fromRow: 2,
  );
  // await sheet.values.insertRowByKey('shaheer', ['adhak']);
  var phone = await sheet.values.column(
    3,
    fromRow: 2,
  );
  var names = await sheet.values.column(
    1,
    fromRow: 2,
  );
  List emails = await sheet.values.column(
    5,
    fromRow: 2,
  );
  List post = await sheet.values.column(
    2,
    fromRow: 2,
  );
  // for (var i = 0; i < pics.length; i++) {
  //   await FirebaseFirestore.instance.collection('users').doc(emails[i]).set({
  //     'Url': pics[i],
  //     'নাম': names[i],
  //     'Post': post[i],
  //     'Balance': 1200,
  //   });
  // }
  // emails.forEach((element) async {});

  await FirebaseFirestore.instance.collection('list').doc('pic').set({
    "pics": pics,
  });
  await FirebaseFirestore.instance
      .collection('list')
      .doc('K3xCz4IOTllRKWPTNYJg')
      .set({
    "names": names,
  });
  await FirebaseFirestore.instance.collection('list').doc('phone').set({
    "phone": phone,
  });
  Fluttertoast.showToast(msg: "সফল হয়েছে!", backgroundColor: Colors.redAccent);
}
