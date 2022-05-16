import 'package:byc_v2/Home_page/pages.dart';
import 'package:byc_v2/Home_page/variables.dart';
import 'package:byc_v2/pages/maintain.dart';
import 'package:byc_v2/pages/messanging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gsheets/gsheets.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
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

class pay extends StatefulWidget {
  @override
  State<pay> createState() => _payState();
}

var val;

bool value = false;
bool loading = false;
// var currentSelectedValue1;
// var currentSelectedValue2;
var currentSelectedValue;
var maddom1;
DateTime selectedDate = DateTime.now();
double? fee;
double collection = 0;

class _payState extends State<pay> {
  @override
  Widget build(BuildContext context) {
    // print(DateFormat.MMMM().format(selectedDate));
    // print(DateFormat.y().format(selectedDate));
    // selectedDate.difference(DateTime.now() > 1 ?print("object"):print(""),
    if (profile_Post != "অর্থসম্পাদক") {
      setState(() {
        currentSelectedValue = profile_name;
      });
    }
    var maddom;
    if (val == 1) {
      maddom = "মোবাইল ব্যাংকিং";
    } else if (val == 2) {
      maddom = "অর্থ সম্পাদক";
    } else {
      maddom = maddom1;
    }

    return Scaffold(
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
                    child: main_part(context, maddom),
                  ),
                ),
              )
            : main_part(context, maddom));
  }

  Widget main_part(BuildContext context, maddom) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  profile_Post == "অর্থসম্পাদক"
                      ? Text(
                          "সদস্যের নাম:",
                          style: TextStyle(fontFamily: "myfont", fontSize: 18),
                        )
                      : Text(
                          "নাম:",
                          style: TextStyle(fontFamily: "myfont", fontSize: 18),
                        ),
                  SizedBox(
                    width: 3,
                  ),
                  Expanded(
                      child: profile_Post == "অর্থসম্পাদক"
                          ? DropdownButtonHideUnderline(
                              child: DropdownButtonFormField(
                                decoration:
                                    InputDecoration.collapsed(hintText: ''),
                                isExpanded: true,
                                value: currentSelectedValue,
                                hint: Text("নির্বাচন করুন"),
                                isDense: true,
                                onChanged: (newValue) {
                                  setState(() {
                                    // topic = newValue.toString();
                                    currentSelectedValue = newValue.toString();
                                  });
                                  print(currentSelectedValue);
                                },
                                items: profile_names.map((e) {
                                  return DropdownMenuItem(
                                      child: Text("$e"), value: e);
                                }).toList(),
                              ),
                            )
                          : Text(
                              "${profile_name}",
                              style:
                                  TextStyle(fontFamily: "myfont", fontSize: 16),
                            ))
                ],
              ),
              SizedBox(
                height: 10,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                      onPressed: () {
                        showMonthPicker(
                          context: context,
                          firstDate: DateTime(DateTime.now().year - 1, 5),
                          lastDate: DateTime(DateTime.now().year + 1, 9),
                          initialDate: selectedDate,
                          locale: Locale("en"),
                        ).then((date) {
                          if (date != null) {
                            setState(() {
                              selectedDate = date;
                            });
                          }
                        });
                      },
                      icon: Icon(
                        Icons.calendar_today_rounded,
                        color: Colors.redAccent,
                      )),
                  TextButton(
                      onPressed: () {
                        showMonthPicker(
                          context: context,
                          firstDate: DateTime(DateTime.now().year - 1, 5),
                          lastDate: DateTime(DateTime.now().year + 1, 9),
                          initialDate: selectedDate,
                          locale: Locale("en"),
                        ).then((date) {
                          if (date != null) {
                            setState(() {
                              selectedDate = date;
                            });
                          }
                        });
                      },
                      child: Text(
                        DateFormat.yMMMM('en_US').format(selectedDate),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                ],
              ),
              Center(
                child: Text(
                  "মাধ্যম:",
                  style: TextStyle(fontFamily: "myfont", fontSize: 18),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Radio(
                      value: 1,
                      groupValue: val,
                      onChanged: (value) {
                        setState(() {
                          val = value;
                        });
                      },
                      //activeColor: Colors.green,
                    ),
                  ),
                  Text(
                    "মোবাইল ব্যাংকিং",
                    style: TextStyle(fontFamily: "myfont", fontSize: 14),
                  ),
                  Expanded(
                    child: Radio(
                      value: 2,
                      groupValue: val,
                      onChanged: (value) {
                        setState(() {
                          val = value;
                        });
                      },
                      //activeColor: Colors.green,
                    ),
                  ),
                  Text(
                    "অর্থ সম্পাদক",
                    style: TextStyle(fontFamily: "myfont", fontSize: 14),
                  ),
                  Expanded(
                    child: Radio(
                      value: 3,
                      groupValue: val,
                      onChanged: (value) {
                        setState(() {
                          val = value;
                        });
                      },
                      //activeColor: Colors.redAccent,
                    ),
                  ),
                  const Text(
                    "অন্যান্য",
                    style: TextStyle(fontFamily: "myfont", fontSize: 14),
                  ),
                  Spacer(),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              // ignore: prefer_const_constructors
              val == 3
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 70),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButtonFormField(
                          decoration: InputDecoration.collapsed(hintText: ''),
                          isExpanded: true,
                          value: maddom1,
                          hint: Text("নির্বাচন করুন"),
                          isDense: true,
                          onChanged: (newValue1) {
                            setState(() {
                              // topic = newValue.toString();
                              maddom1 = newValue1.toString();
                            });
                            // print(currentSelectedValue);
                          },
                          items: profile_names.sublist(0, 7).map((e) {
                            return DropdownMenuItem(
                                child: Text("$e"), value: e);
                          }).toList(),
                        ),
                      ),
                    )
                  : SizedBox(),

              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FittedBox(child: Text("মাসিক সঞ্চয়ঃ ")),
                    Container(
                      width: 200,
                      child: TextField(
                        autofocus: true,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(color: Colors.black),
                        // ignore: unnecessary_new
                        decoration: const InputDecoration(
                          errorText: null,
                          errorStyle: TextStyle(fontSize: 0),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                            color: Color.fromRGBO(1, 22, 39, 1),
                          )),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                            color: Colors.redAccent,
                          )),
                          // hintText: '',
                          hintStyle: TextStyle(
                            color: Color.fromRGBO(1, 22, 39, 1),
                          ),
                        ),

                        onChanged: (_val) {
                          fee = double.parse(_val);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FittedBox(child: Text("বিশেষ কালেকশনঃ ")),
                  Container(
                    width: 200,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      style: const TextStyle(color: Colors.black),
                      // ignore: unnecessary_new
                      decoration: const InputDecoration(
                        errorText: null,

                        hintText: '00.0',
                        errorStyle: TextStyle(fontSize: 0),
                        // labelText: 'মাসিক সঞ্চয়ঃ',
                        // labelStyle: TextStyle(color: Colors.black87),
                        // border: new OutlineInputBorder(
                        //     borderRadius: const BorderRadius.all(
                        //         const Radius.circular(30.0))),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                          color: Color.fromRGBO(1, 22, 39, 1),
                        )),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                          color: Colors.redAccent,
                        )),
                        // contentPadding: EdgeInsets.only(top: 7, bottom: 5),
                        // prefixIcon: Icon(
                        //   Icons.email_outlined,
                        //   color: Color.fromRGBO(1, 22, 39, 1),
                        // ),
                        // hintText: 'মাসিক সঞ্চয়ঃ',
                        // prefixIcon: Text(
                        //   'মাসিক সঞ্চয়ঃ',
                        //   style: TextStyle(
                        //       textBaseline: TextBaseline.ideographic,
                        //       color: Colors.black87,
                        //       fontFamily: 'myfont'),
                        // ),

                        // prefixStyle: TextStyle(
                        //     color: Colors.black87, fontFamily: 'myfont'),

                        hintStyle: TextStyle(
                          color: Color.fromRGBO(1, 22, 39, 1),
                        ),
                      ),

                      onChanged: (_val) {
                        collection = double.parse(_val);
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // ignore: prefer_const_constructors
                  Text(
                    "জরিমানা:",
                    style: TextStyle(fontFamily: "myfont", fontSize: 18),
                  ),
                  Checkbox(
                    // autofocus: true,
                    value: value,
                    onChanged: (val) {
                      setState(() {
                        value = val!;
                      });
                    },
                  ),
                ],
              ),
              Spacer(),
              ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      loading = true;
                    });
                    if (fee != null) {
                      try {
                        String data_time =
                            "${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year} Time-${DateTime.now().hour}:${DateTime.now().minute}";
                        var email = await email1(currentSelectedValue);
                        DocumentSnapshot user = await FirebaseFirestore.instance
                            .collection('users')
                            .doc(email)
                            .get();
                        Map<String, dynamic> data1 =
                            user.data() as Map<String, dynamic>;
                        var taka = data1['Balance'] + 0.0;
                        String _token = await token(currentSelectedValue);
                        print(_token);
                        if (profile_Post == "অর্থসম্পাদক") {
                          addlist(
                              DateFormat.yMMMM('en_US').format(selectedDate),
                              maddom,
                              value,
                              currentSelectedValue,
                              "accept",
                              taka);
                          // addbalance1(
                          //     currentSelectedValue,
                          //     maddom,
                          //     value,
                          //     // DateFormat.yMMMM('en_US').format(selectedDate),
                          //     selectedDate.toLocal().toString(),
                          //     context,
                          //     "accept",
                          //     data_time);
                          var email2 = await email1(currentSelectedValue);
                          // updateUser(email2, taka);
                          await FirebaseFirestore.instance
                              .collection('users')
                              .doc(email2)
                              .collection('balanceHIS')
                              .doc(data_time)
                              .set({
                            "date": data_time,
                            "month": selectedDate.toLocal().toString(),
                            "maddom": maddom,
                            "jorimana": value,
                            "fee": fee,
                            "collection": collection,
                          });
                          final response = await Messaging.sendToTopic(
                            title: "অ্যাকাউন্ট আপডেট হয়েছে!",
                            body:
                                "আপনার ${DateFormat.y().format(selectedDate)} ${DateFormat.MMMM().format(selectedDate)} মাসের মাসিক সঞ্চয় যুক্ত করা হয়েছে।",
                            topic: _token,
                            route: "route",
                            url: '',
                          );
                          // print("${await token(currentSelectedValue)}");
                          if (response.statusCode != 200) {
                            print("error");
                          }
                          updateUser(email, taka, value, fee!, collection);
                          addnotice(
                                  "অ্যাকাউন্ট আপডেট হয়েছে!",
                                  "আপনার ${DateFormat.MMMM().format(selectedDate)} মাসের মাসিক সঞ্চয় যুক্ত করা হয়েছে।",
                                  await token(currentSelectedValue),
                                  profile_Post,
                                  currentSelectedValue)
                              .then((value) {
                            setState(() {
                              loading = false;
                              currentSelectedValue = null;
                              collection = 0.0;
                              fee = null;
                              val = null;
                            });
                            Fluttertoast.showToast(
                                msg: "সফল হয়েছে!",
                                backgroundColor: Colors.redAccent);
                          });
                        } else {
                          setState(() {
                            loading = false;
                          });
                          final response = await Messaging.sendToTopic(
                            title:
                                "নতুন পেমেন্ট রিকুয়েস্ট এসেছে!~~$profile_name",
                            body: """ 
                                  নামঃ ${profile_name} ,
                                  মাসঃ ${DateFormat.y().format(selectedDate)} ${DateFormat.MMMM().format(selectedDate)},
                                  মাসিক সঞ্চয়ঃ $fee ,
                                  বিশেষ কালেকশনঃ $collection ,
                          'প্রিয় অর্থসম্পাদক, আমার মাসিক সঞ্চয় যুক্ত করুন!
                                  ~~ধন্যবাদ।
                                  """,
                            topic: "money_mana",
                            route: "home",
                            url: '',
                          );
                          var IMPnames = await FirebaseFirestore.instance
                              .collection('list')
                              .doc('IMPnames')
                              .get();
                          String moneymanaemail = IMPnames['moneymanaemail'];
                          await FirebaseFirestore.instance
                              .collection('users')
                              .doc(moneymanaemail)
                              .collection("notice")
                              .doc(DateTime.now().toString())
                              .set({
                            'title':
                                'নতুন পেমেন্ট রিকুয়েস্ট এসেছে!~~$profile_name',
                            'body': """  নামঃ ${profile_name} ,
                                  মাসঃ ${DateFormat.y().format(selectedDate)} ${DateFormat.MMMM().format(selectedDate)},
                                  মাসিক সঞ্চয়ঃ $fee ,
                                  বিশেষ কালেকশনঃ $collection ,
                          'প্রিয় অর্থসম্পাদক, আমার মাসিক সঞ্চয় যুক্ত করুন!
                                  ~~ধন্যবাদ।
                                  """,
                            "date": DateTime.now().toString(),
                            "from": profile_name,
                            'to': 'অর্থসম্পাদক',
                          });
                          Fluttertoast.showToast(
                              msg: "সফল হয়েছে!",
                              backgroundColor: Colors.redAccent);
                        }
                      } catch (e) {
                        setState(() {
                          loading = false;
                        });
                        print(e);
                        showErrDialog(context, "Plaase fill the form properly");
                      }
                    } else {
                      setState(() {
                        loading = false;
                      });
                      showErrDialog(context, 'fill All fields properly');
                    }
                  },
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * .35,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        const Text(
                          "যুক্ত করুন",
                          style: TextStyle(fontFamily: "myfont", fontSize: 25),
                        ),
                        const Icon(Icons.add_outlined),
                      ],
                    ),
                  )),
              Spacer(),
            ],
          ),
        ),
        loading ? Center(child: CircularProgressIndicator()) : Container(),
      ],
    );
  }
}
