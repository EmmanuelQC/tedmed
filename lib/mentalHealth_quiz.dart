import 'dart:async';

import 'package:flutter/material.dart';
import 'main.dart';
import 'Learn.dart';
import 'package:confetti/confetti.dart';
import 'dart:math';

//TODO add questions about heart disease, stroke, mental health, first aid, common infections

//the goal is to increase their knowledge of medical terms to understand the doctors better
class MentalQ {
  var vQuestions = [
    "What is the definition of a mental illness? \nA health condition that...",
    "What are some types of mental illnesses?",
    "How many people are estimated to have mental illnesses each year?",
  ];

  var choices  = [
    ["distorts a persons hearing", "deforms a persons skull and changes their bone structure", "changes a persons thinking, feeling or behaviour and causes distress with difficulty in functioning", "alters their senses and neurological activity only in the day time"],
    ["a bone fracture", "depression", "muscle sprain", "cancer"],
    ["one in five or 8 million people", "60% of the world's population", "200 million people", "one in four people"],
  ];

  var vAnswers = [
    "changes a persons thinking, feeling or behaviour and causes distress with difficulty in functioning",
    "depression",
    "one in five or 8 million people",
  ];
}

int score = 0;
int question_number = 0;
var quiz = new MentalQ();

class mentalHealth_quiz extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return mentalHealth_quiz_state();
  }
}

class mentalHealth_quiz_state extends State<mentalHealth_quiz> {
  ConfettiController mycontroller;
  int Questions = 0;

  @override
  void initState() {
    super.initState();
    mycontroller = ConfettiController(duration: Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
            title: Text("Learn", style: TextStyle(color: Colors.white))
        ),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Mental Health Quiz", style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
            ),
            Container(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text("Question ${question_number + 1}/${quiz.vQuestions.length}", style: TextStyle(color: Colors.blue, fontSize: 24, fontWeight: FontWeight.bold),),

                          Container(decoration: BoxDecoration(color: Colors.black12),child: Text("Score: $score", style: TextStyle(color: Colors.orange, fontSize: 24, fontWeight: FontWeight.bold)))
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(quiz.vQuestions[question_number], style: TextStyle(color: Colors.white, fontSize: 20),),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top:250.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        optionButton(Colors.blue, 0),
                        optionButton(Colors.orangeAccent, 1),
                        optionButton(Colors.redAccent, 2),
                        optionButton(Colors.green, 3),
                        Align(alignment: Alignment.bottomCenter,child: ConfettiWidget(confettiController: mycontroller, blastDirection: -pi/2, maxBlastForce: 100, minBlastForce: 50, emissionFrequency: 0.01, numberOfParticles:66, shouldLoop: false,)),
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.bottomCenter,
                    child: MaterialButton(
                      color: Colors.red,
                      minWidth: 100,
                      height: 30,
                      onPressed: resetQuiz,
                      child: Text("Quit", style: TextStyle(color: Colors.white, fontSize: 18),),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget optionButton(final c, int opNum) {
    return Builder(
      builder: (context) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: MaterialButton(
          height: 70,
          minWidth: double.infinity,
          color: c,
          onPressed: () {
            if(quiz.choices[question_number][opNum] == quiz.vAnswers[question_number]) {
              mycontroller.play();
              print("Right!");
              score += 10;
              final snackBar = SnackBar(
                content: Text('Correct!', style: TextStyle(color: Colors.green, fontSize: 20)),
                action: SnackBarAction(
                  label: 'Next Question',
                  onPressed: () {
                    update_questions();
                  },
                ),
              );
              Scaffold.of(context).showSnackBar(snackBar);
            }
            else {
              final snackBar = SnackBar(
                content: Text('Wrong!', style: TextStyle(color: Colors.redAccent, fontSize: 20)),
                action: SnackBarAction(
                  label: 'Try Again',
                  onPressed: () {
                    //Navigator.pop(context);
                  },
                ),
              );

              Scaffold.of(context).showSnackBar(snackBar);
              print("Wrong!");
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(7.0),
            child: Text(quiz.choices[question_number][opNum], style: TextStyle(color: Colors.white, fontSize: 18)),
          ),
        ),
      ),
    );
  }

  void update_questions(){
    setState(() {
      if(question_number == quiz.vQuestions.length - 1) {
        Navigator.push(context, new MaterialPageRoute(builder: (context) => Summary(score: score)));
      }
      else {
        question_number++;
      }
    });
  }

  void resetQuiz() {
    setState(() {
      Navigator.pop(context);
      score = 0;
      question_number = 0;
    });
  }
}

class Summary extends StatelessWidget {
  int score;
  ConfettiController mycontroller;
  Summary({Key key, @required this.score}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    mycontroller = ConfettiController(duration: Duration(seconds: 1));

    return WillPopScope(
      onWillPop: ()async => false,
      child: Scaffold(
          backgroundColor: Colors.black45,
          body: SafeArea(
            child: Container(
              alignment: Alignment.center,
              child: Column(
                children: <Widget>[
                  SafeArea(child: Image.asset("assets/MentalHealthHeader.png", fit: BoxFit.fitWidth)),
                  Align(alignment: Alignment.bottomCenter,child: ConfettiWidget(confettiController: mycontroller, blastDirection: pi/2,maxBlastForce: 30,minBlastForce: 10, emissionFrequency: 0.01,numberOfParticles:33,shouldLoop: true,)),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Congratulations!\nYou finished the quiz", style: TextStyle(color: Colors.orangeAccent, fontSize: 30, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Final Score: $score", style: TextStyle(color: Colors.green, fontSize: 30, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top:7.0, left: 25, right:25, bottom: 7),
                    child: MaterialButton(
                        height: 50,
                        color: Colors.orange,
                        child: Text("Learn More!", style: TextStyle(color: Colors.white, fontSize: 20)),
                        onPressed: () {
                          MHAurl();
                        }
                    ),
                  ),
                  SafeArea(child: Image.asset("assets/TedMed Header Image.png", fit: BoxFit.fitWidth, height: 100, scale: 1)),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MaterialButton(
                      color: Colors.blue,
                      child: Text("Finish", style: TextStyle(color: Colors.white, fontSize: 20),),
                      onPressed: () {
                        question_number = 0;
                        score = 0;
                        Points += score;
                        Navigator.push(context, new MaterialPageRoute(builder: (context) => Learn()));
                      },
                    ),
                  ),
                ],
              ),
            ),
          )
      ),
    );
  }
}