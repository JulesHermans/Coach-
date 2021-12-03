import 'package:chewie/chewie.dart';
import 'package:coachthecoach/Data/ResultData.dart';
import 'package:coachthecoach/Data/sessionData.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

import '../constants.dart';

String durationToStrin(Duration d) {
  print(d);
  return d.toString().substring(0, 7);
}

class VideoScreen extends StatelessWidget {
  VideoScreen({@required this.feedback});
  final FeedbackObservation feedback;

  @override
  Widget build(BuildContext context) {
    Duration start = feedback.getStartTimeFragment();
    Duration end = feedback.getEndTimeFragment();
    String durationString = "(" +
        start.toString().substring(0, 7) +
        " - " +
        end.toString().substring(0, 7) +
        ")";
    Color c;
    Padding _getTextUitlegWidget(String uitleg) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Text(
          uitleg,
          textAlign: TextAlign.center,
          style: TextStyle(color: greyText, fontSize: 15),
        ),
      );
    }

    List<Widget> feedbackWidgets = [
      Padding(
        padding: EdgeInsets.symmetric(vertical: 10.0),
        child: VideoYoutubePlayer(
          start: start,
          end: end,
          sessionNr: getSessionNr(),
        ),
      ),
    ];
    if (feedback.feedback == FeedbackOption.correct) {
      c = Colors.green;
      feedbackWidgets.add(SubTitle(title: "Jouw observatie"));
      feedbackWidgets.add(
          ObservationContainer(observation: feedback.getUserObs(), color: c));
      feedbackWidgets.add(_getTextUitlegWidget(
          "Bovenstaande observatie heb je correct herkend in dit fragment."));
    } else if (feedback.feedback == FeedbackOption.incorrect) {
      c = darkRed;
      feedbackWidgets.add(SubTitle(title: "Jouw observatie"));
      feedbackWidgets.add(
          ObservationContainer(observation: feedback.getUserObs(), color: c));
      feedbackWidgets.add(_getTextUitlegWidget(
          "Bovenstaande observatie heb je niet correct herkend in dit fragment. Onderstaande oplossingen zaten in het fragment. "));
      feedbackWidgets.add(SubTitle(title: "Oplossingen"));
      feedbackWidgets.addAll(getSolutionContainers(feedback, c));
    } else if (feedback.feedback == FeedbackOption.deelsCorrect) {
      c = ownYellow;
      feedbackWidgets.add(SubTitle(title: "Jouw observatie"));
      feedbackWidgets.add(
          ObservationContainer(observation: feedback.getUserObs(), color: c));
      feedbackWidgets.add(_getTextUitlegWidget(
          "In bovenstaande observatie heb je enkel de bouwsteen fout herkend."));
      feedbackWidgets.add(
          ObservationContainer(observation: feedback.getSolObs(), color: c));
    } else if (feedback.feedback == FeedbackOption.gemist) {
      c = Colors.black54;
      feedbackWidgets.add(SubTitle(title: "Gemiste observatie"));
      feedbackWidgets.add(
          ObservationContainer(observation: feedback.getSolObs(), color: c));
      feedbackWidgets.add(_getTextUitlegWidget(
          "Bovenstaande observatie heb je gemist in het fragment."));
    } else if (feedback.feedback == FeedbackOption.passief) {
      c = lightBlue;
      feedbackWidgets.add(SubTitle(title: "Oplossingen"));
      feedbackWidgets.addAll(getSolutionContainers(feedback, c));
    }
    return Scaffold(
        appBar: AppBar(
          leading: ButtonBack(false),
          title: Text("Video"),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: feedbackWidgets,
          ),
        ));
  }
}

class VideoYoutubePlayer extends StatefulWidget {
  VideoYoutubePlayer(
      {@required this.start, @required this.end, @required this.sessionNr});
  final Duration start;
  final Duration end;
  final int sessionNr;
  @override
  _VideoYoutubePlayerState createState() => _VideoYoutubePlayerState();
}

class _VideoYoutubePlayerState extends State<VideoYoutubePlayer> {
  YoutubePlayerController _vidController;
  @override
  void initState() {
    int nr = widget.sessionNr;
    String videoID = videoUrlID["vid$nr"];
    _vidController = YoutubePlayerController(
        initialVideoId: videoID,
        params: YoutubePlayerParams(
          //privacyEnhanced: true,
          startAt: widget.start,
          endAt: widget.start == widget.end ? null : widget.end,
        ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerControllerProvider(
        controller: _vidController, child: YoutubePlayerIFrame());
  }
}

List<Widget> getSolutionContainers(FeedbackObservation feedback, Color c) {
  List<Widget> result = [];
  Duration timing = feedback.solObservation.getTime();
  print(solutionObservations);
  print(timing);
  print(feedback.solObservation);

  for (SolutionObservation o in solutionObservations[timing]) {
    result.add(ObservationContainer(observation: o));
  }
  return result;
}

/*
class VideoChewiePlayer extends StatefulWidget {
  VideoChewiePlayer({@required this.start, @required this.end});
  final Duration start;
  final Duration end;
  @override
  _VideoChewiePlayerState createState() => _VideoChewiePlayerState();
}

class _VideoChewiePlayerState extends State<VideoChewiePlayer> {
  VideoPlayerController _vidController;
  ChewieController _chewieController;

  Future<void> initializeControllers() async {
    int nr = getSessionNr();
    _vidController = VideoPlayerController.asset('Videos/CTCvid$nr.mp4');
    _vidController.initialize();
    setState(() {
      _chewieController = ChewieController(
        videoPlayerController: _vidController,
        aspectRatio: 16 / 9,
        autoInitialize: true,
        autoPlay: true,
        startAt: widget.start,
        showControls: true,
        showControlsOnInitialize: true,
      );
    });
  }

  @override
  void initState() {
    initializeControllers();
    super.initState();
  }

  @override
  void dispose() {
    _vidController.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _chewieController != null //&&
        //_chewieController.videoPlayerController.value.isInitialized
        ? Container(
            height: 250,
            child: Chewie(
              controller: _chewieController,
            ),
          )
        : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              CircularProgressIndicator(),
              SizedBox(height: 20),
              Text('Loading'),
            ],
          );
  }
}
*/
/*
class SubSubTitle extends StatelessWidget {
  SubSubTitle({@required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text,
            style: TextStyle(
              color: greyText,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          Divider(
            thickness: 2,
            color: accentDarkBlue,
            height: 1,
            indent: 0,
            endIndent: 145,
          ),
        ],
      ),
    );
  }
}
*/
class ObservationContainer extends StatelessWidget {
  ObservationContainer({@required this.observation, this.color});
  final Color color;
  final dynamic observation;

  @override
  Widget build(BuildContext context) {
    BoxDecoration decoration;
    if (color == null)
      decoration = kVisualButtonDecoration;
    else
      decoration = BoxDecoration(
        border: Border.all(color: color, width: kThicknessCompass),
        borderRadius: BorderRadius.circular(20),
      );
    print(observation.getBuildingBlock());
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      padding: EdgeInsets.symmetric(vertical: 5),
      decoration: decoration,
      child: Column(
        children: [
          Text(
            observation.getQuadrant().toString() +
                " - " +
                observation.getOctant().name,
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.w500, color: darkBlue),
          ),
          SizedBox(height: 5),
          Text(observation.getBuildingBlock()),
          observation is SolutionObservation &&
                  observation.getExtraSolBuildingBlock() != null
              ? Text(observation.getExtraSolBuildingBlock())
              : Container(),
          SizedBox(height: 10),
          observation is SolutionObservation
              ? Text(
                  "Gedrag begint op " +
                      durationToString(observation.getBehaviourTS()),
                  style: TextStyle(fontWeight: FontWeight.w500))
              : Text(
                  "Gedrag ingegeven op " +
                      durationToString(observation.getTime()),
                  style: TextStyle(fontWeight: FontWeight.w500))
        ],
      ),
    );
  }
}
