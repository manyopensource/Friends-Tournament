class Tournament {
  String id;
  String name;
  int playersNumber;
  int playersAstNumber;
  int matchesNumber;
  // 0 inactive, 1 active
  int isActive;

  Tournament(this.id, this.name, this.playersNumber, this.playersAstNumber,
      this.matchesNumber, this.isActive);
}