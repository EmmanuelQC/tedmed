import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import 'Learn.dart';


//TODO add input - age, gender, heart rate (maximum), strenous chest pain (index 1-4), blood pressure

//TODO Add doctor booking, notification when ready

/* Treatment */
String symptomsT = "Symptoms: ";
String treatment = "Treatment: ";

final _controllerT = TextEditingController();

double rating = 4;

/* initial symptoms */
final _controller = TextEditingController();
String symptom = "";
/* details */
final _controllerD = TextEditingController();
String symptomD = "Details";

final _controllerC = TextEditingController();
String symptomC = "";
final _controllerA = TextEditingController();
String symptomA = "";


/* widget management */
bool _checked = false;
bool _checked1 = false;
bool _checked2 = false;

bool accepted = false;

int sSubmitted = 0;
bool _visibility = false;

String question = "";
String question1 = "";
String question2 = "";

//gender
String dropdownValue = 'Male';

List <String> spinnerItems = [
  'Male',
  'Female',
];

class Doctor {
  final int userId;
  final int id;
  final String title;

  Doctor({this.userId, this.id, this.title});

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
    );
  }
}

Future<http.Response> fetchAlbum() {
  return http.get('https://api.betterdoctor.com/2016-03-01/info?user_key=c97402aaff889512286a6ec7c4af3c9a');
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TedMed',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFFEFEFEF),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'TedMed'),
      themeMode: ThemeMode.dark,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: SafeArea(
        child: FloatingActionButton.extended(
          backgroundColor: Colors.blue,
          label: Text("Chat Bot"),
          icon: Icon(Icons.info),
          //TODO launch bot url, add button to analyse diagnosis, see diagnosis history, symptom search, doctor search
          onPressed: () {
            botCurl();
          },
        ),
      ),
      drawer: SafeArea(
        child: Drawer(child:
        ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text("User user"),
              accountEmail: Text("user@gmail.com"),
              currentAccountPicture: CircleAvatar(
                backgroundColor:
                Theme.of(context).platform == TargetPlatform.android
                    ? Colors.lightBlueAccent
                    : Colors.white,
                child: Text(
                  "U",
                  style: TextStyle(fontSize: 40.0),
                ),
              ),
            ),
            ListTile(leading: Icon(Icons.account_circle), trailing: Icon(Icons.arrow_right), title: Text("Account", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.deepOrange, fontSize: 24)),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (BuildContext context) => Account()));
                }),
            ListTile(leading: Icon(Icons.home), trailing: Icon(Icons.arrow_right), title: Text("Main", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue, fontSize: 24)),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (BuildContext context) => MyApp()));
            }),
            ListTile(leading: Icon(Icons.assessment), trailing: Icon(Icons.arrow_right),title: Text("Learn", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.orange, fontSize: 24)),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (BuildContext context) => Learn()));
                }),
            ListTile(leading: Icon(Icons.info), trailing: Icon(Icons.arrow_right), title: Text("About", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green, fontSize: 24)),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (BuildContext context) => About()));
                }),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.black,
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        actions: <Widget>[
          Stack(
            children: <Widget>[
              SafeArea(
                child: IconButton(
                  icon: Icon(Icons.message,color: Colors.white),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MyApp()));
                  },
                ),
              ),
            ],
          )
        ],
      ),
      body: ListView(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top:12.0, left: 12, right: 12, bottom: 7),
                child: TextField(
                  style: TextStyle(color: Colors.white, fontSize: 22),
                  decoration: InputDecoration(
                    hintText: "Input Your Symptoms",
                    hintStyle: TextStyle(color: Colors.white, fontSize: 22),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 3),
                      borderRadius: BorderRadius.all(Radius.circular(12))
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.orangeAccent, width: 4),
                        borderRadius: BorderRadius.all(Radius.circular(33))
                    ),
                    prefixIcon: Icon(Icons.accessibility, color: Colors.blue, size: 39),
                  ),
                  controller: _controller,
                ),
              ),
              /*
              Visibility(
                visible: _visibilityQ,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Additional Details',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Visibility(
                  visible: _visibilityQ,
                  child: TextField(
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "$question",
                      hintStyle: TextStyle(color: Colors.white),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                          borderRadius: BorderRadius.all(Radius.circular(33))
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.redAccent),
                          borderRadius: BorderRadius.all(Radius.circular(33))
                      ),
                      prefixIcon: Icon(Icons.details, color: Colors.blue,),
                    ),
                    controller: _controllerD,
                  ),
                ),
              ),
               */
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Visibility(
                    visible: _visibility,
                    child: IconButton(icon: Icon(Icons.refresh, color: Colors.green), onPressed: () {setState(() {
                      _visibility = !_visibility;
                      sSubmitted = 0;
                      _checked = false;
                      _checked1 = false;
                      _checked2 = false;
                    });},),
                  ),
                  Builder(
                    builder: (context) => Padding(
                      padding: const EdgeInsets.only(top:3, left: 3, right: 3, bottom: 3),
                      child: Container(
                        child: FlatButton(
                          child: Text("Submit", style: TextStyle(fontSize: 18)),
                          textColor: Colors.white,
                          color: Colors.redAccent,
                          onPressed: () {
                            setState(() {
                              if (sSubmitted >= 0 && _controller != null) {
                                debugPrint("Submit btn pressed");
                                showDialog(barrierDismissible: false, context: context, builder: (context) {
                                  return StatefulBuilder(
                                    builder: (context, setState) {
                                      return AlertDialog(title: Text("Additional Details", style: TextStyle(color: Colors.blue),textAlign: TextAlign.center),
                                        content: SafeArea(
                                          child: Container(
                                            height: 350,
                                            child: Column(children: [
                                              DropdownButton<String>(
                                                value: dropdownValue,
                                                icon: Icon(Icons.arrow_drop_down),
                                                iconSize: 24,
                                                elevation: 16,
                                                style: TextStyle(color: Colors.blue, fontSize: 18),
                                                onChanged: (String data) {
                                                  setState(() {
                                                    dropdownValue = data;
                                                  });
                                                },
                                                items: spinnerItems.map<DropdownMenuItem<String>>((String value) {
                                                  return DropdownMenuItem<String>(
                                                    value: value,
                                                    child: Text(value),
                                                  );
                                                }).toList(),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Column(
                                                  children: <Widget>[
                                                    Text("Pain scale 1-4 (1 least painful)", style: TextStyle(color: Colors.blue)),
                                                    Slider(
                                                      value: rating,
                                                      min: 0.0,
                                                      max: 4.0,
                                                      divisions: 4,
                                                      label: "$rating",
                                                      onChanged: (double newR) {
                                                        setState(() {
                                                          rating = newR;
                                                        });
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                  padding: const EdgeInsets.all(3.0),
                                                  child: questionW("How old are you?", _controllerA)
                                              ),
                                              Padding(
                                                  padding: const EdgeInsets.all(3.0),
                                                  child: questionW("Blood Sugar Level", _controllerT)
                                              ),
                                              Expanded(
                                                child: Padding(
                                                    padding: const EdgeInsets.all(3.0),
                                                    child: questionW("Cholesterol Level", _controllerC)
                                                ),
                                              ),
                                            ]),
                                          ),
                                        ),
                                        actions: <Widget>[
                                          MaterialButton(elevation: 5, child: Text("Submit", style: TextStyle(color: Colors.blue),),
                                            onPressed: () {
                                            symptomD = _controllerD.text;
                                            symptomA = _controllerA.text;
                                            symptomC = _controllerC.text;
                                            symptomsT = _controllerT.text;
                                            if (symptomA.compareTo("") != 0 && symptomA.compareTo("") != 0 && symptomsT.compareTo("") != 0 && symptomC.compareTo("") != 0) {
                                              Navigator.of(context).pop(_controllerD.text.toString());
                                            }
                                            else {
                                              //Scaffold.of(context).showSnackBar(SnackBar(content: Text("Please Input into the fields!")));
                                            }
                                            //symptomsT = symptomsT + "\nDetails: " + question + " $symptomD";
                                            sSubmitted++;})],
                                      );
                                    }
                                  );
                                });
                                //SymptomDetailAlert();
                                symptom = _controller.text;
                                //Prompting(symptom);
                                //symptomsT = "Complication: " + symptom;
                                sSubmitted++;
                              }
                              else {
                                Scaffold.of(context).showSnackBar(SnackBar(content: Text("Please Input Something!")));
                              }
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              //Possible Complications
              Builder(
                builder: (context) => Padding(
                  padding: EdgeInsets.only(top:3, left: 3, right: 3, bottom: 7),
                  child: Row(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.assistant_photo, color: Colors.orange,size: 30,),
                        onPressed: () {
                          if (sSubmitted == 1) {
                            if (accepted == false) {
                              accepted = true;
                              showDialog(context: context, builder: (_) => AlertDialog(title: Text("Disclaimer", style: TextStyle(color: Colors.redAccent)),
                                content: Text("We are not medical professionals and only aim to suggest ways to improve your well-being. We will not take any responsibility for misconduct or advice given by our system", style: TextStyle(color: Colors.black45),),
                                actions: <Widget>[MaterialButton(elevation: 5, child: Text("Go", style: TextStyle(color: Colors.blue, fontSize: 22),),
                                    onPressed: () {Navigator.of(context).pop();
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => PossibleComp()));
                                    })],
                              ));
                            }
                            else {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => PossibleComp()));
                            }
                          }
                          else {
                            Scaffold.of(context).showSnackBar(SnackBar(content: Text("Input your symptoms first!")));
                          }
                        },
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: FlatButton(
                            child: Container(
                              alignment: Alignment.centerLeft,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[Padding(
                                    padding: EdgeInsets.only(top: 7, bottom: 3),
                                    child: Text("Complications", style: TextStyle(fontSize: 22, color: Colors.blue), textAlign: TextAlign.left,),
                                  ), Padding(
                                    padding: EdgeInsets.only(top: 3, bottom: 7),
                                    child: Text("A list of possible health implications", style: TextStyle(fontSize: 18,color: Colors.black45),textAlign: TextAlign.left,),
                                  )]),
                            ),
                            color: Colors.white,
                            onPressed: () {
                              if (sSubmitted >= 1) {
                                if (accepted == false) {
                                  accepted = true;
                                  showDialog(context: context, builder: (_) => AlertDialog(title: Text("Disclaimer", style: TextStyle(color: Colors.redAccent)),
                                    content: Text("We are not medical professionals and only aim to suggest ways to improve your well-being. We will not take any responsibility for misconduct or advice given by our system", style: TextStyle(color: Colors.black45),),
                                    actions: <Widget>[MaterialButton(elevation: 5, child: Text("Go", style: TextStyle(color: Colors.blue, fontSize: 22),),
                                        onPressed: () {Navigator.of(context).pop();
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (context) => PossibleComp()));
                                        })],
                                  ));
                                }
                                else {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => PossibleComp()));
                                }
                              }
                              else {
                                Scaffold.of(context).showSnackBar(SnackBar(content: Text("Input your symptoms first!")));
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              //Summary
              Builder(
                builder: (context) => Padding(
                  padding: EdgeInsets.only(top: 7, right: 3, left: 3, bottom: 7),
                  child: Row(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.assignment, color: Colors.green,size: 30,),
                        onPressed: () {
                          if (sSubmitted == 1) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => PossibleComp()));
                          }
                          else {
                            Scaffold.of(context).showSnackBar(SnackBar(content: Text("Input your symptoms first!")));
                          }
                        },
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 12.0),
                          child: FlatButton(
                            child: Container(
                              alignment: Alignment.centerLeft,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[Padding(
                                    padding: EdgeInsets.only(top: 7, bottom: 3),
                                    child: Text("Summary", style: TextStyle(fontSize: 22, color: Colors.blue), textAlign: TextAlign.left),
                                  ), Padding(
                                    padding: EdgeInsets.only(top: 3, bottom: 7),
                                    child: Text("A summary of your symptoms", style: TextStyle(fontSize: 18, color: Colors.black45), textAlign: TextAlign.left,),
                                  )]),
                            ),
                            color: Colors.white,
                            onPressed: () {
                              if (sSubmitted >= 1) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => Summary()));
                              }
                              else {
                                Scaffold.of(context).showSnackBar(SnackBar(content: Text("Input your symptoms first!")));
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              //Treatment
              Builder(
                builder: (context) => Padding(
                  padding: EdgeInsets.only(top:7.0, left: 3, right: 3, bottom: 7),
                  child: Row(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.announcement, color: Colors.blueAccent,size: 30,),
                        onPressed: () {
                          if (sSubmitted >= 1) {
                            if (accepted == false) {
                              accepted = true;
                              showDialog(context: context, builder: (_) => AlertDialog(title: Text("Disclaimer", style: TextStyle(color: Colors.redAccent)),
                                content: Text("We are not medical professionals and only aim to suggest ways to improve your well-being. We will not take any responsibility for misconduct or advice given by our system", style: TextStyle(color: Colors.black45),),
                                actions: <Widget>[MaterialButton(elevation: 5, child: Text("Go", style: TextStyle(color: Colors.blue, fontSize: 22),),
                                    onPressed: () {Navigator.of(context).pop();
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => Treatment()));
                                    })],
                              ));
                            }
                            else {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => Treatment()));
                            }
                          }
                          else {
                            Scaffold.of(context).showSnackBar(SnackBar(content: Text("Input your symptoms first!")));
                          }
                        },
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 12.0),
                          child: FlatButton(
                            child: Container(
                              alignment: Alignment.centerLeft,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[Padding(
                                    padding: EdgeInsets.only(top: 7, bottom: 3),
                                    child: Text("Treatment", style: TextStyle(fontSize: 22, color: Colors.blue), textAlign: TextAlign.left,),
                                  ), Padding(
                                    padding: EdgeInsets.only(top: 3, bottom: 7),
                                    child: Text("Treatment for the symptoms", style: TextStyle(fontSize: 18, color: Colors.black45), textAlign: TextAlign.left,),
                                  )]),
                            ),
                            color: Colors.white,
                            onPressed: () {
                              if (sSubmitted >= 1) {
                                if (accepted == false) {
                                  accepted = true;
                                  showDialog(context: context, builder: (_) => AlertDialog(title: Text("Disclaimer", style: TextStyle(color: Colors.redAccent)),
                                    content: Text("We are not medical professionals and only aim to suggest ways to improve your well-being. We will not take any responsibility for misconduct or advice given by our system", style: TextStyle(color: Colors.black45),),
                                    actions: <Widget>[MaterialButton(elevation: 5, child: Text("Go", style: TextStyle(color: Colors.blue, fontSize: 22),),
                                        onPressed: () {Navigator.of(context).pop();
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (context) => Treatment()));
                                        })],
                                  ));
                                }
                                else {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => Treatment()));
                                }
                              }
                              else {
                                Scaffold.of(context).showSnackBar(SnackBar(content: Text("Input your symptoms first!")));
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 20.0, right: 20, left: 20, bottom: 3.0),
                child: MaterialButton(
                  height: 50,
                  color: Colors.lightBlue,
                  textColor: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.book),
                      Text("Book Appointment", style: TextStyle(fontSize: 22),),
                    ],
                  ),
                  onPressed: () {
                    botBurl();
                  },
                ),
              ),
              SafeArea(child: Image.asset("assets/TedMed Header Image.png", fit: BoxFit.fitWidth, height: 250, scale: 1)),
              Padding(
                padding: const EdgeInsets.all(7.0),
                child: Text("Search:", style: TextStyle(color: Colors.blue, fontSize: 25, fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding: const EdgeInsets.all(7.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 3, right: 20, left: 20, bottom: 3.0),
                      child: MaterialButton(
                        height: 50,
                        color: Colors.blue,
                        textColor: Colors.white,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Icon(Icons.clear_all, size: 27,),
                            ),
                            Text("Symptoms", style: TextStyle(fontSize: 22)),
                          ],
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => SymptomSearch()));
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 3, right: 20, left: 20, bottom: 3.0),
                      child: MaterialButton(
                        height: 50,
                        color: Colors.lightGreen,
                        textColor: Colors.white,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Icon(Icons.recent_actors, size: 27,),
                            ),
                            Text("Doctors", style: TextStyle(fontSize: 22),),
                          ],
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => DoctorSearch()));
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(7.0),
                child: Text("Learn:", style: TextStyle(color: Colors.green, fontSize: 25, fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding: const EdgeInsets.only(top:7.0, left: 7, right: 7, bottom: 50),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 3.0, right: 20, left: 20, bottom: 3.0),
                      child: MaterialButton(
                        height: 50,
                        color: Colors.orangeAccent,
                        textColor: Colors.white,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.data_usage),
                            Text("Analyse Diagnosis", style: TextStyle(fontSize: 22),),
                          ],
                        ),
                        onPressed: () {
                          //TODO add bot link
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 3.0, right: 20, left: 20, bottom: 3.0),
                      child: MaterialButton(
                        height: 50,
                        color: Colors.deepOrange,
                        textColor: Colors.white,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.library_books),
                            Text("Read", style: TextStyle(fontSize: 22)),
                          ],
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Learn()));
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  //detail prompting function(algorithm)
  void Prompting (String s) {
    debugPrint("Prompting called");
    String delim = " ";
    String noSpace = s.replaceAll(delim, "");
    String Ls = noSpace.toLowerCase();

    String tmp = "";
    tmp = s.split(delim).toString();

    for (int i = 0; i < s.length; i++) {
      for (int j = i + 1; j < s.length + 1; j++) {
        if (j == s.length) {
          j = 0;
        }
        tmp = Ls.substring(i, j);
        debugPrint(tmp);
        debugPrint(i.toString());
        if (tmp.compareTo("slash") == 0 || s.compareTo("cut") == 0) {
          debugPrint("its a cut");
          question = "How wide is the cut? (cm)";
          question1 = "When did you get the cut? (hours)";
          question2 = "How long has it been bleeding?";
          treatment = "Treatment: Wash wound and bandage";
          SymptomDetailAlert();
          _visibility = !_visibility;
          //break;
        }
        else if (s.compareTo("chest pain") == 0 || s.compareTo("heart pain") == 0) {
          debugPrint("its heart disease");
          question = "How old are you?";
          question1 = "On a scale of 1-4 how painful is the chest pain? (1 - least painful)";
          question2 = "How long have you been experiencing this? (days)";
          treatment = "Treatment: Consult with doctor";
          SymptomDetailAlert();
          _visibility = !_visibility;
          //break;
        }
        else if (s.compareTo("lump") == 0 || s.compareTo("bump") == 0) {
          debugPrint("its a lump");
          question = "What is the length of the lump?";
          question1 = "On a scale of 1-10 how painful is the lump? (1 - least painful)";
          question2 = "Is the lump movable or stationary?";
          SymptomDetailAlert();
          _visibility = !_visibility;
          //break;
        }
        else {
          debugPrint("not understood");
          symptomsT = "Symptom Not Recognised! Try being more specific!";
          treatment = "Possible Complications: Heart Disease";
          _visibility = !_visibility;
        }
      }
    }
  }
}

Widget questionW(String q, final c) {
  return TextField(
    maxLength: 3,
    decoration: InputDecoration(
      counterText: "",
      hintText: "$q",
      hintStyle: TextStyle(color: Colors.blue),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.green, width: 3),
          borderRadius: BorderRadius.all(Radius.circular(12))
      ),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue, width: 5),
          borderRadius: BorderRadius.all(Radius.circular(33))
      ),
    ),
    controller: c,
    keyboardType: TextInputType.number,
    inputFormatters: <TextInputFormatter>[
      FilteringTextInputFormatter.digitsOnly
      // DEPRECIATED VERSION: WhitelistingTextInputFormatter.digitsOnly,
    ],
  );
}

class SymptomDetailAlert extends StatefulWidget {
  @override
  _SymptomDetailAlert createState() => _SymptomDetailAlert();
}

class _SymptomDetailAlert extends State<SymptomDetailAlert> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(title: Text("Additional Details", style: TextStyle(color: Colors.blue)),
      content: Container(
        //height: 100,
        child: Column(children: [
          DropdownButton<String>(
            value: dropdownValue,
            icon: Icon(Icons.arrow_drop_down),
            iconSize: 24,
            elevation: 16,
            style: TextStyle(color: Colors.blue, fontSize: 18),
            onChanged: (String data) {
              setState(() {
                dropdownValue = data;
              });
            },
            items: spinnerItems.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          TextField(
            decoration: InputDecoration(
              hintText: "$question",
              hintStyle: TextStyle(color: Colors.blue),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                  borderRadius: BorderRadius.all(Radius.circular(12))
              ),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.orangeAccent),
                  borderRadius: BorderRadius.all(Radius.circular(33))
              ),
              prefixIcon: Icon(Icons.details, color: Colors.blue,),
            ),
            controller: _controllerD,
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly,
            ],
          ),
          TextField(
            decoration: InputDecoration(
              hintText: "$question1",
              hintStyle: TextStyle(color: Colors.blue),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.orange),
                  borderRadius: BorderRadius.all(Radius.circular(12))
              ),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                  borderRadius: BorderRadius.all(Radius.circular(33))
              ),
              prefixIcon: Icon(Icons.details, color: Colors.blue,),
            ),
            controller: _controllerD,
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
              // OLD VERSION: WhitelistingTextInputFormatter.digitsOnly,
            ],
          ),
          TextField(
            decoration: InputDecoration(
              hintText: "$question2",
              hintStyle: TextStyle(color: Colors.blue),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                  borderRadius: BorderRadius.all(Radius.circular(12))
              ),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.orangeAccent),
                  borderRadius: BorderRadius.all(Radius.circular(33))
              ),
              prefixIcon: Icon(Icons.details, color: Colors.blue,),
            ),
            controller: _controllerD,
          ),
        ]),
      ),
      actions: <Widget>[ MaterialButton(elevation: 3, child: Text("Submit", style: TextStyle(color: Colors.blue)),
          onPressed: () {Navigator.of(context).pop(_controllerD.text.toString());
          symptomD = _controllerD.text;
          symptomsT = symptomsT + "\nDetails: " + question + " $symptomD";
          sSubmitted++;})
      ],
    );
    /*
      AlertDialog(
      title: Text("Additional Details", style: TextStyle(color: Colors.blue)),
      content: Column(children: [
        TextField(
          decoration: InputDecoration(
            hintText: "$question",
            hintStyle: TextStyle(color: Colors.blue),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue),
                borderRadius: BorderRadius.all(Radius.circular(33))
            ),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.redAccent),
                borderRadius: BorderRadius.all(Radius.circular(33))
            ),
            prefixIcon: Icon(Icons.details, color: Colors.blue,),
          ),
          controller: _controllerD,
        ),
        CheckboxListTile(title: Text("Dizziness(Nauseous)"), value: _checked, onChanged: (bool value) {setState(() {
          _checked = value;
        });}),
        CheckboxListTile(title: Text("Shortness Of Breath"), value: _checked1, onChanged: (bool value) {setState(() {
          _checked1 = value;
        });}),
        CheckboxListTile(title: Text("Dry Cough"), value: _checked2, onChanged: (bool value) {setState(() {
          _checked2 = value;
        });})]),
      actions: <Widget>[MaterialButton(elevation: 5, child: Text("Submit", style: TextStyle(color: Colors.blue),),
          onPressed: () {Navigator.of(context).pop(_controllerD.text.toString());
          symptomD = _controllerD.text;
          symptomsT = symptomsT + "\nDetails: " + question + " $symptomD";
          sSubmitted++;})],
    );

       */
  }
}

class PossibleComp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Possible Health Complications", style: TextStyle(color: Colors.white))
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Complication: $symptom", style: TextStyle(color: Colors.white,fontSize: 25, fontWeight: FontWeight.bold),),
          ),
          complicationCard("Arrhythmia", "Heart rhythm abnormality"),
          complicationCard("Atherosclerosis", "hardening of the arteries"),
          complicationCard("Cardiomyopathy", "heart's muscles to harden or grow weak"),
          complicationCard("Coronary artery disease (CAD)", "buildup of plaque in the heart’s arteries"),
          complicationCard("Heart infections", "caused by bacteria, viruses, or parasites"),
        ],
      )
    );
  }
}

Widget complicationCard (String name, String field) {
  return Padding(
    padding: const EdgeInsets.all(3.0),
    child: Card (
      color: Colors.white,
      child: Row(
        //mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("$name", style: TextStyle(color: Colors.blue, fontSize: 18), textAlign: TextAlign.left,),
                  Text("$field", style: TextStyle(color: Colors.black45, fontSize: 15), textAlign: TextAlign.left,)
                ],),
            ),
          ),
          FlatButton(
            color: Colors.white,
            child: Text("More Info", style: TextStyle(color: Colors.orange)),
            onPressed: () {

            },
          ),
          Expanded(
            child: FlatButton(
              color: Colors.white,
              child: Text("Book Specialist", style: TextStyle(color: Colors.blue)),
              onPressed: () {

              },
            ),
          ),
        ],
      ),
    ),
  );
}

class Summary extends StatelessWidget {
  int maxHeartRate = 220 - int.parse(symptomA);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
            title: Text("Possible Health Complications", style: TextStyle(color: Colors.white))
        ),
        body: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RichText(
                text: TextSpan(text: "Health Complication\n", style: TextStyle(color: Colors.orange, fontSize: 20),
                  children: <TextSpan>[
                    TextSpan(text: "$symptom", style: TextStyle(color: Colors.blue, fontSize: 30, fontWeight: FontWeight.bold)),
                  ],
                ),
              )
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Additional Details:", style: TextStyle(color: Colors.orange, fontSize: 20),),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[Text("Sex: $dropdownValue\n", style: TextStyle(color: Colors.lightBlue, fontSize: 20, fontWeight: FontWeight.bold)),
                  Text("Age: $symptomA\n", style: TextStyle(color: Colors.lightBlue, fontSize: 20, fontWeight: FontWeight.bold)),
                  Text("Pain Scale: $rating / 4\n", style: TextStyle(color: Colors.lightBlue, fontSize: 20,fontWeight: FontWeight.bold)),
                  Text("Calculated Maximum Heart Rate: $maxHeartRate BPM\n", style: TextStyle(color: Colors.lightBlue, fontSize: 20,fontWeight: FontWeight.bold)),
                  Text("Blood Sugar Level: $symptomsT mg/dL \n", style: TextStyle(color: Colors.lightBlue, fontSize: 20,fontWeight: FontWeight.bold)),
                  Text("Cholesterol Level: $symptomC mmHg\n", style: TextStyle(color: Colors.lightBlue, fontSize: 20,fontWeight: FontWeight.bold)),],
              ),
            )
          ],
        )
    );
  }
}

class Treatment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
            title: Text("Possible Health Complications", style: TextStyle(color: Colors.white))
        ),
        body: ListView(
          children: <Widget>[
            Text("$symptom", style: TextStyle(color: Colors.orange,fontSize: 30),),
            Text("$symptomsT", style: TextStyle(color: Colors.grey),)
          ],
        )
    );
  }
}

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SafeArea(
        child: Drawer(child:
        ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text("User user"),
              accountEmail: Text("user@gmail.com"),
              currentAccountPicture: CircleAvatar(
                backgroundColor:
                Theme.of(context).platform == TargetPlatform.android
                    ? Colors.lightBlueAccent
                    : Colors.white,
                child: Text(
                  "U",
                  style: TextStyle(fontSize: 40.0),
                ),
              ),
            ),
            ListTile(leading: Icon(Icons.home), trailing: Icon(Icons.arrow_right), title: Text("Main", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue, fontSize: 24)),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (BuildContext context) => MyApp()));
                }),
            ListTile(leading: Icon(Icons.assessment), trailing: Icon(Icons.arrow_right),title: Text("Learn", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.orange, fontSize: 24)),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (BuildContext context) => Learn()));
                }),
            ListTile(leading: Icon(Icons.info), trailing: Icon(Icons.arrow_right), title: Text("About", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green, fontSize: 24)),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (BuildContext context) => About()));
                }),
          ],
        ),
        ),
      ),
        backgroundColor: Colors.black,
        appBar: AppBar(
            title: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("About Us", style: TextStyle(color: Colors.white)),
            )
        ),
        body: Container(
          child: ListView(
            children: <Widget>[
              SafeArea(child: Image.asset("assets/TedMed Header Image.png", fit: BoxFit.fitWidth, height: 200, scale: 1)),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("We hope you are enjoying this telemedicine app! If you have in issues/suggestions/feedback you can fill out this short survey!", style: TextStyle(color: Colors.orange, fontSize: 22, fontWeight: FontWeight.bold),),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: MaterialButton(
                  color: Colors.blue,
                  child: Text("survey", style: TextStyle(color: Colors.white),),
                  onPressed: null
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("TedMed Team: Emmanuel Carter, Ming Hong, Airin, Krish, Mritika and Carolyn", style: TextStyle(color: Colors.blue, fontSize: 22),),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Disclaimer: We are not medical professionals and only aim to suggest ways to improve your well-being. We will not take any responsibility for misconduct or advice given by our system", style: TextStyle(color: Colors.redAccent, fontSize: 12, fontWeight: FontWeight.bold),),
              ),
            ],
          ),
        )
    );
  }
}

class DoctorSearch extends StatelessWidget {
  final doc_search_c = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
            title: Text("Doctor Search", style: TextStyle(color: Colors.white))
        ),
        body: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(7.0),
              child: TextField(
                style: TextStyle(color: Colors.white, fontSize: 22),
                decoration: InputDecoration(
                  hintText: "Search",
                  hintStyle: TextStyle(color: Colors.white, fontSize: 22),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 3),
                      borderRadius: BorderRadius.all(Radius.circular(12))
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.orangeAccent, width: 4),
                      borderRadius: BorderRadius.all(Radius.circular(33))
                  ),
                  prefixIcon: Icon(Icons.search, color: Colors.blue, size: 39),
                ),
                controller: doc_search_c,
              ),
            ),
            doctorCard("Dr. Pearl Lee", "Cancer Research Specialist"),
            doctorCard("Dr. Pearl Lee", "Cancer Research Specialist"),
            doctorCard("Dr. Pearl Lee", "Cancer Research Specialist"),
            doctorCard("Dr. Pearl Lee", "Cancer Research Specialist"),
          ],
        )
    );
  }
}

Widget doctorCard (String name, String field) {
  return Padding(
    padding: const EdgeInsets.all(3.0),
    child: Card (
      color: Colors.white,
      child: Row(
        //mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.person),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("$name", style: TextStyle(color: Colors.blue, fontSize: 20), textAlign: TextAlign.left,),
                Text("$field", style: TextStyle(color: Colors.black45, fontSize: 15), textAlign: TextAlign.left,)
              ],),
          ),
          FlatButton(
            color: Colors.white,
            child: Text("More Info", style: TextStyle(color: Colors.orange)),
            onPressed: () {

            },
          ),
          Expanded(
            child: FlatButton(
              color: Colors.white,
              child: Text("Book", style: TextStyle(color: Colors.blue)),
              onPressed: () {

              },
            ),
          ),
        ],
      ),
    ),
  );
}

class SymptomSearch extends StatelessWidget {
  final search_c = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
            title: Text("Symptom Search", style: TextStyle(color: Colors.white))
        ),
        body: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(7.0),
              child: TextField(
                style: TextStyle(color: Colors.white, fontSize: 22),
                decoration: InputDecoration(
                  hintText: "Search",
                  hintStyle: TextStyle(color: Colors.white, fontSize: 22),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 3),
                      borderRadius: BorderRadius.all(Radius.circular(12))
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.orangeAccent, width: 4),
                      borderRadius: BorderRadius.all(Radius.circular(33))
                  ),
                  prefixIcon: Icon(Icons.search, color: Colors.blue, size: 39),
                ),
                controller: search_c,
              ),
            ),
          ],
        )
    );
  }
}

class Account extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: SafeArea(
          child: Drawer(child:
          ListView(
            children: [
              UserAccountsDrawerHeader(
                accountName: Text("User user"),
                accountEmail: Text("user@gmail.com"),
                currentAccountPicture: CircleAvatar(
                  backgroundColor:
                  Theme.of(context).platform == TargetPlatform.android
                      ? Colors.lightBlueAccent
                      : Colors.white,
                  child: Text(
                    "U",
                    style: TextStyle(fontSize: 40.0),
                  ),
                ),
              ),
              ListTile(leading: Icon(Icons.home), trailing: Icon(Icons.arrow_right), title: Text("Main", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue, fontSize: 24)),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (BuildContext context) => MyApp()));
                  }),
              ListTile(leading: Icon(Icons.assessment), trailing: Icon(Icons.arrow_right),title: Text("Learn", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.orange, fontSize: 24)),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (BuildContext context) => Learn()));
                  }),
              ListTile(leading: Icon(Icons.info), trailing: Icon(Icons.arrow_right), title: Text("About", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green, fontSize: 24)),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (BuildContext context) => About()));
                  }),
            ],
          ),
          ),
        ),
        backgroundColor: Colors.black,
        appBar: AppBar(
            title: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("User user", style: TextStyle(color: Colors.white)),
            )
        ),
        body: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Your Account Details", style: TextStyle(color: Colors.orange, fontSize: 22, fontWeight: FontWeight.bold),),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 3.0, right: 20, left: 20, bottom: 3.0),
              child: MaterialButton(
                height: 50,
                color: Colors.blue,
                textColor: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.info),
                    Text("Your Info", style: TextStyle(fontSize: 22),),
                  ],
                ),
                onPressed: () {
                  //TODO add bot link
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 3.0, right: 20, left: 20, bottom: 3.0),
              child: MaterialButton(
                height: 50,
                color: Colors.deepOrangeAccent,
                textColor: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.data_usage),
                    Text("Diagnosis History", style: TextStyle(fontSize: 22),),
                  ],
                ),
                onPressed: () {
                  //TODO add bot link
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 3.0, right: 20, left: 20, bottom: 3.0),
              child: MaterialButton(
                height: 50,
                color: Colors.green,
                textColor: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.payment),
                    Text("Payment Info", style: TextStyle(fontSize: 22),),
                  ],
                ),
                onPressed: () {
                  //TODO add bot link
                },
              ),
            ),
          ],
        )
    );
  }
}
