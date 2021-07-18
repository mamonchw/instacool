import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class GetUserName extends StatelessWidget {
  final String documentId;

  GetUserName(this.documentId);

  @override
  Widget build(BuildContext context) {
    CollectionReference users =
    FirebaseFirestore.instance.collection('webdata');

    return Center(
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
        height:250,
        width: MediaQuery.of(context).size.height * 1.5,
        child: FutureBuilder<DocumentSnapshot>(
          future: users.doc(documentId).get(),
          builder: (BuildContext context,
              AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text("Something went wrong");
            }

            if (snapshot.hasData && !snapshot.data.exists) {
              return Text("Document does not exist");
            }

            if (snapshot.connectionState == ConnectionState.done) {
              Map<String, dynamic> data =
              snapshot.data.data() as Map<String, dynamic>;

              return Center(
                child: Container(
                  color: Colors.transparent,
                  height: 250,
                  width: MediaQuery.of(context).size.height * 1.0,
                  //alignment: Alignment.,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AboutCard(data['dpUrl']),
                      Pad(),
                      Text(
                        "${data['name']}",
                        style: TextStyle(
                            fontSize: 22.0, fontWeight: FontWeight.w400),
                      ),
                      Bio(data['bio'])
                    ],
                  ),
                ),
              );
              //Text("Full Name: ${data['bio']} ${data['name']}");
            }

            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.lightGreenAccent,
              ),
            );
          },
        ),
      ),
    );
  }
}

class AboutCard extends StatelessWidget {
  final String dpUrl;
  AboutCard(this.dpUrl);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Container(
        width: 120,
        height: 120,
        margin: EdgeInsets.only(top: 25.0),
        decoration: BoxDecoration(
            image:
                DecorationImage(image: NetworkImage(dpUrl), fit: BoxFit.cover),
            color: Colors.pink,
            borderRadius: BorderRadiusDirectional.circular(100)),
      ),
    );
  }
}

class Pad extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(5.0),
    );
  }
}

class Bio extends StatelessWidget {
  final String bio;
  Bio(this.bio);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Flexible(
          child: Text(
            bio,
            style: TextStyle(color: Colors.blueGrey[200], fontSize: 12.0),
          ),
        ),
      ),
      color: Colors.transparent,
      height: 25,
      width: MediaQuery.of(context).size.width * 0.5,
    );
  }
}
