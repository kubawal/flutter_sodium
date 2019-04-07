class SodiumException {
  final String message;
  final String source;
  final int result;
  SodiumException(this.message, {this.source, this.result});

  String toString() => message;
}