import 'package:coachthecoach/Data/LoggingData.dart';
import 'package:coachthecoach/Data/ResultData.dart';
import 'package:coachthecoach/Data/sessionData.dart';
import 'package:coachthecoach/FeedbackScreens/ResultScreen.dart';
import 'package:coachthecoach/FlowScreens/EndScreen.dart';
import 'package:coachthecoach/InputScreens/QuadrantScreen.dart';
import 'package:coachthecoach/constants.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import '../networking.dart';

class SelectSessionScreen extends StatefulWidget {
  static String id = "SelectSessionScreen";

  @override
  _SelectSessionScreenState createState() => _SelectSessionScreenState();
}

class _SelectSessionScreenState extends State<SelectSessionScreen> {
  bool resultsLoading = false;
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: resultsLoading,
      child: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          appBar: AppBar(
            leading: Container(),
            centerTitle: true,
            title: Text('Coach the Coach'),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 40),
                child: Image.asset('images/KUL logo.png'),
              ),
              Text(
                !isActiveVersion()
                    ? "Gelieve de video op de survey eerst te kijken alvorens verder te gaan naar de volgende feedback sessie!"
                    : "Indien u duwt op \'start volgende sessie \', dan start een observatie sessie om een video te scouten. \n \n Zorg ervoor dat u de sessie start, zo gelijktijdig mogelijk met de start van de video op de survey! ",
                textAlign: TextAlign.center,
                style: TextStyle(color: greyText, fontSize: 20),
              ),
              BottomButton(
                  onTap: () async {
                    resetAllFeedbackNumbers();
                    setState(() {
                      resultsLoading = true;
                    });
                    bool end = !nextFeedbackSession();
                    if (end) {
                      sendFeedbackLogs(logsToJson(false));
                      Navigator.pushNamed(context, EndScreen.id);
                    } else if (isActiveVersion()) {
                      Navigator.pushNamed(context, QuadrantScreen.id);
                    } else {
                      int nr = getSessionNr();
                      await createFeedbackData(false, "vid$nr");
                      addFeedbackLog(
                          FBLog(DateTime.now(), null, LogAction.FeedbackStart));
                      Navigator.pushNamed(context, ResultScreens.id);
                    }
                    setState(() {
                      resultsLoading = false;
                    });
                  },
                  text: "Start volgende sessie"),
            ],
          ),
        ),
      ),
    );
  }
}
