import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'QuickBrain.dart';

QuizBrain quizBrain = QuizBrain();

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey[900],
        body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: QuizPage(),
            ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {

  List<Icon > scoreKeeper = [];

  void checkAnswer(bool userPickedAnswer){
    bool correctAnswer = quizBrain.getQuestionAnswer();

    setState(() {
      if(quizBrain.isFinished() == true){
        Alert(context: context, title: "Quiz has Ended", desc: "You\'ve reached the end of the quiz.").show();
        quizBrain.reset();
        scoreKeeper = [];
      }else{
        if (userPickedAnswer == correctAnswer) {
          scoreKeeper.add(Icon(Icons.check, color: Colors.green,));
        } else{
          scoreKeeper.add(Icon(Icons.check, color: Colors.red,));
        }
        quizBrain.nextQuestion();
      }
    });
  }




  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Text(quizBrain.getQuestionText(),
                textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 25.0,
                color: Colors.white
              ),
              ),
            ),
          ),
        ), //QuestionPage
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: FlatButton(
              color: Colors.green,
              onPressed: (){
                quizBrain.isFinished();
                checkAnswer(true);
              },
              child: Text(
                'True',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white
                ),
              ),
            ),
          ),
        ), //TrueButton
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: FlatButton(
              color: Colors.red,
              onPressed: (){
              checkAnswer(false);
              },
              child: Text(
                'False',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white
                ),
              ),
            ),
          ),
        ),//FalseButton
        Row(
          children: scoreKeeper,
        )
      ],
    );
  }
}
