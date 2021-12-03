import 'package:coachthecoach/Data/LoggingData.dart';
import 'package:coachthecoach/Data/ResultData.dart';
import 'package:coachthecoach/Data/sessionData.dart';
import 'package:coachthecoach/FlowScreens/SelectSessionScreen.dart';
import 'package:coachthecoach/constants.dart';
import 'package:flutter/material.dart';

import 'package:coachthecoach/libary.dart';
import 'VideoResultScreen.dart';

class OctantResultScreen extends StatefulWidget {
  @override
  _OctantResultScreenState createState() => _OctantResultScreenState();
}

class _OctantResultScreenState extends State<OctantResultScreen> {
  ResultOption option = ResultOption.Observaties;
  //Octant selectedOctant = autonomySupport.octants[1];
  /*Widget _getSizedBoxButton(
      double height, double width, Alignment align, Octant o) {
    return GestureDetector(
      onTap: () {
        print("test");
        addFeedbackLog(
            FBLog(DateTime.now(), o, LogAction.FeedbackSelectOctant));
        setState(() {
          selectedOctant = o;
        });
      },
      child: Align(
          alignment: align,
          child: SizedBox(
            height: height,
            width: width,
            child: Text(
              o.name,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: greyText,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          )),
    );
  }
*/
  List<Widget> _getOctantCompass(ResultOption option) {
    final Map<Octant, Alignment> _octantAlignments = {
      autonomySupport.octants[0]: Alignment(0.42, -0.75),
      autonomySupport.octants[1]: Alignment(0.87, -0.22),
      structure.octants[0]: Alignment(0.87, 0.22),
      structure.octants[1]: Alignment(0.5, 0.75),
      control.octants[0]: Alignment(-0.36, 0.75),
      control.octants[1]: Alignment(-0.85, 0.22),
      chaos.octants[0]: Alignment(-0.83, -0.22),
      chaos.octants[1]: Alignment(-0.42, -0.75),
    };
    List<Widget> result = [];
    result.add(
      Row(
        children: [
          Column(
            children: [
              Stack(
                children: _getOctantsObsFeedbackFields(
                  chaos,
                  180,
                  option,
                ),
              ),
              Stack(
                children: _getOctantsObsFeedbackFields(
                  control,
                  90,
                  option,
                ),
              ),
            ],
          ),
          Column(
            children: [
              Stack(
                children: _getOctantsObsFeedbackFields(
                  autonomySupport,
                  270,
                  option,
                ),
              ),
              Stack(
                children: _getOctantsObsFeedbackFields(
                  structure,
                  0,
                  option,
                ),
              ),
            ],
          ),
        ],
      ),
    );

    /*for (Octant o in _octantAlignments.keys) {
      result.add(Align(
        alignment: _octantAlignments[o],
        child: GestureDetector(
          onTap: () {
            print("test");
            addFeedbackLog(
                FBLog(DateTime.now(), o, LogAction.FeedbackSelectOctant));
            setState(() {
              selectedOctant = o;
            });
          },
          child: Text(
            o.name,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: greyText,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ));
    }*/
/*
    result.add(_getSizedBoxButton(
        80, 60, Alignment(0.27, -0.9), autonomySupport.octants[0]));
    result.add(_getSizedBoxButton(
        60, 90, Alignment(1, -0.25), autonomySupport.octants[1]));
    result.add(
        _getSizedBoxButton(80, 60, Alignment(0.27, 0.9), structure.octants[1]));
    result.add(
        _getSizedBoxButton(60, 90, Alignment(1, 0.25), structure.octants[0]));
    result.add(
        _getSizedBoxButton(80, 60, Alignment(-0.27, -0.9), chaos.octants[1]));
    result.add(
        _getSizedBoxButton(60, 90, Alignment(-1, -0.25), chaos.octants[0]));
    result.add(
        _getSizedBoxButton(80, 60, Alignment(-0.27, 0.9), control.octants[0]));
    result.add(
        _getSizedBoxButton(60, 90, Alignment(-1, 0.25), control.octants[1]));
*/
    return result;
  }

/*
  Widget _getOctantContainer(Octant o) {
    return isActiveVersion()
        ? OctantNumberContainer(octant: o)
        : PassiveOctantFBContainer(octant: o);
  }

  List<Widget> _getOctantContainers() {
    List<Widget> result = [];
    for (Octant o in octantColors.keys) {
      Widget octantContainer = isActiveVersion()
          ? OctantNumberContainer(octant: o)
          : PassiveOctantFBContainer(octant: o);
      result.add(octantContainer);
    }
    return result;
  }
*/
  //double opacity = 0.2;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: SubTitle(title: "Coach profiel"),
          ),
          /*isActiveVersion()
              ? Container(
                  decoration: kVisualButtonDecoration,
                  margin: EdgeInsets.only(bottom: 8),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            if (option != ResultOption.Oplossing) {
                              addFeedbackLog(FBLog(
                                  DateTime.now(),
                                  "Select Oplossing",
                                  LogAction.FeedbackSelectOptionOctant));
                              setState(() {
                                option = ResultOption.Oplossing;
                              });
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            decoration: BoxDecoration(
                              color: option == ResultOption.Oplossing
                                  ? lightBlue
                                  : Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  bottomLeft: Radius.circular(20)),
                            ),
                            child: Text(
                              "Oplossing",
                              textAlign: TextAlign.center,
                              style: kTextStyleOption(
                                  option == ResultOption.Oplossing),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            if (option != ResultOption.Observaties) {
                              addFeedbackLog(FBLog(
                                  DateTime.now(),
                                  "Select Observaties",
                                  LogAction.FeedbackSelectOptionOctant));
                              setState(() {
                                option = ResultOption.Observaties;
                              });
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            decoration: BoxDecoration(
                              color: option == ResultOption.Observaties
                                  ? lightBlue
                                  : Colors.white,
                            ),
                            child: Text(
                              "Observaties",
                              textAlign: TextAlign.center,
                              style: kTextStyleOption(
                                  option == ResultOption.Observaties),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            if (option != ResultOption.Vergelijking) {
                              addFeedbackLog(FBLog(
                                  DateTime.now(),
                                  "Select Vergelijking",
                                  LogAction.FeedbackSelectOptionOctant));
                              setState(() {
                                option = ResultOption.Vergelijking;
                              });
                            }
                          },
                          child: Container(
                              padding: EdgeInsets.symmetric(vertical: 8),
                              decoration: BoxDecoration(
                                color: option == ResultOption.Vergelijking
                                    ? lightBlue
                                    : Colors.white,
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(20),
                                    bottomRight: Radius.circular(20)),
                              ),
                              child: Text("Vergelijking",
                                  textAlign: TextAlign.center,
                                  style: kTextStyleOption(
                                      option == ResultOption.Vergelijking))),
                        ),
                      ),
                    ],
                  ),
                )
              : Container(),*/
          Center(
            child: Container(
              height: kDiameter,
              width: kDiameter,
              child: Stack(
                children: _getOctantCompass(option),
              ),
            ),
          ),
          /*
          NbFeedbackContainer(option: option, quadrant: autonomySupport),
          NbFeedbackContainer(option: option, quadrant: structure),
          NbFeedbackContainer(option: option, quadrant: control),
          NbFeedbackContainer(option: option, quadrant: chaos),*/
          /*Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: SubTitle(title: "Octant Resultaat"),
          ),
          isActiveVersion()
              ? OctantNumberContainer(octant: selectedOctant)
              : PassiveOctantFBContainer(octant: selectedOctant),*/
          /*Column(
            children: _getOctantContainers(),
          ),*/
          BottomButton(
              onTap: () {
                int nr = getSessionNr();
                showDialogueWith2Buttons(
                    context,
                    "Afsluiten sessie",
                    "Ben je zeker dat je de sessie wilt afsluiten?",
                    "Afsluiten", () {
                  addFeedbackLog(
                      FBLog(DateTime.now(), null, LogAction.FeedbackEnd));
                  Navigator.pushNamed(context, SelectSessionScreen.id);
                });
              },
              text: 'StartScherm'),
        ],
      ),
    );
  }
}

class OctantNumberContainer extends StatelessWidget {
  OctantNumberContainer({@required this.octant});
  final Octant octant;
  TextStyle _kFeedbackStyle =
      TextStyle(fontWeight: FontWeight.w500, fontSize: 17, color: greyText);
  TextStyle _kNbStyle =
      TextStyle(fontWeight: FontWeight.w400, fontSize: 16, color: greyText);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: octantColors[octant].withOpacity(0.8),
          width: kThicknessCompass,
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(left: 0, right: 15, top: 10, bottom: 5),
            child: Row(
              children: [
                IconButton(
                    onPressed: () {
                      addFeedbackLog(FBLog(DateTime.now(), octant,
                          LogAction.FeedbackSelectOctantVideo));
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                OctantVideoResultScreen(octant: octant)),
                      );
                    },
                    icon: Icon(Icons.info_outline,
                        size: 35, color: octantColors[octant])),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        octant.toString(),
                        style: TextStyle(
                          color: greyText,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Divider(
                        thickness: 2,
                        color: octantColors[octant].withOpacity(0.8),
                        height: 1,
                        indent: 0,
                        endIndent: 90,
                      ),
                    ],
                  ),
                ),
                Text(
                  "Obs. gemaakt: ",
                  style: TextStyle(
                    color: greyText,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  obsOctantNumbers[octant].toString(),
                  style: TextStyle(
                    color: greyText,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 5.0),
            child: Row(children: [
              Expanded(
                child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 3.0),
                        child: Icon(
                          Icons.check_circle_outline,
                          color: Colors.green,
                        ),
                      ),
                      Text(
                        "Correct:",
                        style: _kFeedbackStyle,
                      ),
                    ],
                  ),
                  Text(
                    octantFeedbackNbs[octant][FeedbackOption.correct]
                        .toString(),
                    style: _kNbStyle,
                  ),
                ]),
              ),
              Expanded(
                child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 3.0),
                        child: Icon(
                          Icons.highlight_off,
                          color: Colors.red,
                        ),
                      ),
                      Text(
                        "Incorrect:",
                        style: _kFeedbackStyle,
                      ),
                    ],
                  ),
                  Text(
                    octantFeedbackNbs[octant][FeedbackOption.incorrect]
                        .toString(),
                    style: _kNbStyle,
                  ),
                ]),
              ),
              Expanded(
                child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 3.0),
                        child: Icon(
                          Icons.help_outline,
                          color: greyText,
                        ),
                      ),
                      Text(
                        "Gemist:",
                        style: _kFeedbackStyle,
                      ),
                    ],
                  ),
                  Text(
                    octantFeedbackNbs[octant][FeedbackOption.gemist].toString(),
                    style: _kNbStyle,
                  ),
                ]),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}

class PassiveOctantFBContainer extends StatelessWidget {
  PassiveOctantFBContainer({@required this.octant});
  final Octant octant;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: octantColors[octant].withOpacity(0.8),
          width: kThicknessCompass,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
        child: Row(
          children: [
            IconButton(
                onPressed: () {
                  addFeedbackLog(FBLog(DateTime.now(), octant,
                      LogAction.FeedbackSelectOctantVideo));
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            OctantVideoResultScreen(octant: octant)),
                  );
                },
                icon: Icon(Icons.info_outline,
                    size: 30, color: octantColors[octant])),
            Expanded(
              flex: 2,
              child: Text(
                octant.toString() + ":",
                style: TextStyle(
                  color: greyText,
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  solOctantNumbers[octant].toString(),
                  style: TextStyle(
                    color: greyText,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NbFeedbackContainer extends StatelessWidget {
  NbFeedbackContainer({
    @required this.option,
    @required this.quadrant,
  });

  final ResultOption option;
  final Quadrant quadrant;
  @override
  Widget build(BuildContext context) {
    List<Color> colors = [
      octantColors[quadrant.octants[0]],
      octantColors[quadrant.octants[1]]
    ];
    List<String> result = calculateOctantFeedback(option, quadrant);
    return Center(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: lightBlue, width: kThicknessCompass),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  Expanded(
                      flex: 5,
                      child: Text(quadrant.octants[0].name + ":",
                          style: TextStyle(
                            color: colors[0],
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ))),
                  Expanded(
                      flex: 2,
                      child: Center(
                          child: Text(result[0],
                              style: TextStyle(
                                color: colors[0],
                                fontSize: 16,
                              )))),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                      flex: 5,
                      child: Text(quadrant.octants[1].name + ":",
                          style: TextStyle(
                            color: colors[1],
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ))),
                  Expanded(
                      flex: 2,
                      child: Center(
                          child: Text(result[1],
                              style: TextStyle(
                                color: colors[1],
                                fontSize: 16,
                              )))),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

List<Widget> _getOctantsObsFeedbackFields(
  Quadrant q,
  int startAngle,
  ResultOption option,
) {
  double opacity = option == ResultOption.Vergelijking ? 0.4 : 0.8;
  Octant o0 = q.octants[0];
  Octant o1 = q.octants[1];
  double maxPercentage = calculatePercentageRadius();
  return [
    option != ResultOption.Observaties
        ? PaintContainer(
            radius: (solOctantRadius[o0] / maxPercentage) * (kDiameter / 2),
            color: octantColors[o0].withOpacity(opacity),
            startAngle: startAngle,
            isQuadrant: false,
            isFilled: true,
            isUserObs: false,
          )
        : Container(),
    option != ResultOption.Oplossing
        ? PaintContainer(
            radius: (obsOctantRadius[o0] / maxPercentage) * (kDiameter / 2),
            color: octantColors[o0],
            startAngle: startAngle,
            isQuadrant: false,
            isFilled: false,
            isUserObs: true,
          )
        : Container(),
    option != ResultOption.Observaties
        ? PaintContainer(
            radius: (solOctantRadius[o1] / maxPercentage) * (kDiameter / 2),
            color: octantColors[o1].withOpacity(opacity),
            startAngle: startAngle + 45,
            isQuadrant: false,
            isFilled: true,
            isUserObs: false,
          )
        : Container(),
    option != ResultOption.Oplossing
        ? PaintContainer(
            radius: (obsOctantRadius[o1] / maxPercentage) * (kDiameter / 2),
            color: octantColors[o1],
            startAngle: startAngle + 45,
            isQuadrant: false,
            isFilled: false,
            isUserObs: true,
          )
        : Container(),
    OctantField(
      quadrant: q,
      color: lightBlue,
      startAngle: startAngle,
      radius: kDiameter / 2,
    ),
  ];
}

class OctantField extends StatelessWidget {
  OctantField({
    @required this.quadrant,
    @required this.color,
    @required this.startAngle,
    @required this.radius,
  });

  final Quadrant quadrant;
  final Color color;
  final int startAngle;
  final double radius;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: radius,
      width: radius,
      child: Stack(
        children: <Widget>[
          PaintContainer(
            radius: radius,
            color: color,
            startAngle: startAngle,
            isQuadrant: false,
            isFilled: false,
            isUserObs: false,
          ),
          PaintContainer(
            radius: radius,
            color: color,
            startAngle: startAngle + 45,
            isQuadrant: false,
            isFilled: false,
            isUserObs: false,
          ),
        ],
      ),
    );
  }
}
