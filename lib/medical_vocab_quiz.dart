import 'package:flutter/material.dart';
import 'main.dart';
import 'Learn.dart';

//TODO add questions about heart disease, stroke, mental health, first aid, common infections

//the goal is to increase their knowledge of medical terms to understand the doctors better
class VocabQ {
  var vQuestions = [
    "What is the definition of benign? eg. A benign tumor",
    "What does malignant mean?",
    "Arthritis means ______ of joints?",
  ];

  var choices  = [
    ["small and minute", "long and wide", "dangerous to health (cancerous)", "not dangerous to health (not cancerous)"],
    ["large and growing", "odd looking", "not dangerous to health (not cancerous)", "dangerous to health (cancerous)"],
    ["breaking", "inflammation", "crushing", "reduction"],
  ];

  var vAnswers = [
    "not dangerous to health (not cancerous)",
    "dangerous to health (cancerous)",
    "inflammation",

  ];
}

int score = 0;
int question_number = 0;
var quiz = new VocabQ();

class medical_v_quiz extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return medical_v_quiz_state();
  }
}

class medical_v_quiz_state extends State<medical_v_quiz> {
  int Questions = 0;
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
              Container(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Medical Vocabulary Quiz", style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
                    ),
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
                      padding: const EdgeInsets.only(top:210.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          optionButton(Colors.blue, 0),
                          optionButton(Colors.orangeAccent, 1),
                          optionButton(Colors.redAccent, 2),
                          optionButton(Colors.green, 3),
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
              print("Right!");
              update_questions();
              score += 10;
            }
            else {
              final snackBar = SnackBar(
                content: Text('Wrong Answer!'),
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
  Summary({Key key, @required this.score}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(

      onWillPop: ()async => false,
      child: Scaffold(
        backgroundColor: Colors.black45,
        body: SafeArea(
          child: Container(
            alignment: Alignment.center,
            child: Column(
              children: <Widget>[
                SafeArea(child: Image.asset("assets/TedMed Header Image.png", fit: BoxFit.fitWidth, height: 100, scale: 1)),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Congratulations!\nYou finished the quiz", style: TextStyle(color: Colors.orangeAccent, fontSize: 30, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Final Score: $score", style: TextStyle(color: Colors.green, fontSize: 30, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MaterialButton(
                    color: Colors.blue,
                    child: Text("Back", style: TextStyle(color: Colors.white),),
                    onPressed: () {
                      question_number = 0;
                      score = 0;
                      Points += score;
                      Navigator.push(context, new MaterialPageRoute(builder: (context) => Learn()));
                    },
                  ),
                )
              ],
            ),
          ),
        )
      ),
    );
  }
}