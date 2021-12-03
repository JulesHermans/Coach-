import 'dart:convert';
import 'dart:math';
import 'package:coachthecoach/Data/sessionData.dart';
import 'package:coachthecoach/constants.dart';
import 'package:coachthecoach/libary.dart';
import 'package:coachthecoach/networking.dart';

List<Observation> userObservations = [];
Map<Duration, List<SolutionObservation>> solutionObservations = {};
int nbSolutions = 0;
Map<Octant, double> obsOctantRadius = {
  autonomySupport.octants[0]: 0,
  autonomySupport.octants[1]: 0,
  chaos.octants[0]: 0,
  chaos.octants[1]: 0,
  structure.octants[0]: 0,
  structure.octants[1]: 0,
  control.octants[0]: 0,
  control.octants[1]: 0,
};
Map<Octant, double> solOctantRadius = {
  autonomySupport.octants[0]: 0,
  autonomySupport.octants[1]: 0,
  chaos.octants[0]: 0,
  chaos.octants[1]: 0,
  structure.octants[0]: 0,
  structure.octants[1]: 0,
  control.octants[0]: 0,
  control.octants[1]: 0,
};
Map<Octant, Map<FeedbackOption, int>> octantFeedbackNbs = {
  autonomySupport.octants[0]: {
    FeedbackOption.gemist: 0,
    FeedbackOption.correct: 0,
    FeedbackOption.incorrect: 0,
    FeedbackOption.deelsCorrect: 0,
  },
  autonomySupport.octants[1]: {
    FeedbackOption.gemist: 0,
    FeedbackOption.correct: 0,
    FeedbackOption.incorrect: 0,
    FeedbackOption.deelsCorrect: 0,
  },
  chaos.octants[0]: {
    FeedbackOption.gemist: 0,
    FeedbackOption.correct: 0,
    FeedbackOption.incorrect: 0,
    FeedbackOption.deelsCorrect: 0,
  },
  chaos.octants[1]: {
    FeedbackOption.gemist: 0,
    FeedbackOption.correct: 0,
    FeedbackOption.incorrect: 0,
    FeedbackOption.deelsCorrect: 0,
  },
  structure.octants[0]: {
    FeedbackOption.gemist: 0,
    FeedbackOption.correct: 0,
    FeedbackOption.incorrect: 0,
    FeedbackOption.deelsCorrect: 0,
  },
  structure.octants[1]: {
    FeedbackOption.gemist: 0,
    FeedbackOption.correct: 0,
    FeedbackOption.incorrect: 0,
    FeedbackOption.deelsCorrect: 0,
  },
  control.octants[0]: {
    FeedbackOption.gemist: 0,
    FeedbackOption.correct: 0,
    FeedbackOption.incorrect: 0,
    FeedbackOption.deelsCorrect: 0,
  },
  control.octants[1]: {
    FeedbackOption.gemist: 0,
    FeedbackOption.correct: 0,
    FeedbackOption.incorrect: 0,
    FeedbackOption.deelsCorrect: 0,
  },
};
Map<Octant, int> obsOctantNumbers = {
  autonomySupport.octants[0]: 0,
  autonomySupport.octants[1]: 0,
  chaos.octants[0]: 0,
  chaos.octants[1]: 0,
  structure.octants[0]: 0,
  structure.octants[1]: 0,
  control.octants[0]: 0,
  control.octants[1]: 0,
};
Map<Octant, int> solOctantNumbers = {
  autonomySupport.octants[0]: 0,
  autonomySupport.octants[1]: 0,
  chaos.octants[0]: 0,
  chaos.octants[1]: 0,
  structure.octants[0]: 0,
  structure.octants[1]: 0,
  control.octants[0]: 0,
  control.octants[1]: 0,
};
List<FeedbackObservation> feedbacks = [];

void resetAllFeedbackNumbers() {
  feedbacks = [];
  octantFeedbackNbs = {
    autonomySupport.octants[0]: {
      FeedbackOption.gemist: 0,
      FeedbackOption.correct: 0,
      FeedbackOption.incorrect: 0,
      FeedbackOption.deelsCorrect: 0,
    },
    autonomySupport.octants[1]: {
      FeedbackOption.gemist: 0,
      FeedbackOption.correct: 0,
      FeedbackOption.incorrect: 0,
      FeedbackOption.deelsCorrect: 0,
    },
    chaos.octants[0]: {
      FeedbackOption.gemist: 0,
      FeedbackOption.correct: 0,
      FeedbackOption.incorrect: 0,
      FeedbackOption.deelsCorrect: 0,
    },
    chaos.octants[1]: {
      FeedbackOption.gemist: 0,
      FeedbackOption.correct: 0,
      FeedbackOption.incorrect: 0,
      FeedbackOption.deelsCorrect: 0,
    },
    structure.octants[0]: {
      FeedbackOption.gemist: 0,
      FeedbackOption.correct: 0,
      FeedbackOption.incorrect: 0,
      FeedbackOption.deelsCorrect: 0,
    },
    structure.octants[1]: {
      FeedbackOption.gemist: 0,
      FeedbackOption.correct: 0,
      FeedbackOption.incorrect: 0,
      FeedbackOption.deelsCorrect: 0,
    },
    control.octants[0]: {
      FeedbackOption.gemist: 0,
      FeedbackOption.correct: 0,
      FeedbackOption.incorrect: 0,
      FeedbackOption.deelsCorrect: 0,
    },
    control.octants[1]: {
      FeedbackOption.gemist: 0,
      FeedbackOption.correct: 0,
      FeedbackOption.incorrect: 0,
      FeedbackOption.deelsCorrect: 0,
    },
  };
  nbSolutions = 0;
  obsOctantNumbers = {
    autonomySupport.octants[0]: 0,
    autonomySupport.octants[1]: 0,
    chaos.octants[0]: 0,
    chaos.octants[1]: 0,
    structure.octants[0]: 0,
    structure.octants[1]: 0,
    control.octants[0]: 0,
    control.octants[1]: 0,
  };
  solOctantNumbers = {
    autonomySupport.octants[0]: 0,
    autonomySupport.octants[1]: 0,
    chaos.octants[0]: 0,
    chaos.octants[1]: 0,
    structure.octants[0]: 0,
    structure.octants[1]: 0,
    control.octants[0]: 0,
    control.octants[1]: 0,
  };
  obsOctantRadius = {
    autonomySupport.octants[0]: 0,
    autonomySupport.octants[1]: 0,
    chaos.octants[0]: 0,
    chaos.octants[1]: 0,
    structure.octants[0]: 0,
    structure.octants[1]: 0,
    control.octants[0]: 0,
    control.octants[1]: 0,
  };
  solOctantRadius = {
    autonomySupport.octants[0]: 0,
    autonomySupport.octants[1]: 0,
    chaos.octants[0]: 0,
    chaos.octants[1]: 0,
    structure.octants[0]: 0,
    structure.octants[1]: 0,
    control.octants[0]: 0,
    control.octants[1]: 0,
  };
}

enum FeedbackOption { correct, deelsCorrect, incorrect, gemist, passief }
enum SolutionTypeOption {
  primary,
  extra1,
  extra2,
  extra3,
}

class FeedbackObservation {
  FeedbackObservation(
      {this.feedback, this.userObservation, this.solObservation});
  final FeedbackOption feedback;
  final Observation userObservation;
  final SolutionObservation solObservation;
  Observation getUserObs() {
    if (feedback != FeedbackOption.gemist) return userObservation;
  }

  SolutionObservation getSolObs() {
    if (feedback != FeedbackOption.incorrect) return solObservation;
  }

  Duration getStartTimeFragment() {
    return solObservation.getTime();
  }

  Duration getEndTimeFragment() {
    Duration start = solObservation.getTime();
    print(start);
    if (start == solutionObservations.keys.last) return start;
    int indexStart = solutionObservations.keys.toList().indexOf(start);
    return solutionObservations.keys.toList()[indexStart + 1];
  }

  Duration getTimeUserObservation() {
    return userObservation.getTime();
  }

  bool hasOctant(Octant o) {
    if (feedback == FeedbackOption.gemist || feedback == FeedbackOption.passief)
      return solObservation.getOctant() == o;
    else if (feedback == FeedbackOption.incorrect)
      return userObservation.getOctant() == o;
    return userObservation.getOctant() == o || solObservation.getOctant() == o;
  }
}

class SolutionObservation extends Observation {
  SolutionTypeOption _type;
  String _extraSolutionBuildingBlock;
  //dit is de timestamp van het effectieve gedrag binnen het fragment,
  // de TIME parameter van observation is de start van het fragment waar de solution observation in voorkomt.
  Duration _startBehaviourTS;
  SolutionObservation(SolutionTypeOption t)
      : _type = t,
        super();

  void setBehaviourTS(Duration d) {
    _startBehaviourTS = d;
  }

  Duration getBehaviourTS() {
    return _startBehaviourTS;
  }

  SolutionTypeOption getType() {
    return _type;
  }

  void setExtraSolBuildingBlock(String bb) {
    if (this.getOctant().buildingBlocks.contains(bb))
      _extraSolutionBuildingBlock = bb;
  }

  String getExtraSolBuildingBlock() {
    return _extraSolutionBuildingBlock;
  }
}

List<FeedbackObservation> _createActiveFeedbacks() {
  List<FeedbackObservation> result = [];
  List<Duration> timestamps = solutionObservations.keys.toList();
  timestamps.sort();
  int solNb = 0;
  int obsNb = 0;
  Duration currentTimestamp = timestamps[0];
  Duration nextTimestamp = timestamps[1];
  List<SolutionObservation> currentSolObservations =
      solutionObservations[currentTimestamp];
  List<bool> notMissed = List(currentSolObservations.length)
      .map((e) => false)
      .toList(growable: false);
  Observation currentObservation;
  bool end = false;
  for (obsNb; obsNb < userObservations.length; obsNb++) {
    currentObservation = userObservations[obsNb];
    FeedbackOption feedbackType;
    if (currentObservation.getTime() < timestamps[0])
      continue;
    else if (end ||
        currentTimestamp <= currentObservation.getTime() &&
            currentObservation.getTime() <= nextTimestamp) {
      for (int i = 0; i < currentSolObservations.length; i++) {
        SolutionObservation sol = currentSolObservations[i];
        if (sol.getQuadrant() == currentObservation.getQuadrant() &&
            sol.getOctant() == currentObservation.getOctant()) {
          if (sol.getBuildingBlock() == currentObservation.getBuildingBlock() ||
              sol.getExtraSolBuildingBlock() ==
                  currentObservation.getBuildingBlock()) {
            feedbackType = FeedbackOption.correct;
          } else {
            feedbackType = FeedbackOption.deelsCorrect;
          }
          notMissed[i] = true;
          octantFeedbackNbs[sol.getOctant()][FeedbackOption.correct]++;
          result.add(FeedbackObservation(
              feedback: feedbackType,
              userObservation: currentObservation,
              solObservation: sol));
          break;
        }
      }
      if (feedbackType == null) {
        feedbackType = FeedbackOption.incorrect;
        octantFeedbackNbs[currentObservation.getOctant()][feedbackType]++;
        result.add(FeedbackObservation(
            feedback: feedbackType,
            userObservation: currentObservation,
            solObservation: currentSolObservations[0]));
      }
    } else if (currentObservation.getTime() > nextTimestamp) {
      for (int i = 0; i < notMissed.length; i++) {
        bool b = notMissed[i];
        if (!b) {
          result.add(FeedbackObservation(
              feedback: FeedbackOption.gemist,
              userObservation: null,
              solObservation: currentSolObservations[i]));
          octantFeedbackNbs[currentSolObservations[i].getOctant()]
              [FeedbackOption.gemist]++;
        }
      }
      obsNb--;
      if (solNb >= solutionObservations.length - 2) {
        end = true;
        currentSolObservations = solutionObservations[timestamps.last];
      } else {
        solNb++;
        currentTimestamp = nextTimestamp;
        nextTimestamp = timestamps[solNb + 1];
        currentSolObservations = solutionObservations[currentTimestamp];
      }
      notMissed = List(currentSolObservations.length)
          .map((e) => false)
          .toList(growable: false);
    }
  }
  if (currentSolObservations != solutionObservations[timestamps.last]) {
    for (int i = 0; i < notMissed.length; i++) {
      bool b = notMissed[i];
      if (!b) {
        result.add(FeedbackObservation(
            feedback: FeedbackOption.gemist,
            userObservation: null,
            solObservation: currentSolObservations[i]));
        octantFeedbackNbs[currentSolObservations[i].getOctant()]
            [FeedbackOption.gemist]++;
      }
    }
    int i = timestamps.indexOf(currentTimestamp) + 1;
    for (i; i < timestamps.length; i++) {
      currentSolObservations = solutionObservations[timestamps[i]];
      for (SolutionObservation s in currentSolObservations) {
        result.add(FeedbackObservation(
            feedback: FeedbackOption.gemist,
            userObservation: null,
            solObservation: s));
        octantFeedbackNbs[s.getOctant()][FeedbackOption.gemist]++;
      }
    }
  }

  return result;
}

Future<void> createFeedbackData(bool isActiveVersion, String vidKey) async {
  String solServer = await getSol(vidKey);
  print(vidKey);
  List<dynamic> jsonSol = jsonDecode(solServer);
  solutionObservations = jsonToSol(jsonSol);
/*
  String obsServer = await getObs();
  List<dynamic> jsonObs = jsonDecode(obsServer);
  userObservations = jsonToObs(jsonObs);
*/
  if (isActiveVersion) userObservations = obsSes.observations;
  _countNumbers(isActiveVersion);
  print(obsOctantRadius);
  if (isActiveVersion) {
    feedbacks = _createActiveFeedbacks();
  } else {
    for (Duration d in solutionObservations.keys) {
      for (SolutionObservation o in solutionObservations[d]) {
        FeedbackObservation feedback = FeedbackObservation(
            feedback: FeedbackOption.passief,
            userObservation: null,
            solObservation: o);
        feedbacks.add(feedback);
      }
    }
    print(feedbacks);
  }
}

void _countNumbers(bool isActiveVersion) {
  if (solutionObservations.isEmpty) {
    print("Eerst observations invullen in lijsten");
  }
  Observation obs;
  if (isActiveVersion) {
    for (obs in userObservations) {
      obsOctantNumbers[obs.getOctant()]++;
    }
  }
  SolutionObservation sol;
  for (List<SolutionObservation> listSol in solutionObservations.values) {
    for (sol in listSol) {
      nbSolutions++;
      solOctantNumbers[sol.getOctant()]++;
    }
  }
  int maxObservations = userObservations.length > nbSolutions
      ? userObservations.length
      : nbSolutions;
  for (Octant o in solOctantNumbers.keys) {
    solOctantRadius[o] = (solOctantNumbers[o] / maxObservations);
    if (isActiveVersion)
      obsOctantRadius[o] = (obsOctantNumbers[o] / maxObservations);
  }
}

List<String> calculateOctantFeedback(ResultOption option, Quadrant quadrant) {
  List<String> result = new List(2);
  if (option == ResultOption.Oplossing) {
    result[0] = solOctantNumbers[quadrant.octants[0]].toString();
    result[1] = solOctantNumbers[quadrant.octants[1]].toString();
  } else if (option == ResultOption.Observaties) {
    result[0] = obsOctantNumbers[quadrant.octants[0]].toString();
    result[1] = obsOctantNumbers[quadrant.octants[1]].toString();
  } else {
    if ((obsOctantNumbers[quadrant.octants[0]] -
            solOctantNumbers[quadrant.octants[0]]) >=
        0) {
      result[0] = "+" +
          (obsOctantNumbers[quadrant.octants[0]] -
                  solOctantNumbers[quadrant.octants[0]])
              .toString();
    } else {
      result[0] = (obsOctantNumbers[quadrant.octants[0]] -
              solOctantNumbers[quadrant.octants[0]])
          .toString();
    }
    if ((obsOctantNumbers[quadrant.octants[1]] -
            solOctantNumbers[quadrant.octants[1]]) >=
        0) {
      result[1] = "+" +
          (obsOctantNumbers[quadrant.octants[1]] -
                  solOctantNumbers[quadrant.octants[1]])
              .toString();
    } else {
      result[1] = (obsOctantNumbers[quadrant.octants[1]] -
              solOctantNumbers[quadrant.octants[1]])
          .toString();
    }
  }
  return result;
}

double calculatePercentageRadius() {
  double maxPercentageSol = solOctantRadius.values.reduce(max);
  double maxPercentageObs = obsOctantRadius.values.reduce(max);
  double maxPercentage = max(maxPercentageObs, maxPercentageSol);
  double percentage = (maxPercentage * 10).ceil().toDouble() / 10;
  if (percentage == maxPercentage) percentage += 0.03;
  return percentage;
}

List<Observation> jsonToObs(List<dynamic> observations) {
  List<Observation> result = [];
  for (var obs in observations) {
    Observation o = Observation();
    Quadrant q = stringToQuadrant(obs["QUADRANT"]);
    Octant oct = stringToOctant(q, obs["OCTANT"]);
    o.setQuadrant(q);
    o.setOctant(oct);
    o.setBuildingBlock(obs["BuildingBlock"]);
    Duration d = parseDuration(obs["TIMESTAMP"]);
    o.setTime(d);
    result.add(o);
  }
  return result;
}

Map<Duration, List<SolutionObservation>> jsonToSol(List<dynamic> json) {
  Map<Duration, List<SolutionObservation>> result = {};
  for (var obs in json) {
    List<SolutionObservation> timestampObs = [];
    Duration d = parseDuration(obs["TIMESTAMP"]);
    SolutionObservation primary =
        SolutionObservation(SolutionTypeOption.primary);
    primary.setTime(d);
    Quadrant primQ = stringToQuadrant(obs["PrimaryQuadrant"]);
    Octant primO = stringToOctant(primQ, obs["PrimaryOctant"]);
    primary.setQuadrant(primQ);
    primary.setOctant(primO);
    primary.setBuildingBlock(obs["PrimaryBB1"]);
    primary.setExtraSolBuildingBlock(obs["PrimaryBB2"]);
    Duration primTS = parseDuration(obs["TSPRIM"]);
    primary.setBehaviourTS(primTS);
    timestampObs.add(primary);
    for (int i = 1; i < 4; i++) {
      if (obs["ExtraQuadrant$i"] != "") {
        SolutionObservation extra =
            SolutionObservation(SolutionTypeOption.values[i]);
        extra.setTime(d);
        Quadrant q = stringToQuadrant(obs["ExtraQuadrant$i"]);
        Octant o = stringToOctant(q, obs["ExtraOctant$i"]);
        extra.setQuadrant(q);
        extra.setOctant(o);
        extra.setBuildingBlock(obs["Extra$i" + "BB1"]);
        extra.setExtraSolBuildingBlock(obs["Extra$i" + "BB2"]);
        Duration extraTS = parseDuration(obs["TSEXTRA$i"]);
        extra.setBehaviourTS(extraTS);
        timestampObs.add(extra);
      } else
        break;
    }
    result[d] = timestampObs;
  }
  return result;
}

Duration parseDuration(String s) {
  List<String> parts = s.split(":");
  int hours = int.parse(parts[0]);
  int mins = int.parse(parts[1]);
  int secs = int.parse(parts[2]);
  return Duration(hours: hours, minutes: mins, seconds: secs);
}
