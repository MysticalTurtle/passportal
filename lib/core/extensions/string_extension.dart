extension StringX on String {
  String toTitleCase() {
    return this[0].toUpperCase() + substring(1);
  }

  String toStats() {
    switch (this) {
      case 'hp':
        return 'HP';
      case 'attack':
        return 'ATK';
      case 'defense':
        return 'DEF';
      case 'special-attack':
        return 'SATK';
      case 'special-defense':
        return 'SDEF';
      case 'speed':
        return 'SPD';
      default:
        return this;
    }
  }

  String removeNewLines() {
    return replaceAll('\n', ' ');
  }
}
