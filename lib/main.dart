

// Import statements
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

//main function that calls  the web application

void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}



//We create create our  heading template

Widget heading = Align(
    alignment: Alignment.center,
    child: Container(
      margin: EdgeInsets.fromLTRB(30, 100, 10, 10),
      padding: EdgeInsets.all(0),
      child: Text(
        "TECHBOARD",
        style: TextStyle(
            fontStyle: FontStyle.normal, fontSize: 76, color: Colors.black87),
      ),
      decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.orange),
    ));


// Class for the dynamic widgets in flutter


class MyApp extends StatefulWidget {
  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  List data;     //we create our List and then store the data into our list as byte stream

  @override
  Widget build(BuildContext context) {  // We use the widget builder to Render our User Interface
    return Scaffold(
        body: Container(
      child: ListView(
        children: <Widget>[
          heading,
        // Use future builder and DefaultAssetBundle to load the local JSON file
         FutureBuilder(
            future: DefaultAssetBundle.of(context)
                .loadString('data_repo/starwars_data.json'),      //Local Json File
            builder: (context, snapshot) {
              // Decode the JSON
              var new_data = json.decode(snapshot.data.toString());

              return ListView.builder(   //building the listview
                shrinkWrap: true,
                // Build the ListView
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: EdgeInsets.fromLTRB(560, 10, 560, 10),
                    alignment: Alignment.center,


                    child: Card(
                      child: InkWell(
onTap:() async {
 final url = new_data[index]['url'];

  if (await canLaunch(url)) {
    await launch(url, forceSafariVC: false);
  } else {
    throw 'Could not launch $url';
  }
},
                        child:  ListTile(
                          contentPadding: EdgeInsets.all(24),
                          leading: Image.network(
                            new_data[index]['imageurl'],
                            fit: BoxFit.cover,
                          ),
                          title: Text(
                            new_data[index]['headline'],
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          subtitle: Text(
                            new_data[index]['summary'],
                          ),
                          isThreeLine: true,
                        ),
                      )
                    ),
                  );
                },
                itemCount: new_data == null ? 0 : new_data.length,
              );
            }),
      ]),
    ));
  }
}





_launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);          //we use this method to launch our URL and server
  } else {
    throw 'Could not launch $url';
  }
}
