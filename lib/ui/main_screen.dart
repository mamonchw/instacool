import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'components/icons.dart';
import 'package:url_launcher/link.dart';
import 'components/aboutcard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class MainScreen extends StatelessWidget {
  final String name;
  const MainScreen(this.name);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber[100],
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          children: [Pad(),
            GetUserName(name),GetLinks(name)
          ],
        ),
      )
    );
  }
}





class GetLinks extends StatelessWidget {
  final String documentId;

  GetLinks(this.documentId);

  @override
  Widget build(BuildContext context) {
    CollectionReference users =
        FirebaseFirestore.instance.collection('webdata');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {

          return Text("Something went wrong");

        }

        if (snapshot.hasData && !snapshot.data.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data.data() as Map<String, dynamic>;
          var datas = data['datas'];
          var profiles =data['profiles'];
          if(datas.length!=0){

            return ListView.builder(
                physics: NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
                itemCount: datas.length,
                itemBuilder: (context, index) {
                  return Center(
                      child: Link(
                        uri: Uri.parse(datas[index]['link']),
                        builder: (context, followLink) {
                          return
                            InkWell(
                                child: Container(
                                  height: 150,
                                  width: MediaQuery.of(context).size.height * 1.5,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(15.0)),
                                      //elevation: 5,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(30.0)),
                                        margin: EdgeInsets.all(10.0),
                                        width:
                                        MediaQuery.of(context).size.width * 1.5,
                                        height: 100.0,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 1.0,
                                              bottom: 8.0,
                                              left: 10.0,
                                              right: 8.0),
                                          child: Row(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                mainAxisAlignment:
                                                MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Flexible(
                                                      child: Text(
                                                        datas[index]['title'],
                                                        style: TextStyle(
                                                            fontSize: 20.0,
                                                            fontWeight:
                                                            FontWeight.w400),
                                                      )),
                                                  Padding(
                                                      padding:
                                                      EdgeInsets.only(top: 5.0),
                                                      child: Flexible(
                                                        child: Text(
                                                          datas[index]['des'],
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .blueGrey[100],
                                                              fontSize: 15.0),
                                                        ),
                                                      )),
                                                  //Text("Rating:${movie.imdbRating}/10",style: mainTextStyle(),)
                                                ],
                                              ),
                                              Center(
                                                child: Container(
                                                  height: 90,
                                                  width: 90,
                                                  decoration: BoxDecoration(
                                                      color: Colors.green,
                                                      image: DecorationImage(
                                                          image: NetworkImage(
                                                              datas[index]['thum']),
                                                          fit: BoxFit.cover),
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                onTap: followLink
                          );
                        },
                      ));
                });

          }
          else return ListView.builder(
            shrinkWrap: true,
              itemCount: profiles.length,
              itemBuilder: (context, index) {
                return Container(
                  height: 100,
                  width: 100,
                  child: Center(
                    child: Text("links")
                  ),
                );
              });


        }

        return Center(
          child: LinearProgressIndicator(
            backgroundColor: Colors.lightGreenAccent,
          ),
        );
      },
    );
  }
}
