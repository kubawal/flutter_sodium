import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_sodium/flutter_sodium.dart';

void main() {
  // initialize library
  Sodium.sodiumInit();

  test('randombytesSeedBytes equals 32', () {
    expect(Sodium.randombytesSeedbytes, 32);
  });
  test('randombytesImplementationName equals sysrandom', () {
    expect(Sodium.randombytesImplementationName, 'sysrandom');
  });
  test('randombytesBufDeterministic with invalid seed length should throw', () {
    final seed = Sodium.randombytesBuf(15);
    expect(
        () => Sodium.randombytesBufDeterministic(16, seed), throwsRangeError);
  });
  test('randombytesBufDeterministic with same seed should return same result',
      () {
    final seed = Sodium.randombytesBuf(Sodium.randombytesSeedbytes);
    final r1 = Sodium.randombytesBufDeterministic(16, seed);
    final r2 = Sodium.randombytesBufDeterministic(16, seed);

    expect(r1, r2);
  });
}
