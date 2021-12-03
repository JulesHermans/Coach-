import 'package:coachthecoach/Data/LoggingData.dart';
import 'package:coachthecoach/Data/sessionData.dart';
import '../constants.dart';
import '../libary.dart';
import 'package:coachthecoach/FlowScreens/EndSessionScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter/rendering.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import '../networking.dart';
import '1ButtonRestScreen.dart';
import 'ObservationsScreen.dart';

Timing _selectedTiming;
int _teamScore = 0;
int _opponentScore = 0;

//method executes when a quadrant get's selected
Future<void> selectQuadrant(Quadrant q, BuildContext context) {
  //logging van actie
  addObservationLog(Log(DateTime.now(), q, LogAction.selectQuadrant));

  Observation observation = new Observation();
  observation.setTime(DateTime.now().difference(obsSes.startTime));
  observation.setScore(_teamScore, _opponentScore);
  observation.setTiming(_selectedTiming);
  observation.setQuadrant(q);
  obsSes.setNewObservation(observation);
  Navigator.pushNamed(context, Button1RestScreen.id);
}

//screen with the quadrant compass @ the bottom
class QuadrantScreen extends StatefulWidget {
  static String id = 'QuadrantScreen';
  @override
  _QuadrantScreenState createState() => _QuadrantScreenState();
}

class _QuadrantScreenState extends State<QuadrantScreen> {
  final double diameter = 275;

  TextStyle kStyleQuadrantTitles = TextStyle(
    color: greyText,
    fontSize: 14,
    fontWeight: FontWeight.w600,
  );

  Expanded getTimingContainer(Timing timing) {
    bool selected = timing == _selectedTiming;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          //logging van actie
          if (_selectedTiming == null)
            addObservationLog(
                Log(DateTime.now(), timing, LogAction.selectTiming));
          else
            addObservationLog(
                Log(DateTime.now(), timing, LogAction.changeTiming));

          setState(() {
            _selectedTiming = timing;
          });
        },
        child: Container(
          height: 60,
          decoration: timing == Timing.Wedstrijd
              ? BoxDecoration(
                  color: selected ? lightBlue : Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(17),
                    bottomLeft: Radius.circular(17),
                  ))
              : timing == Timing.Tussendoor
                  ? BoxDecoration(
                      color: selected ? lightBlue : Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(17),
                        bottomRight: Radius.circular(17),
                      ))
                  : BoxDecoration(
                      color: selected ? lightBlue : Colors.white,
                    ),
          child: Center(
            child: Text(
              enumToString(timing),
              style: kTextStyleOption(selected),
            ),
          ),
        ),
      ),
    );
  }

  bool _showSpinner = false;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: ModalProgressHUD(
        inAsyncCall: _showSpinner,
        child: Scaffold(
          appBar: AppBar(
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.format_list_bulleted),
                onPressed: () {
                  //logging van actie:
                  addObservationLog(
                      Log(DateTime.now(), null, LogAction.goToObservations));

                  Navigator.pushNamed(context, ObservationScreen.id);
                },
              )
            ],
            leading: Container(),
            /*IconButton(
                onPressed: () {
                  showDialogueWith2Buttons(
                      context,
                      "Reset observaties",
                      "Alle ingegeven observaties in deze sessie worden verwijderd,Weet je zeker dat je je observaties wilt resetten?\n \n Gelieve bij reset ook de video in de survey gelijktijdig opnieuw te starten! ",
                      "Reset observatiesessie", () {
                    DateTime now = DateTime.now();
                    addObservationLog(
                        Log(now, null, LogAction.resetObservations));
                    resetSession();
                    Navigator.pop(context);
                    Navigator.pop(context);
                  });
                },
                icon: Icon(Icons.update)),*/
            centerTitle: true,
            title: Text('Observatie'),
          ),
          body: ListView(
            children: [
              Container(
                margin: EdgeInsets.all(5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(
                          left: 10, right: 10, top: 8, bottom: 5),
                      //padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      decoration: kVisualButtonDecoration,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          getTimingContainer(Timing.Wedstrijd),
                          getTimingContainer(Timing.TimeOut),
                          getTimingContainer(Timing.Tussendoor),
                        ],
                      ),
                    ),
                    SubTitle(title: 'Score'),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      //padding: EdgeInsets.all(5),
                      decoration: kVisualButtonDecoration,
                      child: IntrinsicHeight(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            ScoreField(true),
                            VerticalDivider(
                              thickness: 1,
                              width: 1,
                              color: lightBlue,
                            ),
                            ScoreField(false),
                          ],
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        SubTitle(title: 'Kwadrant'),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            width: diameter,
                            height: diameter,
                            child: Row(
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    GestureDetector(
                                      onTap: () {
                                        selectQuadrant(chaos, context);
                                      },
                                      child: QuadrantField(
                                        quadrant: chaos,
                                        radius: diameter / 2,
                                        startAngle: 180,
                                        textAlignment: Alignment(0.20, 0.20),
                                        color: lightBlue,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        selectQuadrant(control, context);
                                      },
                                      child: QuadrantField(
                                        quadrant: control,
                                        radius: diameter / 2,
                                        startAngle: 90,
                                        textAlignment: Alignment(0.20, -0.20),
                                        color: lightBlue,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: <Widget>[
                                    GestureDetector(
                                      onTap: () {
                                        selectQuadrant(
                                            autonomySupport, context);
                                      },
                                      child: QuadrantField(
                                        quadrant: autonomySupport,
                                        radius: diameter / 2,
                                        startAngle: 270,
                                        textAlignment: Alignment(-0.22, 0.25),
                                        color: lightBlue,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        selectQuadrant(structure, context);
                                      },
                                      child: QuadrantField(
                                        quadrant: structure,
                                        radius: diameter / 2,
                                        startAngle: 0,
                                        textAlignment: Alignment(-0.22, -0.20),
                                        color: lightBlue,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    BottomButton(
                      onTap: () {
                        //logging van actie:
                        addObservationLog(
                            Log(DateTime.now(), null, LogAction.finish));

                        showDialogueWith2Buttons(
                            context,
                            'Einde sessie?',
                            'Je kan hierna geen observaties meer toevoegen in deze sessie. Je observaties worden naar de server verzoden!',
                            'Einde sessie', () async {
                          //logging van actie:
                          addObservationLog(Log(
                              DateTime.now(), null, LogAction.confirmFinish));

                          setState(() {
                            _showSpinner = true;
                          });
                          Navigator.pop(context);
                          //int result = await sendTest(context);
                          int result = await sendLogs(logsToJson(true),
                              obsSes.observationsToJson(), context);

                          setState(() {
                            _showSpinner = false;
                          });
                          if (result != 200) {
                            showDialogWithoutButtons(context, 'Server Error',
                                'Couldn\'t connect to the server! Please try again.');
                          } else {
                            clearLogs(true);
                            Navigator.pushNamed(context, EndSessionScreen.id);
                          }
                        });
                      },
                      text: 'Finish',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ScoreField extends StatefulWidget {
  ScoreField(this.isTeam);

  final bool isTeam;
  @override
  _ScoreFieldState createState() => _ScoreFieldState();
}

class _ScoreFieldState extends State<ScoreField> {
  int score = 0;
  Container createScoreButton(bool isPlus) {
    return Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: accentDarkBlue,
          borderRadius: BorderRadius.circular(10),
        ),
        child: GestureDetector(
          onTap: () {
            setState(() {
              isPlus ? score += 1 : score -= 1;
              score < 0 ? score = 0 : score = score;
            });
            //logging van actie:
            if (widget.isTeam) {
              //logging van actie:
              addObservationLog(
                  Log(DateTime.now(), _teamScore, LogAction.changeTeamScore));
            } else {
              //logging van actie:
              addObservationLog(Log(DateTime.now(), _opponentScore,
                  LogAction.changeOpponentScore));
            }

            widget.isTeam ? _teamScore = score : _opponentScore = score;
          },
          child: Icon(
            isPlus ? Icons.add : Icons.remove,
            color: Colors.white,
            size: 26,
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 2.0, bottom: 5),
          child: Text(
            widget.isTeam ? 'Team' : 'Opponent',
            style: TextStyle(
              color: greyText,
              fontSize: 14,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        Text(
          '$score',
          style: TextStyle(
            color: greyText,
            fontSize: 20,
            fontWeight: FontWeight.w300,
          ),
        ),
        Row(
          children: <Widget>[
            createScoreButton(true),
            createScoreButton(false),
          ],
        ),
      ],
    );
  }
}
