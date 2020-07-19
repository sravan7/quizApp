import 'package:flutter/material.dart';
import 'quizBrain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
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
  List<Widget> scoreIcons = [];

  QuizBrain quizBrain = QuizBrain();
  void checkAnswer({bool ans}) {
    if (quizBrain.getAnswerofThis() == ans) {
      setState(() {
        scoreIcons.add(Icon(
          Icons.check,
          color: Colors.greenAccent,
        ));
      });
    } else {
      setState(() {
        scoreIcons.add(Icon(
          Icons.close,
          color: Colors.redAccent,
        ));
      });
    }
    quizBrain.nextQuestion();
    if (quizBrain.isFinished()) {
      Alert(
          context: context,
          title: 'Finsihed',
          desc: 'you\'ve reached end of the quiz ',
          buttons: [
            DialogButton(
              child: Text('reset'),
              color: Colors.green,
              onPressed: () {
                scoreIcons.length = 0;
                quizBrain.resetState();
              },
            )
          ]).show();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizBrain.getQuestionText(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              textColor: Colors.white,
              color: Colors.green,
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                checkAnswer(ans: true);
                //The user picked true.
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              color: Colors.red,
              child: Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                checkAnswer(ans: false);
                //The user picked false.
              },
            ),
          ),
        ),
        Expanded(
          child: Wrap(
            alignment: WrapAlignment.center,
            spacing: 8.0,
            runSpacing: 4.0,
            children: scoreIcons,
          ),
        )
      ],
    );
  }
}
