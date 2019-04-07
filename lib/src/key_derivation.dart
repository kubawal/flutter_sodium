import 'dart:typed_data';
import '../flutter_sodium.dart';

/// Derive secret subkeys from a single master key.
class KeyDerivation {
  /// Generates a random master key for use with key derivation.
  static Uint8List generateKey() => Sodium.cryptoKdfKeygen();

  /// Derives a subkey from given master key.
  /// When no subKeyLength is provided, a subkey of size Sodium.cryptoKdfBytesMin is derived.
  static Uint8List deriveFromKey(Uint8List masterkey, int subkeyId,
          {int subkeyLength, String context = '00000000'}) =>
      Sodium.cryptoKdfDeriveFromKey(subkeyLength ?? Sodium.cryptoKdfBytesMin,
          subkeyId, context, masterkey);
}
