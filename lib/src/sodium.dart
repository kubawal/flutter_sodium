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

  /// Generates a random master key.
  static Uint8List cryptoKdfKeygen() {
    final size = cryptoKdfKeybytes;
    final Pointer<Int8> kPtr = allocate(count: size);
    kdfBindings.crypto_kdf_keygen(kPtr);
    final k = toUint8List(kPtr, size);
    kPtr.free();
    return k;
  }

  //
  // crypto_pwhash_*
  //
  static int get cryptoPwhashAlgArgon2i13 =>
      pwhashBindings.crypto_pwhash_alg_argon2i13();
  static int get cryptoPwhashAlgArgon2id13 =>
      pwhashBindings.crypto_pwhash_alg_argon2id13();
  static int get cryptoPwhashAlgDefault =>
      pwhashBindings.crypto_pwhash_alg_default();
  static int get cryptoPwhashBytesMin =>
      pwhashBindings.crypto_pwhash_bytes_min();
  static int get cryptoPwhashBytesMax =>
      pwhashBindings.crypto_pwhash_bytes_max();
  static int get cryptoPwhashPasswdMin =>
      pwhashBindings.crypto_pwhash_passwd_min();
  static int get cryptoPwhashPasswdMax =>
      pwhashBindings.crypto_pwhash_passwd_max();
  static int get cryptoPwhashSaltbytes =>
      pwhashBindings.crypto_pwhash_saltbytes();
  static int get cryptoPwhashStrbytes =>
      pwhashBindings.crypto_pwhash_strbytes();
  static String get cryptoPwhashStrprefix =>
      CString.fromUtf8(pwhashBindings.crypto_pwhash_strprefix());
  static int get cryptoPwhashOpslimitMin =>
      pwhashBindings.crypto_pwhash_opslimit_min();
  static int get cryptoPwhashOpslimitMax =>
      pwhashBindings.crypto_pwhash_opslimit_max();
  static int get cryptoPwhashMemlimitMin =>
      pwhashBindings.crypto_pwhash_memlimit_min();
  static int get cryptoPwhashMemlimitMax =>
      pwhashBindings.crypto_pwhash_memlimit_max();
  static int get cryptoPwhashOpslimitInteractive =>
      pwhashBindings.crypto_pwhash_opslimit_interactive();
  static int get cryptoPwhashMemlimitInteractive =>
      pwhashBindings.crypto_pwhash_memlimit_interactive();
  static int get cryptoPwhashOpslimitModerate =>
      pwhashBindings.crypto_pwhash_opslimit_moderate();
  static int get cryptoPwhashMemlimitModerate =>
      pwhashBindings.crypto_pwhash_memlimit_moderate();
  static int get cryptoPwhashOpslimitSensitive =>
      pwhashBindings.crypto_pwhash_opslimit_sensitive();
  static int get cryptoPwhashMemlimitSensitive =>
      pwhashBindings.crypto_pwhash_memlimit_sensitive();

  static Uint8List cryptoPwhash(int outlen, String passwd, Uint8List salt,
      int opslimit, int memlimit, int alg) {
    final Pointer<Int8> outPtr = allocate(count: outlen);
    final Pointer<Int8> passwdPtr = toUtf8Pointer(passwd, appendNull: false);
    final Pointer<Int8> saltPtr = toListPointer(salt);

    try {
      _requireSuccess(
          pwhashBindings.crypto_pwhash(outPtr, outlen, passwdPtr, passwd.length,
              saltPtr, opslimit, memlimit, alg),
          'crypto_pwhash');
      return toUint8List(outPtr, outlen);
    } finally {
      outPtr.free();
      passwdPtr.free();
      saltPtr.free();
    }
  }

  static String cryptoPwhashStr(String passwd, int opslimit, int memlimit) {
    final Pointer<Int8> outPtr = allocate(count: Sodium.cryptoPwhashStrbytes);
    final Pointer<Int8> passwdPtr = toUtf8Pointer(passwd, appendNull: false);

    try {
      _requireSuccess(
          pwhashBindings.crypto_pwhash_str(
              outPtr, passwdPtr, passwd.length, opslimit, memlimit),
          'crypto_pwhash_str');
      return toString(outPtr, Sodium.cryptoPwhashStrbytes);
    } finally {
      outPtr.free();
      passwdPtr.free();
    }
  }

  static String cryptoPwhashStrAlg(
      String passwd, int opslimit, int memlimit, int alg) {
    final Pointer<Int8> outPtr = allocate(count: Sodium.cryptoPwhashStrbytes);
    final Pointer<Int8> passwdPtr = toUtf8Pointer(passwd, appendNull: false);

    try {
      _requireSuccess(
          pwhashBindings.crypto_pwhash_str_alg(
              outPtr, passwdPtr, passwd.length, opslimit, memlimit, alg),
          'crypto_pwhash_str_alg');
      return toString(outPtr, Sodium.cryptoPwhashStrbytes);
    } finally {
      outPtr.free();
      passwdPtr.free();
    }
  }

  static int cryptoPwhashStrVerify(String str, String passwd) {
    final Pointer<Int8> strPtr = toUtf8Pointer(str);
    final Pointer<Int8> passwdPtr = toUtf8Pointer(passwd);

    try {
      return pwhashBindings.crypto_pwhash_str_verify(
          strPtr, passwdPtr, passwd.length);
    } finally {
      strPtr.free();
      passwdPtr.free();
    }
  }

  static int cryptoPwhashNeedsRehash(String str, int opslimit, int memlimit) {
    final Pointer<Int8> strPtr = toUtf8Pointer(str);

    try {
      return pwhashBindings.crypto_pwhash_str_needs_rehash(
          strPtr, opslimit, memlimit);
    } finally {
      strPtr.free();
    }
  }

  static String get cryptoPwhashPrimitive =>
      CString.fromUtf8(pwhashBindings.crypto_pwhash_primitive());

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
