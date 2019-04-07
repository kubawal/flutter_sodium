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
    if (Platform.isAndroid || Platform.isLinux) return path + 'lib' + name + '.so';
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

_RandombytesBindings _cachedRandombytesBindings;
_RandombytesBindings get randombytesBindings =>
    _cachedRandombytesBindings ??= _RandombytesBindings();
