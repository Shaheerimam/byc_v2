import 'package:byc_v2/Home_page/pages.dart';
import 'package:byc_v2/Home_page/variables.dart';
import 'package:byc_v2/pages/maintain.dart';
import 'package:byc_v2/pages/newhome.dart';
import 'package:byc_v2/pages/notice.dart';
import 'package:byc_v2/pages/profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class signin extends StatefulWidget {
  @override
  State<signin> createState() => _signinState();
}

class _signinState extends State<signin> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // late FirebaseMessaging messaging;
  // String _img =
  //     "https://scontent.fcgp7-1.fna.fbcdn.net/v/t1.6435-9/195748858_127561236137939_769515048424798575_n.jpg?_nc_cat=103&ccb=1-5&_nc_sid=09cbfe&_nc_eui2=AeGj5a_xnK5Q9rmDE73t6UBS2OMhAxv8XI3Y4yEDG_xcjapFlR-MMql8U4y8bRQo4_llB8HTT6Htmq6hUvt20I_r&_nc_ohc=2AJyQOyaevsAX8kogFZ&_nc_ht=scontent.fcgp7-1.fna&oh=4464d3f9cd3427845014bc3b2454fe69&oe=6144C529";

  String text = '';
  // var email2 = '';
  // late List names;

  // List namesBan = [];

  late String email;
  Future getData() async {
    try {
      // print(FirebaseAuth.instance.currentUser!.email);
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.email)
          .get()
          .then((DocumentSnapshot snapshot) async {
        Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
        profile_taka = data['Balance'] + 0.0;
        profile_Post = data['Post'];
        // _nameban = data['নাম'];
        profile_name = data['নাম'];
        profile_url = data['Url'];
        // _img = data['url'];
        // gsheets(_nameban);
        // await token(_nameban).then((value2) {
        //   FirebaseMessaging.instance
        //       .subscribeToTopic(value2)
        //       .then((value) => print(value2.toString()));
        // });
        // email2 = await email1(_nameban);
        if (kIsWeb == false) {
          if (profile_Post != "সদস্য") {
            FirebaseMessaging.instance.subscribeToTopic("admin");
          } else {}
          if (profile_Post == "অর্থসম্পাদক") {
            FirebaseMessaging.instance.subscribeToTopic("money_mana");
          } else {}
        }
      });
    } catch (e) {
      showErrDialog(context, "Something went Wrong! please Retry");
      print(e);
      profile_taka = 0.0;
      return false;
    }
    return true;
  }

  late String password;
  bool loading = false;
  void handleSignup(BuildContext context) {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      setState(() {
        loading = true;
      });
      signin1(email.replaceAll(' ', ''), password, context).then((value) async {
        if (value != null) {
          getData().then((e) {
            if (e != false) {
              try {
                kIsWeb
                    ? null
                    : FirebaseMessaging.instance.subscribeToTopic("member");

                kIsWeb
                    ? null
                    : FirebaseMessaging.onMessageOpenedApp.listen((message1) {
                        if (message1.data['route'] == 'notice') {
                          print(message1.data['route']);
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => notice()));
                        } else if (message1.data['route'] == 'route') {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => userpage()));
                        } else {}
                      });

                // messaging.subscribeToTopic("shaheer");
                kIsWeb
                    ? null
                    : FirebaseMessaging.onMessage.listen((RemoteMessage event) {
                        print(event.data);
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                backgroundColor: Colors.redAccent,
                                title: Text(
                                  event.notification!.title.toString(),
                                  style: TextStyle(
                                      fontFamily: "myfont",
                                      color: Colors.white),
                                ),
                                content: Text(
                                  event.notification!.body!,
                                  style: TextStyle(
                                      fontFamily: "myfont",
                                      color: Colors.white),
                                ),
                              );
                            });
                      });
              } catch (e) {
                showErrDialog(context, "Something went wrong! please retry 1");
              }
            } else {
              showErrDialog(context, "Something Went wrong! 2");
            }
            setState(() {
              loading = false;
            });
          }).then((value) => {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => newhome(
                              direct: true,
                              nameban: profile_name,
                              post: profile_Post,
                              taka: profile_taka,
                            )
                        // controller(
                        //   direct: false,
                        //   nameban: _nameban,
                        //   post: _post,
                        //   taka: taka,
                        // ),
                        ))
              });
        } else {
          setState(() {
            loading = false;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            // shrinkWrap: true,
            children: [
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
              const Text(
                "স্বাগতম!",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                    fontSize: 50),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width < 480
                    ? 400
                    : MediaQuery.of(context).size.width > 480 &&
                            MediaQuery.of(context).size.width < 768
                        ? 400
                        : 500,
                child: Form(
                  key: formKey,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 40),
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.only(
                              bottom: 5, left: 15, right: 15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.0),
                            color: Colors.grey[300],
                          ),
                          child: TextFormField(
                            enableSuggestions: true,
                            autofocus: true,
                            keyboardType: TextInputType.emailAddress,
                            style: const TextStyle(color: Colors.black),
                            // ignore: unnecessary_new
                            decoration: const InputDecoration(
                              errorText: null,
                              errorStyle: TextStyle(fontSize: 0),
                              labelText: 'Email',
                              labelStyle: TextStyle(color: Colors.black87),
                              // border: new OutlineInputBorder(
                              //     borderRadius: const BorderRadius.all(
                              //         const Radius.circular(30.0))),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent)),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                color: Color.fromRGBO(1, 22, 39, 1),
                              )),
                              contentPadding:
                                  EdgeInsets.only(top: 7, bottom: 5),
                              prefixIcon: Icon(
                                Icons.email_outlined,
                                color: Color.fromRGBO(1, 22, 39, 1),
                              ),
                              hintStyle: TextStyle(
                                color: Color.fromRGBO(1, 22, 39, 1),
                              ),
                            ),
                            validator: (_val) {
                              if (_val!.isEmpty) {
                                return "";
                              } else if (_val.contains('@') == false) {
                                return "";
                              } else {
                                return null;
                              }
                            },
                            onChanged: (_val) {
                              email = _val;
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                              bottom: 5, left: 15, right: 15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.0),
                            color: Colors.grey[300],
                          ),
                          child: TextFormField(
                            keyboardType: TextInputType.phone,
                            enableSuggestions: true,
                            style: const TextStyle(color: Colors.black),
                            decoration: const InputDecoration(
                              labelText: 'Phone-Number',
                              errorText: null,
                              errorStyle: TextStyle(fontSize: 0),
                              labelStyle: TextStyle(color: Colors.black87),
                              // border: new OutlineInputBorder(
                              //     borderRadius: const BorderRadius.all(
                              //         const Radius.circular(30.0))),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent)),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                color: Color.fromRGBO(1, 22, 39, 1),
                              )),
                              contentPadding:
                                  EdgeInsets.only(top: 7, bottom: 5),
                              prefixIcon: Icon(
                                Icons.phone_android_outlined,
                                color: Color.fromRGBO(1, 22, 39, 1),
                              ),
                              hintStyle: TextStyle(
                                color: Color.fromRGBO(1, 22, 39, 1),
                              ),
                            ),
                            validator: (_val) {
                              if (_val!.isEmpty) {
                                return '';
                              } else {
                                return null;
                              }
                            },
                            // validator: (_val){}
                            onChanged: (_val) {
                              password = _val;
                            },
                            obscureText: false,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: 200,
                          height: 55,
                          child: ElevatedButton(
                            onPressed: () => handleSignup(context),
                            child: const Text(
                              "Sign In",
                              style: TextStyle(fontSize: 35),
                            ),
                            style: ElevatedButton.styleFrom(
                              //onSurface: Colors.amber,
                              primary:
                                  Colors.black87, //background color of button
                              //border width and color
                              elevation: 0, //elevation of button
                              shape: RoundedRectangleBorder(
                                  //to set border radius to button
                                  borderRadius: BorderRadius.circular(40)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              )
            ],
          ),
          Center(
            child: loading ? const CircularProgressIndicator() : null,
          ),
        ],
      ),
    );
  }
}
