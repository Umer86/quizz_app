
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'quiz_logic.dart';

QuizLogic quizLogic = new QuizLogic();

void main() => runApp(QuizApp());

class QuizApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.blueGrey,
        appBar: AppBar(
          backgroundColor: Colors.blueAccent,

          title: Center(
            child: Text(
                'Quiz App',
            style: TextStyle(color: Colors.white, fontSize: 28),
          )


          ),
        ),
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

  final List<Widget> scoreKeeper = [];

  int totalCorrect = 0;
  int totalQuestions = 0;

  void checkAnswer(bool value) {
    if (quizLogic.getAnswer() == value) {
      print('right answer');
      scoreKeeper.add(Icon(Icons.check, color: Colors.green));
      totalCorrect ++;
    } else {
      print('wrong answer');
      scoreKeeper.add(Icon(Icons.close, color: Colors.red));
    }
    totalQuestions++;
    if (quizLogic.isFinshed() == true) {
      Alert(
          context: context,
          title: 'Finished',
          desc: 'You scored a total of $totalCorrect out of $totalQuestions!',
          buttons: [
            DialogButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'Play Again',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                )
            )
          ]
      ).show();
      quizLogic.reset();
      scoreKeeper.clear();
      totalCorrect = 0;
      totalQuestions = 0;
    } else {
      quizLogic.nextQuestion();
    }

  }



  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 1,
          child: SizedBox(),
        ),
        Expanded(
          flex: 3,
          child: Padding(
              padding: EdgeInsets.all(3.0),
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(40.0)),
                  color: Colors.lightBlueAccent,
                ),
                child: Center(
                  child: Text(
                    quizLogic.getQuestion(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28.0,
                    ),
                  ),
                ),
              )
          ),
        ),
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(50.0)
                    ),
                    textColor: Colors.white,
                    color: Colors.greenAccent[400],
                    child: Text(
                      'TRUE',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22.0,
                      ),
                    ),
                    onPressed: (){
                      setState(() {
                        checkAnswer(true);
                      });
                    },
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(50.0)
                    ),
                    textColor: Colors.white,
                    color: Colors.redAccent[400],
                    child: Text(
                      'FALSE',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22.0,
                      ),
                    ),
                    onPressed: (){
                      setState(() {
                        checkAnswer(false);
                      });
                    },
                  ),
                ),
              )
            ],
          ),
        ),
        Expanded(child: Row(children: scoreKeeper,),)
      ],
    );
  }
}