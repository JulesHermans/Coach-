import 'package:coachthecoach/Data/LoggingData.dart';
import 'package:coachthecoach/Data/ResultData.dart';
import 'package:coachthecoach/Data/sessionData.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../libary.dart';
import 'VideoScreen.dart';

class VideoResultScreen extends StatefulWidget {
  VideoResultScreen(this.octant);
  Octant octant;
  @override
  _VideoResultScreenState createState() => _VideoResultScreenState();
}

class _VideoResultScreenState extends State<VideoResultScreen> {
  VideoOption option = VideoOption.correct;
  List<FeedbackObservation> videoFeedbacks = feedbacks;
  bool isOctant = false;
  @override
  Widget build(BuildContext context) {
    if (widget.octant != null) {
      isOctant = true;
      videoFeedbacks =
          feedbacks.where((e) => e.hasOctant(widget.octant)).toList();
    }
    List<Widget> videoBlocks = isActiveVersion()
        ? getVideoBlocks(option, videoFeedbacks)
        : getVideoBlocks(VideoOption.passief, videoFeedbacks);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          !isOctant ? SubTitle(title: "Video Resultaten") : Container(),
          isActiveVersion()
              ? Container(
                  decoration: kVisualButtonDecoration,
                  margin: EdgeInsets.symmetric(horizontal: 8, vertical: 15),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            if (option != VideoOption.chronologisch) {
                              addFeedbackLog(FBLog(
                                  DateTime.now(),
                                  "Select chronologisch",
                                  LogAction.FeedbackSelectOptionVideo));
                              setState(() {
                                option = VideoOption.chronologisch;
                              });
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            decoration: BoxDecoration(
                              color: option == VideoOption.chronologisch
                                  ? lightBlue
                                  : Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  bottomLeft: Radius.circular(20)),
                            ),
                            child: Text(
                              "Alles",
                              textAlign: TextAlign.center,
                              style: kTextStyleOption(
                                  option == VideoOption.chronologisch),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            if (option != VideoOption.correct) {
                              addFeedbackLog(FBLog(
                                  DateTime.now(),
                                  "Select correct",
                                  LogAction.FeedbackSelectOptionVideo));
                              setState(() {
                                option = VideoOption.correct;
                              });
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            decoration: BoxDecoration(
                              color: option == VideoOption.correct
                                  ? lightBlue
                                  : Colors.white,
                            ),
                            child: Text(
                              "Correct",
                              textAlign: TextAlign.center,
                              style: kTextStyleOption(
                                  option == VideoOption.correct),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            if (option != VideoOption.incorrect) {
                              addFeedbackLog(FBLog(
                                  DateTime.now(),
                                  "Select incorrect",
                                  LogAction.FeedbackSelectOptionVideo));
                              setState(() {
                                option = VideoOption.incorrect;
                              });
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            decoration: BoxDecoration(
                              color: option == VideoOption.incorrect
                                  ? lightBlue
                                  : Colors.white,
                            ),
                            child: Text("Incorrect",
                                textAlign: TextAlign.center,
                                style: kTextStyleOption(
                                    option == VideoOption.incorrect)),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            if (option != VideoOption.gemist) {
                              addFeedbackLog(FBLog(
                                  DateTime.now(),
                                  "Select gemist",
                                  LogAction.FeedbackSelectOptionVideo));
                              setState(() {
                                option = VideoOption.gemist;
                              });
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            decoration: BoxDecoration(
                              color: option == VideoOption.gemist
                                  ? lightBlue
                                  : Colors.white,
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(20),
                                  bottomRight: Radius.circular(20)),
                            ),
                            child: Text(
                              "Gemist",
                              textAlign: TextAlign.center,
                              style: kTextStyleOption(
                                  option == VideoOption.gemist),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : Container(),
          Expanded(
              child: videoBlocks.isEmpty
                  ? Center(
                      child: Text("Er zijn geen observaties om weer te geven.",
                          style: TextStyle(color: greyText)))
                  : ListView(
                      children: videoBlocks,
                    )),
          /*Expanded(
            child: GridView.count(
              childAspectRatio: 0.75,
              padding: EdgeInsets.all(8),
              crossAxisSpacing: 15,
              mainAxisSpacing: 30,
              crossAxisCount: 2,
              children: getVideoBlocks(option, videoFeedbacks),
            ),
          ),*/
        ],
      ),
    );
  }
}

class OctantVideoResultScreen extends StatelessWidget {
  OctantVideoResultScreen({@required this.octant});
  final Octant octant;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(octant.name + " Video's"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: VideoResultScreen(octant),
      ),
    );
  }
}

List<Widget> getVideoBlocks(VideoOption option, List<FeedbackObservation> fbs) {
  List<Widget> result = [];
  List<FeedbackObservation> filteredFeedbacks = [];
  if (option == VideoOption.chronologisch || option == VideoOption.passief)
    filteredFeedbacks = fbs;
  if (option == VideoOption.correct)
    filteredFeedbacks = fbs
        .where((e) =>
            e.feedback == FeedbackOption.correct ||
            e.feedback == FeedbackOption.deelsCorrect)
        .toList();
  if (option == VideoOption.incorrect)
    filteredFeedbacks =
        fbs.where((e) => e.feedback == FeedbackOption.incorrect).toList();
  if (option == VideoOption.gemist)
    filteredFeedbacks = fbs
        .where((e) =>
            e.feedback != FeedbackOption.correct &&
            e.feedback != FeedbackOption.deelsCorrect &&
            e.feedback != FeedbackOption.incorrect)
        .toList();
  for (FeedbackObservation obs in filteredFeedbacks) {
    Widget block = option == VideoOption.passief
        ? PassiveVideoBlock(obs)
        : VideoBlock(obs);
    result.add(block);
  }
  return result;
}

class VideoBlock extends StatelessWidget {
  final FeedbackObservation o;
  VideoBlock(this.o);
  Color c;
  IconData i;
  @override
  Widget build(BuildContext context) {
    Quadrant quadrant;
    Octant octant;
    if (o.feedback == FeedbackOption.gemist ||
        o.feedback == FeedbackOption.passief) {
      quadrant = o.getSolObs().getQuadrant();
      octant = o.getSolObs().getOctant();
    } else {
      quadrant = o.getUserObs().getQuadrant();
      octant = o.getUserObs().getOctant();
    }
    if (o.feedback == FeedbackOption.correct) {
      c = Colors.green;
      i = Icons.check_circle_outline;
    } else if (o.feedback == FeedbackOption.incorrect) {
      c = darkRed;
      i = Icons.highlight_off;
    } else if (o.feedback == FeedbackOption.deelsCorrect) {
      c = ownYellow;
      i = Icons.flaky;
    } else if (o.feedback == FeedbackOption.gemist) {
      c = Colors.black54;
      i = Icons.help_outline;
    } else {
      c = lightBlue;
      i = Icons.help_outline;
    }
    return GestureDetector(
      onTap: () {
        String extraInfo = o.getStartTimeFragment().toString() +
            " - " +
            quadrant.name +
            " - " +
            octant.name;
        addFeedbackLog(
            FBLog(DateTime.now(), extraInfo, LogAction.FeedbackSelectVideo));
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => VideoScreen(
                      feedback: o,
                    )));
      },
      child: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: c, width: 3),
        ),
        child: Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(o.getStartTimeFragment().toString().substring(0, 7)),
                Icon(
                  Icons.info_outline,
                  color: greyText,
                  size: 30,
                ),
              ],
            ),
            Container(
              width: 160,
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    quadrant.name,
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    octant.name,
                    style: TextStyle(fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                  mainAxisAlignment: o.feedback == FeedbackOption.incorrect
                      ? MainAxisAlignment.center
                      : o.feedback == FeedbackOption.gemist
                          ? MainAxisAlignment.end
                          : MainAxisAlignment.start,
                  children: [
                    Icon(
                      i,
                      color: c,
                      size: 40,
                    ),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}

class PassiveVideoBlock extends StatelessWidget {
  PassiveVideoBlock(this.observation);
  final FeedbackObservation observation;

  @override
  Widget build(BuildContext context) {
    Quadrant quadrant = observation.getSolObs().getQuadrant();
    Octant octant = observation.getSolObs().getOctant();
    return GestureDetector(
      onTap: () {
        String extraInfo = observation.getStartTimeFragment().toString() +
            " - " +
            quadrant.name +
            " - " +
            octant.name;
        addFeedbackLog(
            FBLog(DateTime.now(), extraInfo, LogAction.FeedbackSelectVideo));
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => VideoScreen(
                      feedback: observation,
                    )));
      },
      child: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: lightBlue, width: 3),
        ),
        child: Row(
          children: [
            Icon(
              Icons.info_outline,
              color: greyText,
              size: 35,
            ),
            Expanded(
                child: Center(
              child: Text(observation
                  .getStartTimeFragment()
                  .toString()
                  .substring(0, 7)),
            )),
            Expanded(
              flex: 2,
              child: Text(
                quadrant.name,
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                octant.name,
                style: TextStyle(fontSize: 14),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/*
class VideoBlock extends StatelessWidget {
  final FeedbackObservation o;
  VideoBlock(this.o);
  Color c;
  IconData i;
  @override
  Widget build(BuildContext context) {
    Quadrant quadrant;
    Octant octant;
    if (o.feedback == FeedbackOption.gemist ||
        o.feedback == FeedbackOption.passief) {
      quadrant = o.getSolObs().getQuadrant();
      octant = o.getSolObs().getOctant();
    } else {
      quadrant = o.getUserObs().getQuadrant();
      octant = o.getUserObs().getOctant();
    }
    if (o.feedback == FeedbackOption.correct) {
      c = Colors.green;
      i = Icons.check_circle_outline;
    } else if (o.feedback == FeedbackOption.incorrect) {
      c = darkRed;
      i = Icons.highlight_off;
    } else if (o.feedback == FeedbackOption.deelsCorrect) {
      c = ownYellow;
      i = Icons.flaky;
    } else if (o.feedback == FeedbackOption.gemist) {
      c = Colors.black54;
      i = Icons.help_outline;
    } else {
      c = lightBlue;
      i = Icons.help_outline;
    }
    return GestureDetector(
      onTap: () {
        String extraInfo = o.getStartTimeFragment().toString() +
            " - " +
            quadrant.name +
            " - " +
            octant.name;
        addFeedbackLog(
            FBLog(DateTime.now(), extraInfo, LogAction.FeedbackSelectVideo));
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => VideoScreen(
                      feedback: o,
                    )));
      },
      child: Container(
        padding: EdgeInsets.all(3),
        decoration: BoxDecoration(
          border: Border.all(color: c, width: 3),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(i, color: c),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child:
                      Text(o.getStartTimeFragment().toString().substring(0, 7)),
                )
              ],
            ),
            Expanded(
              flex: 2,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      quadrant.name,
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      octant.name,
                      style: TextStyle(fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Icon(
                  Icons.info_outline,
                  color: greyText,
                  size: 30,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
*/
