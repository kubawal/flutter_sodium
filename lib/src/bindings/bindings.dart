import 'dart:ffi';
import 'dart:io';
import 'signatures.dart';
import 'types.dart';

class _SodiumBindings {
  DynamicLibrary sodium;
  _RandombytesBindings _randombytesBindings;

  _SodiumBindings() {
    final path = _platformPath('sodium');
    sodium = DynamicLibrary.open(path);

    sodium_init = sodium
        .lookup<NativeFunction<sodium_init_native_t>>('sodium_init')
        .asFunction();

    sodium_version_string = sodium
        .lookup<NativeFunction<sodium_version_string_native_t>>(
            'sodium_version_string')
        .asFunction();

    sodium_library_version_major = sodium
        .lookup<NativeFunction<sodium_library_version_major_native_t>>(
            'sodium_library_version_major')
        .asFunction();

    sodium_library_version_minor = sodium
        .lookup<NativeFunction<sodium_library_version_minor_native_t>>(
            'sodium_library_version_minor')
        .asFunction();

    sodium_library_minimal = sodium
        .lookup<NativeFunction<sodium_library_minimal_native_t>>(
            'sodium_library_minimal')
        .asFunction();
  }

  int Function() sodium_init;

  CString Function() sodium_version_string;
  int Function() sodium_library_version_major;
  int Function() sodium_library_version_minor;
  int Function() sodium_library_minimal;

  String _platformPath(String name, {String path}) {
    if (path == null) path = '';
    if (Platform.isAndroid || Platform.isLinux)
      return path + 'lib' + name + '.so';
    if (Platform.isMacOS) return path + 'lib' + name + '.dylib';
    if (Platform.isWindows) return path + name + '.dll';
    throw Exception('Platform not implemented');
  }
}

class _KdfBindings {
  _KdfBindings() {
    crypto_kdf_bytes_min = bindings.sodium
        .lookup<NativeFunction<crypto_kdf_bytes_min_native_t>>(
            'crypto_kdf_bytes_min')
        .asFunction();
    crypto_kdf_bytes_max = bindings.sodium
        .lookup<NativeFunction<crypto_kdf_bytes_max_native_t>>(
            'crypto_kdf_bytes_max')
        .asFunction();
    crypto_kdf_contextbytes = bindings.sodium
        .lookup<NativeFunction<crypto_kdf_contextbytes_native_t>>(
            'crypto_kdf_contextbytes')
        .asFunction();
    crypto_kdf_keybytes = bindings.sodium
        .lookup<NativeFunction<crypto_kdf_keybytes_native_t>>(
            'crypto_kdf_keybytes')
        .asFunction();
    crypto_kdf_primitive = bindings.sodium
        .lookup<NativeFunction<crypto_kdf_primitive_native_t>>(
            'crypto_kdf_primitive')
        .asFunction();
    crypto_kdf_derive_from_key = bindings.sodium
        .lookup<NativeFunction<crypto_kdf_derive_from_key_native_t>>(
            'crypto_kdf_derive_from_key')
        .asFunction();
    crypto_kdf_keygen = bindings.sodium
        .lookup<NativeFunction<crypto_kdf_keygen_native_t>>('crypto_kdf_keygen')
        .asFunction();
  }

  int Function() crypto_kdf_bytes_min;
  int Function() crypto_kdf_bytes_max;
  int Function() crypto_kdf_contextbytes;
  int Function() crypto_kdf_keybytes;
  CString Function() crypto_kdf_primitive;
  int Function(Pointer<Int8> subkey, int subkey_len, int subkey_id,
      Pointer<Int8> ctx, Pointer<Int8> key) crypto_kdf_derive_from_key;
  void Function(Pointer<Int8> k) crypto_kdf_keygen;
}

class _PwhashBindings {
  _PwhashBindings() {
    crypto_pwhash_alg_argon2i13 = bindings.sodium
        .lookup<NativeFunction<crypto_pwhash_alg_argon2i13_native_t>>(
            'crypto_pwhash_alg_argon2i13')
        .asFunction();
    crypto_pwhash_alg_argon2id13 = bindings.sodium
        .lookup<NativeFunction<crypto_pwhash_alg_argon2id13_native_t>>(
            'crypto_pwhash_alg_argon2id13')
        .asFunction();
    crypto_pwhash_alg_default = bindings.sodium
        .lookup<NativeFunction<crypto_pwhash_alg_default_native_t>>(
            'crypto_pwhash_alg_default')
        .asFunction();
    crypto_pwhash_bytes_min = bindings.sodium
        .lookup<NativeFunction<crypto_pwhash_bytes_min_native_t>>(
            'crypto_pwhash_bytes_min')
        .asFunction();
    crypto_pwhash_bytes_max = bindings.sodium
        .lookup<NativeFunction<crypto_pwhash_bytes_max_native_t>>(
            'crypto_pwhash_bytes_max')
        .asFunction();
    crypto_pwhash_passwd_min = bindings.sodium
        .lookup<NativeFunction<crypto_pwhash_passwd_min_native_t>>(
            'crypto_pwhash_passwd_min')
        .asFunction();
    crypto_pwhash_passwd_max = bindings.sodium
        .lookup<NativeFunction<crypto_pwhash_passwd_max_native_t>>(
            'crypto_pwhash_passwd_max')
        .asFunction();
    crypto_pwhash_saltbytes = bindings.sodium
        .lookup<NativeFunction<crypto_pwhash_saltbytes_native_t>>(
            'crypto_pwhash_saltbytes')
        .asFunction();
    crypto_pwhash_strbytes = bindings.sodium
        .lookup<NativeFunction<crypto_pwhash_strbytes_native_t>>(
            'crypto_pwhash_strbytes')
        .asFunction();
    crypto_pwhash_strprefix = bindings.sodium
        .lookup<NativeFunction<crypto_pwhash_strprefix_native_t>>(
            'crypto_pwhash_strprefix')
        .asFunction();
    crypto_pwhash_opslimit_min = bindings.sodium
        .lookup<NativeFunction<crypto_pwhash_opslimit_min_native_t>>(
            'crypto_pwhash_opslimit_min')
        .asFunction();
    crypto_pwhash_opslimit_max = bindings.sodium
        .lookup<NativeFunction<crypto_pwhash_opslimit_max_native_t>>(
            'crypto_pwhash_opslimit_max')
        .asFunction();
    crypto_pwhash_memlimit_min = bindings.sodium
        .lookup<NativeFunction<crypto_pwhash_memlimit_min_native_t>>(
            'crypto_pwhash_memlimit_min')
        .asFunction();
    crypto_pwhash_memlimit_max = bindings.sodium
        .lookup<NativeFunction<crypto_pwhash_memlimit_max_native_t>>(
            'crypto_pwhash_memlimit_max')
        .asFunction();
    crypto_pwhash_opslimit_interactive = bindings.sodium
        .lookup<NativeFunction<crypto_pwhash_opslimit_interactive_native_t>>(
            'crypto_pwhash_opslimit_interactive')
        .asFunction();
    crypto_pwhash_memlimit_interactive = bindings.sodium
        .lookup<NativeFunction<crypto_pwhash_memlimit_interactive_native_t>>(
            'crypto_pwhash_memlimit_interactive')
        .asFunction();
    crypto_pwhash_opslimit_moderate = bindings.sodium
        .lookup<NativeFunction<crypto_pwhash_opslimit_moderate_native_t>>(
            'crypto_pwhash_opslimit_moderate')
        .asFunction();
    crypto_pwhash_memlimit_moderate = bindings.sodium
        .lookup<NativeFunction<crypto_pwhash_memlimit_moderate_native_t>>(
            'crypto_pwhash_memlimit_moderate')
        .asFunction();
    crypto_pwhash_opslimit_sensitive = bindings.sodium
        .lookup<NativeFunction<crypto_pwhash_opslimit_sensitive_native_t>>(
            'crypto_pwhash_opslimit_sensitive')
        .asFunction();
    crypto_pwhash_memlimit_sensitive = bindings.sodium
        .lookup<NativeFunction<crypto_pwhash_memlimit_sensitive_native_t>>(
            'crypto_pwhash_memlimit_sensitive')
        .asFunction();
    crypto_pwhash = bindings.sodium
        .lookup<NativeFunction<crypto_pwhash_native_t>>('crypto_pwhash')
        .asFunction();
    crypto_pwhash_str = bindings.sodium
        .lookup<NativeFunction<crypto_pwhash_str_native_t>>('crypto_pwhash_str')
        .asFunction();
    crypto_pwhash_str_alg = bindings.sodium
        .lookup<NativeFunction<crypto_pwhash_str_alg_native_t>>(
            'crypto_pwhash_str_alg')
        .asFunction();
    crypto_pwhash_str_verify = bindings.sodium
        .lookup<NativeFunction<crypto_pwhash_str_verify_native_t>>(
            'crypto_pwhash_str_verify')
        .asFunction();
    crypto_pwhash_str_needs_rehash = bindings.sodium
        .lookup<NativeFunction<crypto_pwhash_str_needs_rehash_native_t>>(
            'crypto_pwhash_str_needs_rehash')
        .asFunction();
    crypto_pwhash_primitive = bindings.sodium
        .lookup<NativeFunction<crypto_pwhash_primitive_native_t>>(
            'crypto_pwhash_primitive')
        .asFunction();
  }

  int Function() crypto_pwhash_alg_argon2i13;
  int Function() crypto_pwhash_alg_argon2id13;
  int Function() crypto_pwhash_alg_default;
  int Function() crypto_pwhash_bytes_min;
  int Function() crypto_pwhash_bytes_max;
  int Function() crypto_pwhash_passwd_min;
  int Function() crypto_pwhash_passwd_max;
  int Function() crypto_pwhash_saltbytes;
  int Function() crypto_pwhash_strbytes;
  CString Function() crypto_pwhash_strprefix;
  int Function() crypto_pwhash_opslimit_min;
  int Function() crypto_pwhash_opslimit_max;
  int Function() crypto_pwhash_memlimit_min;
  int Function() crypto_pwhash_memlimit_max;
  int Function() crypto_pwhash_opslimit_interactive;
  int Function() crypto_pwhash_memlimit_interactive;
  int Function() crypto_pwhash_opslimit_moderate;
  int Function() crypto_pwhash_memlimit_moderate;
  int Function() crypto_pwhash_opslimit_sensitive;
  int Function() crypto_pwhash_memlimit_sensitive;
  int Function(
      Pointer<Int8> out,
      int outlen,
      Pointer<Int8> passwd,
      int passwdlen,
      Pointer<Int8> salt,
      int opslimit,
      int memlimit,
      int alg) crypto_pwhash;
  int Function(Pointer<Int8> out, Pointer<Int8> passwd, int passwdlen,
      int opslimit, int memlimit) crypto_pwhash_str;
  int Function(Pointer<Int8> out, Pointer<Int8> passwd, int passwdlen,
      int opslimit, int memlimit, int alg) crypto_pwhash_str_alg;
  int Function(Pointer<Int8> str, Pointer<Int8> passwd, int passwdlen)
      crypto_pwhash_str_verify;
  int Function(Pointer<Int8> str, int opslimit, int memlimit)
      crypto_pwhash_str_needs_rehash;

  CString Function() crypto_pwhash_primitive;
}

class _RandombytesBindings {
  _RandombytesBindings() {
    randombytes_seedbytes = bindings.sodium
        .lookup<NativeFunction<randombytes_seedbytes_native_t>>(
            'randombytes_seedbytes')
        .asFunction();
    randombytes_buf = bindings.sodium
        .lookup<NativeFunction<randombytes_buf_native_t>>('randombytes_buf')
        .asFunction();
    randombytes_buf_deterministic = bindings.sodium
        .lookup<NativeFunction<randombytes_buf_deterministic_native_t>>(
            'randombytes_buf_deterministic')
        .asFunction();
    randombytes_random = bindings.sodium
        .lookup<NativeFunction<randombytes_random_native_t>>(
            'randombytes_random')
        .asFunction();
    randombytes_uniform = bindings.sodium
        .lookup<NativeFunction<randombytes_uniform_native_t>>(
            'randombytes_uniform')
        .asFunction();
    randombytes_stir = bindings.sodium
        .lookup<NativeFunction<randombytes_stir_native_t>>('randombytes_stir')
        .asFunction();
    randombytes_close = bindings.sodium
        .lookup<NativeFunction<randombytes_close_native_t>>('randombytes_close')
        .asFunction();
    randombytes_implementation_name = bindings.sodium
        .lookup<NativeFunction<randombytes_implementation_name_native_t>>(
            'randombytes_implementation_name')
        .asFunction();
  }

  int Function() randombytes_seedbytes;
  void Function(Pointer<Int8> buf, int size) randombytes_buf;
  void Function(Pointer<Int8> buf, int size, Pointer<Int8> seed)
      randombytes_buf_deterministic;
  int Function() randombytes_random;
  int Function(int upper_bound) randombytes_uniform;
  void Function() randombytes_stir;
  int Function() randombytes_close;
  CString Function() randombytes_implementation_name;
}

_SodiumBindings _cachedBindings;
_SodiumBindings get bindings => _cachedBindings ??= _SodiumBindings();

_KdfBindings _cachedKdfBindings;
_KdfBindings get kdfBindings => _cachedKdfBindings ??= _KdfBindings();

_PwhashBindings _cachedPwhashBindings;
_PwhashBindings get pwhashBindings =>
    _cachedPwhashBindings ??= _PwhashBindings();

_RandombytesBindings _cachedRandombytesBindings;
_RandombytesBindings get randombytesBindings =>
    _cachedRandombytesBindings ??= _RandombytesBindings();
