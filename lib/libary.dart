class Quadrant {
  Quadrant({this.name, this.octants});
  String name;

  @override
  String toString() {
    if (name == 'Autonomie\nond.')
      return 'Autonomie ondersteunend';
    else
      return this.name;
  }

  List<Octant> octants;
}

Quadrant autonomySupport = new Quadrant(
  name: 'Autonomie\nond.',
  octants: _autonomySupportOctants,
);
Quadrant chaos = new Quadrant(
  name: 'Chaos',
  octants: _chaosOctants,
);
Quadrant control = new Quadrant(
  name: 'Controle',
  octants: _controlOctants,
);
Quadrant structure = new Quadrant(
  name: 'Structuur',
  octants: _structureOctants,
);

class Octant {
  Octant({this.name, this.buildingBlocks});
  String name;
  @override
  String toString() {
    return this.name;
  }

  List<String> buildingBlocks;
}

List<Octant> _chaosOctants = [
  Octant(
    name: 'Opgevend',
    buildingBlocks: [
      'Onverschilligheid\n/desinteresse tonen',
      'Beklag doen en wanhoop uitdrukken',
    ],
  ),
  Octant(
    name: 'Afwachtend',
    buildingBlocks: [
      'Verantwoordelijkheid uit de weg gaan\n/niet ingrijpen',
      'Inconsistent handelen',
    ],
  ),
];

List<Octant> _controlOctants = [
  Octant(
    name: 'Eisend',
    buildingBlocks: [
      'Sturend communiceren',
      'Kordaat optreden/ingrijpen',
      'Veeleisend zijn/ niet snel tevreden zijn',
      'Ontgoocheling tonen',
    ],
  ),
  Octant(
    name: 'Dominerend',
    buildingBlocks: [
      'Machtspositie uitoefenen',
      'Schuld/schaamte induceren',
      'Persoonlijk aanvallen/bestraffen',
    ],
  ),
];

List<Octant> _structureOctants = [
  Octant(
    name: 'Begeleidend',
    buildingBlocks: [
      'Passend hulp bieden',
      'Motiverend feedback geven',
      'Zelfstandigheid en zelfinzicht stimuleren',
      'Optimale uitdaging bieden',
    ],
  ),
  Octant(
    name: 'Verduidelijkend',
    buildingBlocks: [
      'Duidelijkheid creëren',
      'Verwachtingen monitoren en managen',
    ],
  ),
];
List<Octant> _autonomySupportOctants = [
  Octant(
    name: 'Participatief',
    buildingBlocks: [
      'Inbreng stimuleren',
      'In dialoog gaan',
    ],
  ),
  Octant(
    name: 'Afstemmend',
    buildingBlocks: [
      'Plezier en succesbeleving stimuleren',
      'Rationale geven',
      'Weerstand erkennen/toestaan',
    ],
  ),
];

Quadrant stringToQuadrant(String input) {
  if (input == 'Autonomie ondersteunend') return autonomySupport;
  if (input == 'Chaos') return chaos;
  if (input == 'Controle') return control;
  if (input == 'Structuur') return structure;
}

Octant stringToOctant(Quadrant q, String octant) {
  for (Octant o in q.octants) {
    if (o.name == octant) return o;
  }
}

enum Timing {
  Wedstrijd,
  TimeOut,
  Tussendoor,
}

enum Audience { Individu, Groep, Team, Andere }
enum CorType { Techniek, Tactiek, Attitude, Andere }
