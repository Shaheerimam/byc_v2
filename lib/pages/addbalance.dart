import 'package:byc_v2/Home_page/variables.dart';
import 'package:flutter/material.dart';

class addbalance extends StatefulWidget {
  final List names;
  addbalance({required this.names});

  @override
  State<addbalance> createState() => _addbalanceState();
}

var val;
bool value = true;

class _addbalanceState extends State<addbalance> {
  @override
  Widget build(BuildContext context) {
    var currentSelectedValue = profile_names[0];
    var currentSelectedValue1 = "January";
    var currentSelectedValue2 = "2021";

    return Scaffold(
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
        centerTitle: true,
        title: Text(
          "সদস্যের মাসিক সঞ্চয় যুক্ত করুন",
          style: TextStyle(
            fontFamily: "myfont",
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "সদস্যের নাম:",
                  style: TextStyle(fontFamily: "myfont", fontSize: 18),
                ),
                SizedBox(
                  width: 3,
                ),
                Expanded(
                  child: DropdownButtonHideUnderline(
                    child: DropdownButtonFormField(
                      decoration: InputDecoration.collapsed(hintText: ''),
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
                        return DropdownMenuItem(child: Text("$e"), value: e);
                      }).toList(),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "মাস: ",
                  style: TextStyle(fontFamily: "myfont", fontSize: 18),
                ),
                Expanded(
                  child: DropdownButtonHideUnderline(
                    child: DropdownButtonFormField(
                        decoration: InputDecoration.collapsed(hintText: ''),
                        isExpanded: true,
                        value: currentSelectedValue1,
                        hint: Text("নির্বাচন করুন"),
                        isDense: true,
                        onChanged: (Value) {
                          setState(() {
                            // topic = newValue.toString();
                            currentSelectedValue1 = Value.toString();
                          });
                        },
                        // ignore: prefer_const_literals_to_create_immutables
                        items: [
                          DropdownMenuItem(
                            child: Text("January"),
                            value: "January",
                          ),
                          DropdownMenuItem(
                            child: Text("February"),
                            value: "February",
                          ),
                          DropdownMenuItem(
                            child: Text("March"),
                            value: "March",
                          ),
                          DropdownMenuItem(
                            child: Text("April"),
                            value: "April",
                          ),
                          DropdownMenuItem(
                            child: Text("May"),
                            value: "May",
                          ),
                          DropdownMenuItem(
                            child: Text("June"),
                            value: "June",
                          ),
                          DropdownMenuItem(
                            child: Text("July"),
                            value: "July",
                          ),
                          DropdownMenuItem(
                            child: Text("August"),
                            value: "August",
                          ),
                          DropdownMenuItem(
                            child: Text("September"),
                            value: "September",
                          ),
                          DropdownMenuItem(
                            child: Text("October"),
                            value: "October",
                          ),
                          DropdownMenuItem(
                            child: Text("November"),
                            value: "November",
                          ),
                          DropdownMenuItem(
                            child: Text("December"),
                            value: "December",
                          ),
                        ]),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Divider(),
                Text(
                  "সন: ",
                  style: TextStyle(fontFamily: "myfont", fontSize: 18),
                ),
                Expanded(
                  child: DropdownButtonHideUnderline(
                    child: DropdownButtonFormField(
                        decoration: InputDecoration.collapsed(hintText: ''),
                        isExpanded: true,
                        value: currentSelectedValue2,
                        hint: Text("নির্বাচন করুন"),
                        isDense: true,
                        onChanged: (Value1) {
                          setState(() {
                            // topic = newValue.toString();
                            currentSelectedValue2 = Value1.toString();
                          });
                        },
                        // ignore: prefer_const_literals_to_create_immutables
                        items: [
                          DropdownMenuItem(
                            child: Text("2021"),
                            value: "2021",
                          ),
                          DropdownMenuItem(
                            child: Text("2022"),
                            value: "2022",
                          ),
                          DropdownMenuItem(
                            child: Text("2023"),
                            value: "2023",
                          ),
                          DropdownMenuItem(
                            child: Text("2024"),
                            value: "2024",
                          ),
                          DropdownMenuItem(
                            child: Text("2025"),
                            value: "2025",
                          ),
                          DropdownMenuItem(
                            child: Text("2026"),
                            value: "2026",
                          ),
                          DropdownMenuItem(
                            child: Text("2027"),
                            value: "2027",
                          ),
                          DropdownMenuItem(
                            child: Text("2028"),
                            value: "2028",
                          ),
                        ]),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
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
              mainAxisAlignment: MainAxisAlignment.center,
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
                Text("মোবাইল ব্যাংকিং"),
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
                Text("অর্থ সম্পাদক"),
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
                Text("অন্যান্য"),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "জরিমানা:",
                  style: TextStyle(fontFamily: "myfont", fontSize: 18),
                ),
                Checkbox(
                  autofocus: true,
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
                onPressed: () {},
                child: Text(
                  "যুক্ত করুন",
                  style: TextStyle(fontFamily: "myfont", fontSize: 25),
                )),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
