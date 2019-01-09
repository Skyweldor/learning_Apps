class PlayerObject {
  int _id;
  String _name;
  String _description;
  int _strength;
  int _health;

  PlayerObject(this._name, this._strength, this._health, [this._description]);

  PlayerObject.withID(this._id, this._name, this._strength, this._health,
      [this._description]);

  int get id => _id;

  String get name => _name;

  String get description => _description;

  int get strength => _strength;

  int get health => _health;

  set name(String newName) {
    if (newName.length <= 25) {
      _name = newName;
    }
  }

  set strength(int newStrength) {
    if (newStrength > 0) {
      _strength = newStrength;
    }
    _strength = newStrength;
  }

  set health(int newHealth) {
    if (newHealth > 0) {
      _health = newHealth;
    }
  }

  set description(String newDescription) {
    if (newDescription.length <= 255) {
      _description = newDescription;
    }
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["name"] = _name;
    map["description"] = _description;
    map["strength"] = _strength;
    map["health"] = health;
    if (_id != null) {
      map["id"] = _id;
    }
    return map;
  }

  PlayerObject.fromObject(dynamic o) {
    this._id = o["id"];
    this._name = o["name"];
    this._description = o["description"];
    this._strength = o["strength"];
    this._health = o["health"];
  }
}
