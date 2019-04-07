import 'dart:ffi';
import 'dart:typed_data';

import 'sodium_exception.dart';
import 'bindings/bindings.dart';
import 'bindings/types.dart';

/// Sodium provides modern, easy-to-use functions for encryption, decryption,
/// signatures, password hashing and more.
class Sodium {
  static void _requireSuccess(int result, String source) {
    if (result != 0) {
      throw SodiumException('$source failed with error $result',
          source: source, result: result);
    }
  }

  //
  // crypto_kdf_*
  //
  static int get cryptoKdfBytesMin => kdfBindings.crypto_kdf_bytes_min();
  static int get cryptoKdfBytesMax => kdfBindings.crypto_kdf_bytes_max();
  static int get cryptoKdfContextbytes => kdfBindings.crypto_kdf_contextbytes();
  static int get cryptoKdfKeybytes => kdfBindings.crypto_kdf_keybytes();
  static String get cryptoKdfPrimitive =>
      CString.fromUtf8(kdfBindings.crypto_kdf_primitive());

  /// Derives a subkey using a master key and a context.
  static Uint8List cryptoKdfDeriveFromKey(
      int subkeyLen, int subkeyId, String ctx, Uint8List key) {
    assert(subkeyLen != null);
    assert(subkeyId != null);
    assert(ctx != null);
    assert(key != null);
    RangeError.checkValueInInterval(subkeyLen, cryptoKdfBytesMin,
        cryptoKdfBytesMax, 'subkeyLen', 'Invalid length');
    RangeError.checkValueInInterval(ctx.length, cryptoKdfContextbytes,
        cryptoKdfContextbytes, 'ctx', 'Invalid length');
    RangeError.checkValueInInterval(key.length, cryptoKdfKeybytes,
        cryptoKdfKeybytes, 'key', 'Invalid length');

    final Pointer<Int8> subkeyPtr = allocate(count: subkeyLen);
    final ctxPtr = toUtf8Pointer(ctx, appendNull: false);
    final keyPtr = toListPointer(key);

    try {
      _requireSuccess(
          kdfBindings.crypto_kdf_derive_from_key(
              subkeyPtr, subkeyLen, subkeyId, ctxPtr, keyPtr),
          'crypto_kdf_derive_from_key');
      return toUint8List(subkeyPtr, subkeyLen);
    } finally {
      keyPtr.free();
      ctxPtr?.free();
      subkeyPtr.free();
    }
  }

  /// Creates a master key.
  static Uint8List cryptoKdfKeygen() {
    final size = cryptoKdfKeybytes;
    final Pointer<Int8> kPtr = allocate(count: size);
    kdfBindings.crypto_kdf_keygen(kPtr);
    final k = toUint8List(kPtr, size);
    kPtr.free();
    return k;
  }

  //
  // randombytes_*
  //
  static int get randombytesSeedbytes =>
      randombytesBindings.randombytes_seedbytes();

  /// Returns an unpredictable sequence of bytes of specified size.
  static Uint8List randombytesBuf(int size) {
    final Pointer<Int8> bufPtr = allocate(count: size);
    randombytesBindings.randombytes_buf(bufPtr, size);
    final buf = toUint8List(bufPtr, size);
    bufPtr.free();
    return buf;
  }

  /// Returns an unpredictable sequence of bytes indistinguishable from random
  /// bytes without knowing the seed.
  static Uint8List randombytesBufDeterministic(int size, Uint8List seed) {
    assert(size != null);
    assert(seed != null);
    RangeError.checkNotNegative(size);
    RangeError.checkValueInInterval(seed.length, randombytesSeedbytes,
        randombytesSeedbytes, 'seed', 'Invalid length');

    final Pointer<Int8> bufPtr = allocate(count: size);
    final seedPtr = toListPointer(seed);
    randombytesBindings.randombytes_buf_deterministic(bufPtr, size, seedPtr);
    final buf = toUint8List(bufPtr, size);
    seedPtr.free();
    bufPtr.free();
    return buf;
  }

  /// Returns an unpredictable value between 0 and 0xffffffff (included).
  static int randombytesRandom() => randombytesBindings.randombytes_random();

  /// Returns an unpredictable value between 0 and upperBound (excluded). It guarantees a
  /// uniform distribution of the possible output values even when upperBound
  /// is not a power of 2.
  static int randombytesUniform(int upperBound) {
    assert(upperBound != null);
    RangeError.checkNotNegative(upperBound);
    return randombytesBindings.randombytes_uniform(upperBound);
  }

  /// Reseeds the pseudo-random number generator.
  static void randombytesStir() => randombytesBindings.randombytes_stir();

  /// Deallocates the global resources used by the pseudo-random number generator.
  static int randombytesClose() => randombytesBindings.randombytes_close();

  /// Returns the name of the current random number implementation.
  static String get randombytesImplementationName =>
      CString.fromUtf8(randombytesBindings.randombytes_implementation_name());

  //
  // sodium_*
  //
  /// Initializes the sodium library.
  static int sodiumInit() => bindings.sodium_init();

  /// Retrieves the version of the loaded libsodium library (currently 1.0.17).
  static String get sodiumVersionString =>
      CString.fromUtf8(bindings.sodium_version_string());
  static int get sodiumLibraryVersionMajor =>
      bindings.sodium_library_version_major();
  static int get sodiumLibraryVersionMinor =>
      bindings.sodium_library_version_minor();
  static int get sodiumLibraryMinimal => bindings.sodium_library_minimal();
}
