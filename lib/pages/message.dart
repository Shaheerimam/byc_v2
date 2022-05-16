import 'dart:io';

import 'package:byc_v2/Home_page/pages.dart';
import 'package:byc_v2/Home_page/variables.dart';
import 'package:byc_v2/pages/maintain.dart';
import 'package:byc_v2/pages/messanging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gsheets/gsheets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;
import 'package:mime_type/mime_type.dart';

class createmsg extends StatefulWidget {
  @override
  _createmsgState createState() => _createmsgState();
}

class _createmsgState extends State<createmsg> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String topic = 'member';

  // final String userfire = FirebaseAuth.instance.currentUser!.email.toString();

  Future sendNotification(
      String title, String body, String topic, String route, String url) async {
    final response = await Messaging.sendToTopic(
      title: title,
      body: body,
      topic: topic,
      route: route,
      url: url,
    );
    if (response.statusCode != 200) {
      print("error");
    }
  }

  bool _loading = false;

  final body = TextEditingController();
  final title = TextEditingController();
  var currentSelectedValue;

  Future<void> handlesendmsg(BuildContext context, String post) async {
    // print(currentSelectedValue);
    // print(title.text);

    // setState(() {});
    // print(title!.text);
    try {
      if (formKey.currentState!.validate()) {
        formKey.currentState!.save();
        String topic1 =
            topic != "member" && topic != "admin" ? await token(topic) : topic;
        print(title.text);
        print(body.text);
        print(currentSelectedValue);
        print(topic1);

        if (currentSelectedValue == null && pickedfile != null) {
          if (mime(pickedfile!.name) == 'image/jpeg') {
            if (kIsWeb) {
              Reference _reference = FirebaseStorage.instance
                  .ref()
                  .child('notice/${Path.basename(pickedfile!.path)}');
              await _reference
                  .putData(
                await pickedfile!.readAsBytes(),
                SettableMetadata(contentType: 'image/jpeg'),
              )
                  .whenComplete(() async {
                await _reference.getDownloadURL().then((value1) {
                  addnotice1(title.text, body.text, topic1, profile_Post,
                      "currentSelectedValue", value1.toString());
                  setState(() {
                    url = value1;
                  });
                });
              }).then((value) {
                setState(
                  () {
                    _loading = false;
                    currentSelectedValue = null;
                  },
                );
              }).then((value) {
                sendNotification(title.text, body.text, topic1, "notice", url);
                Fluttertoast.showToast(
                    msg: "সফল হয়েছে!", backgroundColor: Colors.redAccent);
                title.clear();
                body.clear();
              });
            } else {
              Reference _reference = FirebaseStorage.instance
                  .ref()
                  .child('notice/${Path.basename(pickedfile!.path)}');
              await _reference
                  .putData(
                await pickedfile!.readAsBytes(),
                SettableMetadata(contentType: 'image/jpeg'),
              )
                  .whenComplete(() async {
                await _reference.getDownloadURL().then((value) {
                  print(value);
                  addnotice1(title.text, body.text, topic1.toString(),
                      profile_Post, "currentSelectedValue", value.toString());
                  setState(() {
                    url = value;
                  });
                });
              }).then((value) {
                setState(
                  () {
                    _loading = false;
                    currentSelectedValue = null;
                  },
                );
              }).then((value) {
                sendNotification(title.text, body.text, topic1, "notice", url);
                Fluttertoast.showToast(
                    msg: "সফল হয়েছে!", backgroundColor: Colors.redAccent);
                title.clear();
                body.clear();
              });
            }
          } else {
            showErrDialog(context, 'Image must be in a jpeg format');
            setState(() {
              _loading = false;
            });
          }
        } else {
          addnotice(title.text, body.text, topic1, profile_name,
                  currentSelectedValue)
              .then((value) {
            setState(
              () {
                _loading = false;
                currentSelectedValue = null;
              },
            );
          }).then((value) {
            sendNotification(title.text, body.text, topic1, "notice", url);
            Fluttertoast.showToast(
                msg: "সফল হয়েছে!", backgroundColor: Colors.redAccent);
            title.clear();
            body.clear();
          });
        }
      } else {
        setState(() {
          _loading = false;
        });
        showErrDialog(context, "Please check every inputed fields");
      }
    } catch (e) {
      setState(() {
        _loading = false;
      });
      print(e);
      showErrDialog(context, "Please check every inputed fields#");
    }
  }

  XFile? pickedfile;
  File? renimg;
  String url = '';
  bool _isactive = true;
  bool _isactivemem = false;
  bool _isactivepar = false;

  @override
  Widget build(BuildContext context) {
    // print(pickedfile!.mimeType);
    print(MediaQuery.of(context).size.height);
    return Scaffold(
        // backgroundColor: Colors.white70,
        appBar: AppBar(
          elevation: 0,
          flexibleSpace: Container(
            decoration: BoxDecoration(
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
          title: const Text(
            "নোটিশ পাঠান!",
            style: TextStyle(
              fontFamily: "myfont",
            ),
          ),
        ),
        body: Stack(
          children: [
            MediaQuery.of(context).size.width > 768
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
                        child: mainpart(context),
                      ),
                    ),
                  )
                : mainpart(context),
            Center(
              child: _loading ? CircularProgressIndicator() : Container(),
            ),
          ],
        ));
  }

  Padding mainpart(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          profile_Post != "সদস্য"
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          setState(() {
                            topic = 'member';
                            if (_isactivemem == true || _isactivepar == true) {
                              _isactive = true;

                              _isactivepar = false;
                              _isactivemem = false;
                            } else {
                              // _isactive = _isactive != true ? true : false;
                            }
                          });
                        },
                        child: const Text(
                          "সকল সদস্য",
                          style: TextStyle(
                            fontFamily: "myfont",
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 20),
                          primary: _isactive ? Colors.green : Colors.red,
                        )),
                    ElevatedButton(
                        onPressed: () {
                          setState(() {
                            topic = 'admin';
                            if (_isactive == true || _isactivemem == true) {
                              _isactivepar = true;

                              _isactive = false;
                              _isactivemem = false;
                            } else {
                              // _isactivepar = _isactivepar != true ? true : false;
                            }
                          });
                        },
                        child: const Text(
                          "কর্মপরিষদ",
                          style: TextStyle(
                            fontFamily: "myfont",
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 20),
                          primary: _isactivepar ? Colors.green : Colors.red,
                        )),
                    ElevatedButton(
                        onPressed: () {
                          setState(() {
                            topic = currentSelectedValue.toString();
                            // _isactivemem = _isactivemem != true ? true : false;
                            if (_isactive == true || _isactivepar == true) {
                              _isactivemem = true;

                              _isactive = false;
                              _isactivepar = false;
                            } else {
                              // _isactivemem = _isactivemem != true ? true : false;
                            }
                          });
                        },
                        child: Text(
                          "নির্দিষ্ট সদস্য",
                          style: TextStyle(
                            fontFamily: "myfont",
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 20),
                          primary: _isactivemem ? Colors.green : Colors.red,
                        )),
                  ],
                )
              : Container(),
          SizedBox(
            height: 20,
          ),
          Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.only(left: 0.8, right: 20),
              child: Column(
                children: <Widget>[
                  _isactivemem
                      ? DropdownButtonFormField(
                          value: currentSelectedValue,
                          hint: Text("select"),
                          isDense: true,
                          onChanged: (newValue) {
                            setState(() {
                              topic = newValue.toString();
                              currentSelectedValue = newValue.toString();
                            });
                          },
                          items: profile_names.map((e) {
                            return DropdownMenuItem(
                                child: Text("$e"), value: e);
                          }).toList(),
                        )
                      : profile_Post == 'সদস্য'
                          ? DropdownButtonFormField(
                              value: currentSelectedValue,
                              hint: Text("select"),
                              isDense: true,
                              onChanged: (newValue) {
                                setState(() {
                                  topic = newValue.toString();
                                  currentSelectedValue = newValue.toString();
                                });
                              },
                              items: profile_names.sublist(0, 7).map((e) {
                                return DropdownMenuItem(
                                    child: Text("$e"), value: e);
                              }).toList(),
                            )
                          : Container(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextFormField(
                      controller: title,
                      autofocus: true,
                      maxLines: 1,
                      keyboardType: TextInputType.text,
                      // style: const TextStyle(color: Colors.black),
                      // ignore: unnecessary_new
                      decoration: const InputDecoration(
                        errorText: null,
                        errorStyle: TextStyle(fontSize: 12),
                        labelText: 'বিষয়ঃ',
                        labelStyle: TextStyle(
                          color: Colors.black87,
                          fontFamily: "myfont",
                          fontSize: 18,
                        ),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                          color: Colors.green,
                        )),
                        // contentPadding: EdgeInsets.only(top: 7, bottom: 5),
                        hintStyle: TextStyle(
                          color: Color.fromRGBO(1, 22, 39, 1),
                        ),
                      ),
                      validator: (_val) {
                        if (_val!.isEmpty) {
                          return "Empty";
                        } else {
                          return null;
                        }
                      },

                      // onChanged: (_val) {
                      //   title = _val;
                      // },
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: body,
                    keyboardType: TextInputType.multiline,
                    maxLines: 6,
                    style: const TextStyle(color: Colors.black),
                    decoration: const InputDecoration(
                      labelText: 'মূল নোটিশ~',

                      errorText: null,
                      errorStyle: TextStyle(fontSize: 12),
                      labelStyle: TextStyle(
                          color: Colors.black87,
                          fontFamily: "myfont",
                          fontSize: 18),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.green,
                      )),
                      // contentPadding: EdgeInsets.only(top: 7, bottom: 5),
                      hintStyle: TextStyle(
                        color: Color.fromRGBO(1, 22, 39, 1),
                      ),
                    ),
                    validator: (_val) {
                      if (_val!.isEmpty) {
                        return 'Empty';
                      } else {
                        return null;
                      }
                    },
                    // validator: (_val){}
                    // onChanged: (_val) {
                    //   body = _val;
                    // },
                  ),
                  // Spacer(),

                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
          pickedfile != null
              ? FittedBox(
                  child: SizedBox(
                  height: MediaQuery.of(context).size.height * .1,
                  width: MediaQuery.of(context).size.width * .15,
                  child: kIsWeb
                      ? Image(
                          image: NetworkImage(pickedfile!.path),
                          fit: BoxFit.contain,
                        )
                      : Image(
                          image: FileImage(File(pickedfile!.path)),
                          fit: BoxFit.contain,
                        ),
                ))
              : profile_Post != 'সদস্য' &&
                      (topic == 'member' || topic == 'admin')
                  ? TextButton.icon(
                      onPressed: () async {
                        var pickedfile1 = await ImagePicker().pickImage(
                          source: ImageSource.gallery,

                          // maxWidth: maxWidth,
                          // maxHeight: maxHeight,
                          imageQuality: 87,
                        );
                        setState(() {
                          pickedfile = pickedfile1;
                          renimg = File(pickedfile1!.path);
                        });
                        // print(pickedfile1!.mimeType);
                      },
                      icon: Icon(Icons.add_a_photo_outlined),
                      label: Text('Thumbnail'))
                  : SizedBox(),
          // Spacer(),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            width: 125,
            height: 40,
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  _loading = true;
                });

                handlesendmsg(context, profile_Post);
              },
              child: Row(
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  const Text(
                    "প্রেরণ করুন",
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: "myfont",
                        fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  const Icon(
                    Icons.send_to_mobile_outlined,
                    size: 16,
                  ),
                ],
              ),
              style: ElevatedButton.styleFrom(
                elevation: 3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
