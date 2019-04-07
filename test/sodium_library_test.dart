import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_sodium/flutter_sodium.dart';

void main() {
  // initialize library
  Sodium.sodiumInit();

  test('sodiumLibraryVersionMajor equals 10', () {
    expect(Sodium.sodiumLibraryVersionMajor, 10);
  });
  test('sodiumLibraryVersionMinor equals 2', () {
    expect(Sodium.sodiumLibraryVersionMinor, 2);
  });
  test('sodiumLibraryMinimal equals 0', () {
    expect(Sodium.sodiumLibraryMinimal, 0);
  });
  test('sodiumVersionString equals 1.0.17', () {
    expect(Sodium.sodiumVersionString, '1.0.17');
  });
}