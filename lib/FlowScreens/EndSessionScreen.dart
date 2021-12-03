import 'dart:convert';
import 'package:coachthecoach/Data/LoggingData.dart';
import 'package:coachthecoach/Data/ResultData.dart';
import 'package:coachthecoach/Data/sessionData.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import '../FeedbackScreens/ResultScreen.dart';
import '../constants.dart';

class EndSessionScreen extends StatefulWidget {
  static String id = "EndSessionScreen";

  @override
  _EndSessionScreenState createState() => _EndSessionScreenState();
}

class _EndSessionScreenState extends State<EndSessionScreen> {
  bool resultsLoading = false;
  Future<void> initResults() async {
    setState(() {
      resultsLoading = true;
    });
    int nr = getSessionNr();
    await createFeedbackData(true, "vid$nr");
    setState(() {
      resultsLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: resultsLoading,
      child: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Results'),
            centerTitle: true,
            leading: Container(),
          ),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 4,
                  child: Icon(
                    Icons.check_circle_outline,
                    color: Colors.lightGreen.shade600,
                    size: 250,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    "De observaties zijn succesvol naar de server verzonden!",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: greyText, fontSize: 20),
                  ),
                ),
                Expanded(
                  child: BottomButton(
                    onTap: () async {
                      //await initResults();
                      addFeedbackLog(
                          FBLog(DateTime.now(), null, LogAction.FeedbackStart));
                      Navigator.pushNamed(context, ResultScreens.id);
                    },
                    text: 'Bekijk feedback',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
