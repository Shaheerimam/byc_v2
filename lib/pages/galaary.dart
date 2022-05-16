import 'dart:io';

import 'package:byc_v2/Home_page/variables.dart';
import 'package:byc_v2/pages/maintain.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime_type/mime_type.dart';
import 'package:photo_view/photo_view.dart';
import 'package:path/path.dart' as Path;

class gallary extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: profile_Post != 'সদস্য'
          ? FloatingActionButton(
              child: Icon(Icons.add_a_photo_outlined),
              onPressed: () async {
                var pickedfile1 = await ImagePicker().pickImage(
                  source: ImageSource.gallery,

                  // maxWidth: maxWidth,
                  // maxHeight: maxHeight,
                  imageQuality: 70,
                );

                var pickedfile = pickedfile1;

                if (mime(pickedfile!.name) == 'image/jpeg') {
                  Reference _reference = FirebaseStorage.instance
                      .ref()
                      .child('gallery/${Path.basename(pickedfile.path)}');
                  await _reference
                      .putData(
                    await pickedfile.readAsBytes(),
                    SettableMetadata(contentType: 'image/jpeg'),
                  )
                      .whenComplete(() async {
                    await _reference.getDownloadURL().then((value1) async {
                      await FirebaseFirestore.instance
                          .collection('gallary')
                          .add({
                        'url': value1,
                      });
                    });
                  });
                } else {
                  showErrDialog(context, 'Image must be in a jpeg format');
                }
              })
          : null,
      // appBar: AppBar(
      //   elevation: 0,
      //   flexibleSpace: Container(
      //     decoration: BoxDecoration(
      //       gradient: LinearGradient(
      //           begin: Alignment.topLeft,
      //           end: Alignment.bottomRight,
      //           stops: [
      //             0.1,
      //             0.9
      //           ],
      //           colors: <Color>[
      //             Color(0xFFFF512F),
      //             Color(0xFFDD2476),
      //           ]),
      //     ),
      //   ),
      //   centerTitle: true,
      //   title: Text("গ্যালারি"),
      // ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("gallary").snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (kIsWeb) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 2,
                scrollDirection: Axis.vertical,
                mainAxisSpacing: 4,
                primary: true,
                // mainAxisSpacing: ,
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data() as Map<String, dynamic>;

                  return Container(
                      decoration: BoxDecoration(
                          border: Border.all(width: 2.0, color: Colors.white),
                          shape: BoxShape.rectangle,
                          image: new DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(data['url']))));
                }).toList(),
              ),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 2,
                scrollDirection: Axis.vertical,
                mainAxisSpacing: 4,
                primary: true,
                // mainAxisSpacing: ,
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data() as Map<String, dynamic>;

                  return Hero(
                    tag: data['url'],
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => photoview(url: data['url'])));
                      },
                      child: Container(
                          decoration: BoxDecoration(
                              border:
                                  Border.all(width: 2.0, color: Colors.white),
                              shape: BoxShape.rectangle,
                              image: new DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(data['url'])))),
                      // SizedBox.expand(
                      //     child: FadeInImage(
                      //   image: NetworkImage(data['url']),
                      //   placeholder: AssetImage("assets/byc_logo.png"),
                      // )),
                    ),
                  );
                }).toList(),
              ),
            );
          }
        },
      ),
    );
  }
}

class photoview extends StatelessWidget {
  final String url;
  photoview({required this.url});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Scaffold(
          body: Hero(
            tag: url,
            child: PhotoView(
              imageProvider: NetworkImage(url),
            ),
          ),
        ),
      ),
    );
  }
}
