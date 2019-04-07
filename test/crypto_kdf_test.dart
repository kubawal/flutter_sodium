import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_sodium/flutter_sodium.dart';

void main() {
  // initialize library
  Sodium.sodiumInit();

  test('cryptoKdfBytesMax equals 64', () {
    expect(Sodium.cryptoKdfBytesMax, 64);
  });
  test('cryptoKdfBytesMin equals 16', () {
    expect(Sodium.cryptoKdfBytesMin, 16);
  });
  test('cryptoKdfContextbytes equals 8', () {
    expect(Sodium.cryptoKdfContextbytes, 8);
  });
  test('cryptoKdfKeybytes equals 32', () {
    expect(Sodium.cryptoKdfKeybytes, 32);
  });
  test('cryptoKdfPrimitive equals blake2b', () {
    expect(Sodium.cryptoKdfPrimitive, 'blake2b');
  });
  test('cryptoKdfKeygen should generate key of length 32', () {
    final key = Sodium.cryptoKdfKeygen();
    expect(key.length, 32);
  });
  test('cryptoKdfDeriveFromKey should generate correct key length', () {
    final key = Sodium.cryptoKdfKeygen();
    final ctx = '12345678';

    final subkey = Sodium.cryptoKdfDeriveFromKey(16, 0, ctx, key);
    expect(subkey.length, 16);
  });
  test('cryptoKdfDeriveFromKey with same subkeyId should generate same key',
      () {
    final key = Sodium.cryptoKdfKeygen();
    final ctx = '12345678';

    final subkey1 = Sodium.cryptoKdfDeriveFromKey(16, 42, ctx, key);
    final subkey2 = Sodium.cryptoKdfDeriveFromKey(16, 42, ctx, key);

    expect(subkey1, subkey2);
  });
  test('cryptoKdfDeriveFromKey with key length 16 should throw', () {
    final key = Sodium.randombytesBuf(16);
    final ctx = '12345678';

    expect(
        () => Sodium.cryptoKdfDeriveFromKey(16, 0, ctx, key), throwsRangeError);
  });
  test('cryptoKdfDeriveFromKey with subkeyLen 8 should throw', () {
    final key = Sodium.cryptoKdfKeygen();
    final ctx = '12345678';

    expect(
        () => Sodium.cryptoKdfDeriveFromKey(8, 0, ctx, key), throwsRangeError);
  });
  test('cryptoKdfDeriveFromKey with subkeyLen 65 should throw', () {
    final key = Sodium.cryptoKdfKeygen();
    final ctx = '12345678';

    expect(
        () => Sodium.cryptoKdfDeriveFromKey(65, 0, ctx, key), throwsRangeError);
  });
}
