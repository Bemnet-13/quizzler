import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'quiz_brain.dart';

QuizBrain quizBrain = QuizBrain();

void main() {
  runApp(const MaterialApp(
      home: Quizzler()),
  );
}

class Quizzler extends StatefulWidget {
  const Quizzler({super.key});

  @override
  State<Quizzler> createState() => _QuizzlerState();
}

class _QuizzlerState extends State<Quizzler> {
  int questionNumber = 1;
  Icon correctIcon = const Icon(
    Icons.check,
    color: Colors.green,
  );
  Icon wrongIcon = const Icon(
    Icons.close,
    color: Colors.red,
  );

  List<Widget> scoreKeeper = [];

  void checkAnswer(bool userPickedAnswer) {
    setState(() {
      if (quizBrain.isFinished()){
        Alert(
          context: context,
          title: 'Finished!',
          desc: 'You\'ve reached the end of the quiz.',
        ).show();
        quizBrain.reset();
        scoreKeeper = [];
      }
      else{
        if (userPickedAnswer == quizBrain.getQuestionAnswer()){
          scoreKeeper.add(correctIcon);
      }
        else {
          scoreKeeper.add(wrongIcon);
      }
    }
      quizBrain.nextQuestion();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(quizBrain.getQuestionText(),
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
          ),
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(onPressed: () {
                    checkAnswer(true);
                  },
                    child: Text("True",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25.0
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(),
                      padding: EdgeInsets.all(20.0),
                  ),
                ),
              ),)
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      checkAnswer(false);
                  },
                    child: Text("False",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25.0
                    ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(),
                      padding: EdgeInsets.all(20.0)
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: scoreKeeper,
          ),
        ],
      ),
    );
  }
}


