import 'package:coachthecoach/Data/sessionData.dart';
import 'package:flutter/foundation.dart';
import 'package:coachthecoach/libary.dart';

List<Log> _observationLogBook = [];
List<Log> _feedbackLogBook = [];

void clearLogs(bool obsLogBook) {
  obsLogBook ? _observationLogBook.clear() : _feedbackLogBook.clear();
}

List<Map<String, dynamic>> logsToJson(bool obsLogBook) {
  List<Log> logBook = obsLogBook ? _observationLogBook : _feedbackLogBook;
  List<Map<String, dynamic>> result = [];
  for (Log l in logBook) {
    result.add(l.toJson());
  }
  return result;
}

void addObservationLog(Log l) {
  _observationLogBook.add(l);
}

void addFeedbackLog(FBLog l) {
  _feedbackLogBook.add(l);
}

class Log {
  Log(DateTime time, Object info, LogAction a) {
    timeStamp = time;
    extraInfo = info;
    action = a;
    userID = getUserId();
  }
  LogAction action;
  int userID;
  DateTime timeStamp;
  Object extraInfo;

  Map<String, dynamic> toJson() {
    Map<String, dynamic> result = {
      "timeStamp": timeStamp.toString(),
      "action": describeEnum(action),
      "userID": userID,
    };
    if (extraInfo is String ||
        extraInfo is int ||
        extraInfo is bool ||
        extraInfo == null) {
      result.addAll({"info": extraInfo});
    } else if (extraInfo is Timing ||
        extraInfo is Audience ||
        extraInfo is CorType) {
      result.addAll({"info": describeEnum(extraInfo)});
    } else
      result.addAll({"info": extraInfo.toString()});

    return result;
  }
}

class FBLog extends Log {
  FBLog(
    DateTime time,
    Object info,
    LogAction a,
  ) : super(time, info, a) {
    sessionNr = getSessionNr();
  }
  int sessionNr;

  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> result = {
      "timeStamp": timeStamp.toString(),
      "action": describeEnum(action),
      "userID": userID,
    };
    if (extraInfo is String ||
        extraInfo is int ||
        extraInfo is bool ||
        extraInfo == null) {
      result.addAll({"info": extraInfo});
    } else if (extraInfo is Timing ||
        extraInfo is Audience ||
        extraInfo is CorType) {
      result.addAll({"info": describeEnum(extraInfo)});
    } else
      result.addAll({"info": extraInfo.toString()});

    result.addAll({"sessionNr": sessionNr});

    return result;
  }
}

enum LogAction {
  startSession,
  goToObservations,
  resetObservations,
  changeTeamScore,
  changeOpponentScore,
  selectQuadrant,
  DeleteObservation,
  back,
  selectTiming,
  selectOctant,
  selectBuildingBlock,
  selectAudience,
  selectCorType,
  changeTiming,
  changeOctant,
  changeBuildingBlock,
  changeAudience,
  changeCorType,
  addBehaviour,
  showDialogue,
  finish,
  cancelDialogue,
  confirmFinish,
  FeedbackStart,
  FeedbackSwipeToVideo,
  FeedbackSwipeToOctant,
  FeedbackSelectOptionOctant,
  FeedbackSelectOptionVideo,
  FeedbackSelectOctant,
  FeedbackSelectOctantVideo,
  FeedbackSelectVideo,
  FeedbackEnd,
}
