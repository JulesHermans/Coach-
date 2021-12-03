import 'package:coachthecoach/FlowScreens/EndScreen.dart';
import 'package:coachthecoach/constants.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'package:coachthecoach/libary.dart';

_FeedbackSession _userSession;
ObservationSession obsSes;

int getUserId() {
  return _userSession.getUserId();
}

int getSessionNr() {
  return _userSession.sessionNr;
}

void resetSession() {
  _userSession.sessionNr--;
}

bool isActiveVersion() {
  return _userSession._isActiveVersion;
}

void initSession(int ID) {
  _userSession = new _FeedbackSession(ID);
  nextFeedbackSession();
}

bool nextFeedbackSession() {
  //return _userSession.startNextSession();
  _userSession.startNewSession();
}

class _FeedbackSession {
  _FeedbackSession(int ID) {
    _userID = ID;
    _isActiveVersion = ID.isEven;
  }

  bool _isActiveVersion;
  int _userID;
  int sessionNr = 0;
  bool isActiveVersion() {
    return _isActiveVersion;
  }

  int getUserId() {
    return _userID;
  }

  void startNewSession() {
    DateTime now = DateTime.now();
    obsSes = new ObservationSession(_userID, now);
  }
  /*bool startNextSession() {
    if (sessionNr >= 3) {
      return false;
    } else {
      sessionNr++;
      if (_isActiveVersion) {
        DateTime now = DateTime.now();
        obsSes = new ObservationSession(_userID, now);
      }
      return true;
    }
  }*/
}

class ObservationSession {
  ObservationSession(this.userID, this.startTime);
  final int userID;
  List<Observation> observations = [];
  Observation newObservation = Observation();
  final DateTime startTime;

  List<Map<String, dynamic>> observationsToJson() {
    List<Map<String, dynamic>> result = [];
    for (Observation o in observations) {
      Map<String, dynamic> jsonObs = {"userID": userID};
      jsonObs.addAll(o.toJson());
      result.add(jsonObs);
    }
    return result;
  }

  void setNewObservation(Observation o) {
    newObservation = o;
  }

  void resetNewObservation() {
    newObservation = Observation();
  }

  void addNewObservation() {
    observations.add(newObservation);
  }

  void deleteObservation(Observation o) {
    observations.remove(o);
  }
}

class Observation {
  Duration _time;
  int _teamScore;
  int _opponentScore;
  Quadrant _quadrantSelected;
  Octant _octantSelected;
  String _buildingBlockSelected;
  Timing _timingSelected;
  Audience _audienceSelected;
  CorType _corTypeSelected;

  Map<String, dynamic> toJson() {
    Map<String, dynamic> result = {
      "time": durationToString(_time),
      "teamScore": _teamScore,
      "opponentScore": _opponentScore,
      "quadrant": _quadrantSelected.toString(),
      "octant": _octantSelected.toString(),
      "buildingBlock": _buildingBlockSelected,
      "timing": enumToString(_timingSelected),
      "audience": enumToString(_audienceSelected),
      "corType": enumToString(_corTypeSelected),
    };
    return result;
  }

  @override
  String toString() {
    return durationToString(_time) +
        '--' +
        _quadrantSelected.toString() +
        '--' +
        _octantSelected.toString();
  }

  //simpele functies voor de time
  void setTime(Duration t) {
    _time = t;
  }

  Duration getTime() {
    return _time;
  }

  //setter voor de score
  void setScore(int team, int opponent) {
    _teamScore = team;
    _opponentScore = opponent;
  }

  //simpele functies voor het quadrant
  void setQuadrant(Quadrant q) {
    _quadrantSelected = q;
  }

  Quadrant getQuadrant() {
    return _quadrantSelected;
  }

  bool isQuadrantSelected() {
    return _quadrantSelected != null;
  }

  //simpele functies voor het octant
  void setOctant(Octant o) {
    if (_quadrantSelected.octants.contains(o)) _octantSelected = o;
  }

  Octant getOctant() {
    return _octantSelected;
  }

  bool isOctantSelected() {
    return _octantSelected != null;
  }

  //simpele functies voor de building block
  void setBuildingBlock(String bb) {
    if (bb == "Verantwoordelijkheid uit de weg gaan/ niet ingrijpen")
      bb = 'Verantwoordelijkheid uit de weg gaan\n/niet ingrijpen';
    if (bb == 'Onverschilligheid/ desinteresse tonen')
      bb = 'Onverschilligheid\n/desinteresse tonen';

    if (_octantSelected.buildingBlocks.contains(bb))
      _buildingBlockSelected = bb;
  }

  String getBuildingBlock() {
    return _buildingBlockSelected;
  }

  bool isBuildingBlockSelected() {
    return _buildingBlockSelected != null;
  }

  //simpele functies voor timing
  void setTiming(Timing t) {
    _timingSelected = t;
  }

  bool isTimingSelected() {
    return _timingSelected != null;
  }

  //simpele functies voor audience
  void setAudience(Audience a) {
    _audienceSelected = a;
  }

  bool isAudienceSelected() {
    return _audienceSelected != null;
  }

  //simpele functies voor correction type
  void setCorType(CorType c) {
    _corTypeSelected = c;
  }

  bool isCorTypeSelected() {
    return _corTypeSelected != null;
  }
}
