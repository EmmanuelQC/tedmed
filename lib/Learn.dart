import 'package:flutter/material.dart';
import 'package:tedmed/mentalHealth_quiz.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'medical_vocab_quiz.dart';
import 'main.dart';

//General Bool
bool basic = false;

int Points = 0;

//Learn Screen
class Learn extends StatelessWidget {

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
            title: Text("Learn", style: TextStyle(color: Colors.white))
        ),
        body: ListView(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Colors.amber,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Health Points: $Points",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),
              ),
              alignment: Alignment.topCenter,
            ),
            Column(
              children: <Widget>[
                //first row
                Padding(
                  padding: EdgeInsets.only(top:12.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: RaisedButton(
                          color: Colors.black54,
                          child: Column(
                            children: <Widget>[
                              Hero(tag: "g", child: SafeArea(child: Image.asset("assets/GeneralHeaderB.png", fit: BoxFit.fitWidth, height: 95, scale: 1))),
                              Container(width: 169, decoration: BoxDecoration(
                                color: Colors.blue,
                              ),child: Padding(padding: EdgeInsets.all(12),child: Text("General", style: TextStyle(color: Colors.white, fontSize: 20,fontWeight: FontWeight.bold), textAlign: TextAlign.center,))),
                            ],
                          ),
                          onPressed: () {
                            //Points += 100;
                            print(Points);
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => General()));
                          },
                        ),
                      ),
                      Expanded(
                        child: RaisedButton(
                          color: Colors.black54,
                          child: Column(
                            children: <Widget>[
                              SafeArea(child: Image.asset("assets/MentalHealthHeader.png", fit: BoxFit.fitWidth, height: 95, scale: 1)),
                              Container(width: 169, decoration: BoxDecoration(
                                color: Colors.orange,
                              ),child: Padding(padding: EdgeInsets.all(12),child: Text("Mental Health", style: TextStyle(color: Colors.white, fontSize: 20,fontWeight: FontWeight.bold), textAlign: TextAlign.center,))),
                            ],
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => MentalHealth()));
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                //second row
                Padding(
                  padding: EdgeInsets.only(top:12.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: RaisedButton(
                          color: Colors.black54,
                          child: Column(
                            children: <Widget>[
                              SafeArea(child: Image.asset("assets/HAHeader.png", fit: BoxFit.fitWidth, height: 95, scale: 1)),
                              Container(width: 169, decoration: BoxDecoration(
                                color: Colors.green,
                              ),child: Padding(padding: EdgeInsets.all(12),child: Text("Human Anatomy", style: TextStyle(color: Colors.white, fontSize: 20,fontWeight: FontWeight.bold), textAlign: TextAlign.center,))),
                            ],
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => HumanA()));
                          },
                        ),
                      ),
                      Expanded(
                        child: RaisedButton(
                          color: Colors.black54,
                          child: Column(
                            children: <Widget>[
                              SafeArea(child: Image.asset("assets/RedFlagHeader.png", fit: BoxFit.fitWidth, height: 95, scale: 1)),
                              Container(width: 169, decoration: BoxDecoration(
                                color: Colors.red,
                              ),child: Padding(padding: EdgeInsets.all(12),child: Text("Red Flag Symptoms", style: TextStyle(color: Colors.white, fontSize: 20,fontWeight: FontWeight.bold), textAlign: TextAlign.center,))),
                            ],
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => RedFlag()));
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top:20, left: 20, right: 20),
                  child: MaterialButton(
                    color: Colors.blueAccent,
                    child: Row(
                      children: <Widget>[Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.announcement, color: Colors.white),
                      ), Text("COVID-19 Reminders", style: TextStyle(color: Colors.white, fontSize: 18),)],
                    ),
                    onPressed: () {
                      covidurl();
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top:3.0, left: 20, right: 20),
                  child: MaterialButton(
                    color: Colors.deepOrange,
                    child: Row(
                      children: <Widget>[Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.question_answer, color: Colors.white),
                      ), Text("Random Health Quiz!", style: TextStyle(color: Colors.white, fontSize: 18),)],
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => medical_v_quiz()));
                    },
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: MaterialButton(
                    color: Colors.black,
                    child: Text("Doctor is now available"),
                    onPressed: () {
                      showDialog(context: context, builder: (_) => AlertDialog(title: Text("Your Doctor is Available!", style: TextStyle(color: Colors.blue)),
                        content: Text("The Doctor you booked is now waiting to see you! \n\nPlease join the call in the next 5 minutes!", style: TextStyle(color: Colors.black45),),
                        actions: <Widget>[MaterialButton(elevation: 5, child: Text("Call", style: TextStyle(color: Colors.blue, fontSize: 22),),
                            onPressed: () {Navigator.of(context).pop();
                            Navigator.push(context,
                            MaterialPageRoute(builder: (context) => MyApp()));
                            })],
                      ));
                    },
                  ),
                )
              ],
            ),
          ],
        )
    );
  }
}

//covid Screen
class covid extends StatelessWidget {

  //TODO test vocab, test common infections, first aid
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
            title: Text("Learn", style: TextStyle(color: Colors.white))
        ),
        body: ListView(
          children: <Widget>[
            SafeArea(child: Image.asset("assets/TedMed Icon App.png", fit: BoxFit.fitWidth)),
          ],
        )
    );
  }
}

//General Screen
class General extends StatelessWidget {

  //TODO test vocab, test common infections, first aid
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
            title: Text("Learn", style: TextStyle(color: Colors.white))
        ),
        body: ListView(
          children: <Widget>[
            Hero(tag: "g", child: SafeArea(child: Image.asset("assets/GeneralHeaderB.png", fit: BoxFit.fitWidth))),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("General Medical Knowledge", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24), textAlign: TextAlign.left),
            ),
            //Education options
            Padding(
              padding: EdgeInsets.all(12),
              child: RaisedButton(
                color: Colors.black54,
                child: Container(width: double.infinity, decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Padding(padding: const EdgeInsets.all(8.0), child: Icon(Icons.check_box_outline_blank, color: Colors.white70),),
                            Column(children: [Padding(padding: EdgeInsets.all(12), child: Text("Basics", style: TextStyle(color: Colors.white, fontSize: 22,fontWeight: FontWeight.bold), textAlign: TextAlign.left))])],
                        ),
                        Padding(padding: EdgeInsets.all(12),child: Text("First aid, treating wounds, common infections etc.", style: TextStyle(color: Colors.white70, fontSize: 16), textAlign: TextAlign.left,)),
                      ],
                    )),
                onPressed: () {
                  Points += 50;
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Basics()));
                },
              ),
            ),

            Padding(
              padding: EdgeInsets.all(12),
              child: RaisedButton(
                color: Colors.black54,
                child: Container(width: double.infinity, decoration: BoxDecoration(
                  color: Colors.orange,
                ),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Padding(padding: const EdgeInsets.all(8.0), child: Icon(Icons.check_box_outline_blank, color: Colors.white70),),
                            Column(children: [Padding(padding: EdgeInsets.all(12), child: Text("Medical Vocabulary", style: TextStyle(color: Colors.white, fontSize: 22,fontWeight: FontWeight.bold), textAlign: TextAlign.left))])],
                        ),
                        Padding(padding: EdgeInsets.all(12),child: Text("Learn the key words that doctors use to better understand them", style: TextStyle(color: Colors.white70, fontSize: 16), textAlign: TextAlign.left,)),
                      ],
                    )),
                onPressed: () {
                  Points += 30;
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Vocab()));
                },
              ),
            ),

            Padding(
              padding: EdgeInsets.all(12),
              child: RaisedButton(
                color: Colors.black54,
                child: Container(width: double.infinity, decoration: BoxDecoration(
                  color: Colors.green,
                ),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Padding(padding: const EdgeInsets.all(8.0), child: Icon(Icons.check_box_outline_blank, color: Colors.white70),),
                            Column(children: [Padding(padding: EdgeInsets.all(12), child: Text("Common Infections", style: TextStyle(color: Colors.white, fontSize: 22,fontWeight: FontWeight.bold), textAlign: TextAlign.left))])],
                        ),
                        Padding(padding: EdgeInsets.all(12),child: Text("What to do if you have a cold, the flu and other infections?", style: TextStyle(color: Colors.white70, fontSize: 16), textAlign: TextAlign.left,)),
                      ],
                    )),
                onPressed: () {
                  Points += 50;
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => medical_v_quiz()));
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(12),
              child: RaisedButton(
                color: Colors.black54,
                child: Container(width: double.infinity, decoration: BoxDecoration(
                  color: Colors.red,
                ),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Padding(padding: const EdgeInsets.all(8.0), child: Icon(Icons.check_box_outline_blank, color: Colors.white70),),
                            Column(children: [Padding(padding: EdgeInsets.all(12), child: Text("Prescription drugs", style: TextStyle(color: Colors.white, fontSize: 22,fontWeight: FontWeight.bold), textAlign: TextAlign.left))])],
                        ),
                        Padding(padding: EdgeInsets.all(12),child: Text("Common drugs, their treatment and possible side effects", style: TextStyle(color: Colors.white70, fontSize: 16), textAlign: TextAlign.left,)),
                      ],
                    )),
                onPressed: () {
                  Points += 50;
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => medical_v_quiz()));
                },
              ),
            ),

          ],
        )
    );
  }

  void _addPoints (int n) {

  }
}

//MH Screen
class MentalHealth extends StatelessWidget {

  //TODO test vocab, test common infections, first aid
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
            title: Text("Learn", style: TextStyle(color: Colors.white))
        ),
        body: ListView(
          children: <Widget>[
            SafeArea(child: Image.asset("assets/MentalHealthHeader.png", fit: BoxFit.fitWidth)),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Mental Health", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24), textAlign: TextAlign.left),
            ),

            //Education options
            Padding(
              padding: EdgeInsets.all(12),
              child: RaisedButton(
                color: Colors.black54,
                child: Container(width: double.infinity, decoration: BoxDecoration(
                  color: Colors.orange,
                ),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Padding(padding: const EdgeInsets.all(8.0), child: Icon(Icons.check_box_outline_blank, color: Colors.white70),),
                            Column(children: [Padding(padding: EdgeInsets.all(12), child: Text("Mental Health", style: TextStyle(color: Colors.white, fontSize: 22,fontWeight: FontWeight.bold), textAlign: TextAlign.left))])],
                        ),
                        Padding(padding: EdgeInsets.all(12),child: Text("Are you mentally stable? What you can do to treat it.", style: TextStyle(color: Colors.white70, fontSize: 16), textAlign: TextAlign.left,)),
                      ],
                    )),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => mentalHealth_quiz()));
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top:7.0, left: 25, right:25, bottom: 7),
              child: MaterialButton(
                height: 50,
                color: Colors.blue,
                child: Text("More Quizzes on Mental Health", style: TextStyle(color: Colors.white, fontSize: 20)),
                onPressed: () {
                  MHurl();
                }
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top:7.0, left: 25, right:25, bottom: 7),
              child: MaterialButton(
                height: 50,
                color: Colors.deepOrangeAccent,
                child: Text("Mental Health Assessment", style: TextStyle(color: Colors.white, fontSize: 20)),
                onPressed: () {
                  MHurl();
                }
              ),
            ),
          ],
        )
    );
  }
}

//HA Screen
class HumanA extends StatelessWidget {

  //TODO test vocab, test common infections, first aid
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
            title: Text("Learn", style: TextStyle(color: Colors.white))
        ),
        body: ListView(
          children: <Widget>[
            SafeArea(child: Image.asset("assets/HAHeader.png", fit: BoxFit.fitWidth)),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Human Anatomy", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24), textAlign: TextAlign.left),
            ),

            Padding(
              padding: EdgeInsets.all(12),
              child: RaisedButton(
                color: Colors.black54,
                child: Container(width: double.infinity, decoration: BoxDecoration(
                  color: Colors.green,
                ),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Padding(padding: const EdgeInsets.all(8.0), child: Icon(Icons.check_box_outline_blank, color: Colors.white70),),
                            Column(children: [Padding(padding: EdgeInsets.all(12), child: Text("Human Anatomy", style: TextStyle(color: Colors.white, fontSize: 22,fontWeight: FontWeight.bold), textAlign: TextAlign.left))])],
                        ),
                        Padding(padding: EdgeInsets.all(12),child: Text("How well do you know the human body?", style: TextStyle(color: Colors.white70, fontSize: 16), textAlign: TextAlign.left,)),
                      ],
                    )),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => medical_v_quiz()));
                },
              ),
            ),
          ],
        )
    );
  }
}

//RF Screen
class RedFlag extends StatelessWidget {

  //TODO test vocab, test common infections, first aid
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
            title: Text("Learn", style: TextStyle(color: Colors.white))
        ),
        body: ListView(
          children: <Widget>[
            SafeArea(child: Image.asset("assets/RedFlagHeader.png", fit: BoxFit.fitWidth)),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Red Flag Symptoms", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24), textAlign: TextAlign.left),
            ),

            Padding(
              padding: EdgeInsets.all(12),
              child: RaisedButton(
                color: Colors.black54,
                child: Container(width: double.infinity, decoration: BoxDecoration(
                  color: Colors.red,
                ),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Padding(padding: const EdgeInsets.all(8.0), child: Icon(Icons.check_box_outline_blank, color: Colors.white70),),
                            Column(children: [Padding(padding: EdgeInsets.all(12), child: Text("Red Flag Symptoms", style: TextStyle(color: Colors.white, fontSize: 22,fontWeight: FontWeight.bold), textAlign: TextAlign.left))])],
                        ),
                        Padding(padding: EdgeInsets.all(12),child: Text("Can you detect a stroke, heart disease and choking. What do you do?", style: TextStyle(color: Colors.white70, fontSize: 16), textAlign: TextAlign.left,)),
                      ],
                    )),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => medical_v_quiz()));
                },
              ),
            ),
          ],
        )
    );
  }
}

//Basics Screen
class Basics extends StatelessWidget {
  var scrollDirection = Axis.horizontal;
  final controller = PageController(
      initialPage: 0
  );

  //TODO test vocab, test common infections, first aid
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
            title: Text("Basic Medical Knowledge", style: TextStyle(color: Colors.white))
        ),
        body: PageView(
          controller: controller,
          scrollDirection: scrollDirection,
          physics: BouncingScrollPhysics(),
          pageSnapping: true,
          children: <Widget>[
            Container(
              color: Colors.black,
              child: ListView(
                children: <Widget>[
                  SafeArea(child: Image.asset("assets/BasicsHeader.png", fit: BoxFit.fitWidth)),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("First Aid", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24), textAlign: TextAlign.left),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RichText(
                        text: TextSpan(text: "Learning first aid is all about the ", style: TextStyle(color: Colors.orange, fontSize: 20),
                          children: <TextSpan>[
                            TextSpan(text: "3 P's: preserve life, prevent deterioration, promote recovery.", style: TextStyle(color: Colors.blue, fontSize: 22)),
                            TextSpan(text: " This information will equip you with the knowledge to perform first aid on your self and others"),
                          ],
                        ),
                      )
                  ),

                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RichText(
                        text: TextSpan(text: "Items To Cover:\n", style: TextStyle(color: Colors.orange, fontSize: 20, fontWeight: FontWeight.bold),
                          children: <TextSpan>[
                            TextSpan(text: "-Cardiopulmonary resuscitation (CPR)\n-First Aid Cuts/Scrapes\n-First Aid for Sprains", style: TextStyle(color: Colors.blue, fontSize: 22)),
                          ],
                        ),
                      )
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MaterialButton(
                        color: Colors.orange,
                        child: Text("More On First Aid", style: TextStyle(color: Colors.white)),
                        onPressed: () {
                          FAurl();
                        }
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text("Swipe Right", style: TextStyle(color: Colors.white, fontSize: 20),),
                        Icon(Icons.arrow_forward, color: Colors.blue,)
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.black,
              child: ListView(
                children: <Widget>[
                  SafeArea(child: Image.asset("assets/CPR_info.jpg", fit: BoxFit.fitWidth)),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RichText(
                        text: TextSpan(text: "Cardiac Arrest:\n", style: TextStyle(color: Colors.green, fontSize: 24),
                          children: <TextSpan>[
                            TextSpan(text: "A cardiac arrest is when a persons heart stops beating, knowing how to perform CPR can save someones life\n\n1. Call the ambulance (eg. 911) \n2. Immediately start chest compressions. Compress hard and fast in the center of the chest\n3. If trained user chest compressions and rescue breathing\n", style: TextStyle(color: Colors.blue, fontSize: 22)),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MaterialButton(
                        color: Colors.orange,
                        child: Text("More On CPR", style: TextStyle(color: Colors.white)),
                        onPressed: () {
                          CPRurl();
                        }
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.black,
              child: ListView(
                children: <Widget>[
                  SafeArea(child: Image.asset("assets/cutAid.png", fit: BoxFit.fitWidth, )),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Cuts or Scrapes", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24), textAlign: TextAlign.left),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RichText(
                          text: TextSpan(text: "What to do:\n", style: TextStyle(color: Colors.green, fontSize: 22),
                            children: <TextSpan>[
                              TextSpan(text: "1. Wash your hands \n2. Stop the bleeding(apply gentle pressure with clean bandage/elevate wound) \n3. Clean wound and rinse with water\n4. Apply antibiotics or alcohol\n5. Cover wound with bandage", style: TextStyle(color: Colors.blue, fontSize: 22)),
                            ],
                          ),
                        )
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MaterialButton(
                        color: Colors.orange,
                        child: Text("More On Treating Wounds", style: TextStyle(color: Colors.white)),
                        onPressed: () {
                          cuturl();
                        }
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.black,
              child: ListView(
                children: <Widget>[
                  SafeArea(child: Image.asset("assets/Sprain_info.jpeg", fit: BoxFit.fitWidth)),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("First Aid for Sprains", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24), textAlign: TextAlign.left),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RichText(
                        text: TextSpan(text: "What to do:\n", style: TextStyle(color: Colors.green, fontSize: 22),
                          children: <TextSpan>[
                            TextSpan(text: "To treat a sprain use R.I.C.E\nR - Rest. Do not continue in activities that causes pain, swelling or discomfort  \nI -  Ice the area immediately by either using an ice pack or a bath a water and ice for 15-20 minutes\nC - Compress the area to reduce swelling with an elastic bandage until swelling stops. Ensure it is not too tight to allow circulation.\nE - Elevate injured area above the level or your heart, allowing gravity to reduce swelling", style: TextStyle(color: Colors.blue, fontSize: 18)),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MaterialButton(
                        color: Colors.orange,
                        child: Text("More On Sprains", style: TextStyle(color: Colors.white)),
                        onPressed: () {
                          Sprainurl();
                        }
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MaterialButton(
                      color: Colors.blue,
                      child: Text("Take the quiz!", style: TextStyle(color: Colors.white),),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => medical_v_quiz()));
                      },
                    ),
                  )
                ],
              ),
            )
          ],
        )
    );
  }
}

//Vocab Screen
class Vocab extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
            title: Text("Medical Vocabulary", style: TextStyle(color: Colors.white))
        ),
        body: ListView(
          children: <Widget>[
            SafeArea(child: Image.asset("assets/VocabHeader.png", fit: BoxFit.fitWidth, )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Vocabulary", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24), textAlign: TextAlign.left),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Learning medical vocabulary is important. It will allow you to communicate with the doctors better, whether is be describing your symptoms or understanding the doctors diagnosis, nevertheless it will beneficial for both parties", style: TextStyle(color: Colors.orangeAccent, fontSize: 15)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("1. Benign: Not cancerous\n2. Malignant: Cancerous\n3. Anti-inflammatory: Reduces swelling, pain, and soreness (such as ibuprofen or naproxen)\n4. Body Mass Index (BMI): Body fat measurement based on height and weight\n5. Biopsy: A tissue sample for testing purposes\n6. Hypotension: Low blood pressure\n7. Hypertension: High blood pressure\n8. Lesion: Wound, sore, or cut\n9. Noninvasive: Doesn’t require entering the body with instruments; usually simple\n10. Outpatient: Check in and check out the same day\n11. Inpatient: Plan to stay overnight for one or more days\n12. In remission: Disease is not getting worse; not to be confused with being cured\n13. Membrane: Thin layer of pliable tissue that serves as a covering or lining or connection between two structures\n14. Acute: Sudden but usually short (e.g., acute illness)\n15. Angina: Pain in the chest related to the heart that comes and goes\n16. Gastroesophageal Reflux Disease (GERD): Heartburn\n17. Cellulitis: Inflamed or infected tissue beneath the skin\n18. Epidermis: Outermost layer of skin\n19. Neutrophils: Most common type of white blood cell\n20. Edema: Swelling\n21. Embolism: Blood clot\n22. Sutures: Stitches\n23. Polyp: Mass or growth of thin tissue\n24. Compound fracture: Broken bone that protrudes through the skin\n25. Comminuted fracture: Broken bone that shatters into many pieces", style: TextStyle(color: Colors.blue, fontSize: 18)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MaterialButton(
                color: Colors.orange,
                child: Text("Take the quiz!", style: TextStyle(color: Colors.white),),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => medical_v_quiz()));
                },
              ),
            )
          ],
        )
    );
  }
}

covidurl() {
String urll = "https://www.who.int/emergencies/diseases/novel-coronavirus-2019/advice-for-public";
launch(urll);
}

cuturl() {
String urll = "https://www.mayoclinic.org/first-aid/first-aid-cuts/basics/art-20056711";
launch(urll);
}

FAurl() {
  String urll = "https://www.verywellhealth.com/basic-first-aid-procedures-1298578";
  launch(urll);
}

MHurl() {
  String urll = "https://www.psycom.net/quizzes";
  launch(urll);
}

MHAurl() {
  String urll = "https://www.psychologytoday.com/intl/tests/health/mental-health-assessment";
  launch(urll);
}

CPRurl() {
  String urll = "https://cpr.heart.org/en/resources/what-is-cpr";
  launch(urll);
}

Sprainurl() {
  String urll = "https://www.mayoclinic.org/diseases-conditions/sprains/diagnosis-treatment/drc-20377943";
  launch(urll);
}

MHRurl() {
  String urll = "https://www.ncbi.nlm.nih.gov/books/NBK20369/";
  launch(urll);
}

botCurl() {
  String urll = "https://web-chat.global.assistant.watson.cloud.ibm.com/preview.html?region=us-east&integrationID=d9e458d7-7347-4811-83f5-52b0d12816b6&serviceInstanceID=d9694be0-37c3-4ac8-8258-269f715a7568";
  launch(urll);
}

botBurl() {
  String urll = "https://web-chat.global.assistant.watson.cloud.ibm.com/preview.html?region=us-east&integrationID=8a5114e2-8f90-4154-b2e2-da441848eacb&serviceInstanceID=d9694be0-37c3-4ac8-8258-269f715a7568";
  launch(urll);
}

