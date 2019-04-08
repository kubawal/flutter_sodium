import 'dart:ffi';
import 'types.dart';

//
// crypto_kdf_*
//
typedef crypto_kdf_bytes_min_native_t = Uint32 Function();
typedef crypto_kdf_bytes_max_native_t = Uint32 Function();
typedef crypto_kdf_contextbytes_native_t = Uint32 Function();
typedef crypto_kdf_keybytes_native_t = Uint32 Function();
typedef crypto_kdf_primitive_native_t = CString Function();
typedef crypto_kdf_derive_from_key_native_t = Int32 Function(
    Pointer<Int8> subkey,
    Uint32 subkey_len,
    Uint64 subkey_id,
    Pointer<Int8> ctx,
    Pointer<Int8> key);
typedef crypto_kdf_keygen_native_t = Void Function(Pointer<Int8> k);

//
// crypto_pwhash_*
//
typedef crypto_pwhash_alg_argon2i13_native_t = Int32 Function();
typedef crypto_pwhash_alg_argon2id13_native_t = Int32 Function();
typedef crypto_pwhash_alg_default_native_t = Int32 Function();
typedef crypto_pwhash_bytes_min_native_t = Uint32 Function();
typedef crypto_pwhash_bytes_max_native_t = Uint32 Function();
typedef crypto_pwhash_passwd_min_native_t = Uint32 Function();
typedef crypto_pwhash_passwd_max_native_t = Uint32 Function();
typedef crypto_pwhash_saltbytes_native_t = Uint32 Function();
typedef crypto_pwhash_strbytes_native_t = Uint32 Function();
typedef crypto_pwhash_strprefix_native_t = CString Function();
typedef crypto_pwhash_opslimit_min_native_t = Uint32 Function();
typedef crypto_pwhash_opslimit_max_native_t = Uint32 Function();
typedef crypto_pwhash_memlimit_min_native_t = Uint32 Function();
typedef crypto_pwhash_memlimit_max_native_t = Uint32 Function();
typedef crypto_pwhash_opslimit_interactive_native_t = Uint32 Function();
typedef crypto_pwhash_memlimit_interactive_native_t = Uint32 Function();
typedef crypto_pwhash_opslimit_moderate_native_t = Uint32 Function();
typedef crypto_pwhash_memlimit_moderate_native_t = Uint32 Function();
typedef crypto_pwhash_opslimit_sensitive_native_t = Uint32 Function();
typedef crypto_pwhash_memlimit_sensitive_native_t = Uint32 Function();
typedef crypto_pwhash_native_t = Int32 Function(
    Pointer<Int8> out,
    Uint64 outlen,
    Pointer<Int8> passwd,
    Uint64 passwdlen,
    Pointer<Int8> salt,
    Uint64 opslimit,
    Uint32 memlimit,
    Int32 alg);
typedef crypto_pwhash_str_native_t = Int32 Function(Pointer<Int8> out,
    Pointer<Int8> passwd, Uint64 passwdlen, Uint64 opslimit, Uint32 memlimit);
typedef crypto_pwhash_str_alg_native_t = Int32 Function(
    Pointer<Int8> out,
    Pointer<Int8> passwd,
    Uint64 passwdlen,
    Uint64 opslimit,
    Uint32 memlimit,
    Int32 alg);
typedef crypto_pwhash_str_verify_native_t = Int32 Function(
    Pointer<Int8> str, Pointer<Int8> passwd, Uint64 passwdlen);
typedef crypto_pwhash_str_needs_rehash_native_t = Int32 Function(
    Pointer<Int8> str, Uint64 opslimit, Uint32 memlimit);
typedef crypto_pwhash_primitive_native_t = CString Function();

//
// randombytes_*
//
typedef randombytes_seedbytes_native_t = Uint32 Function();
typedef randombytes_buf_native_t = Void Function(Pointer<Int8> buf, Uint8 size);
typedef randombytes_buf_deterministic_native_t = Void Function(
    Pointer<Int8> buf, Uint8 size, Pointer<Int8> seed);
typedef randombytes_random_native_t = Uint32 Function();
typedef randombytes_uniform_native_t = Uint32 Function(Uint32 upper_bound);
typedef randombytes_stir_native_t = Void Function();
typedef randombytes_close_native_t = Int32 Function();
typedef randombytes_implementation_name_native_t = CString Function();

//
// sodium_*
//
typedef sodium_init_native_t = Int32 Function();
typedef sodium_version_string_native_t = CString Function();
typedef sodium_library_version_major_native_t = Int32 Function();
typedef sodium_library_version_minor_native_t = Int32 Function();
typedef sodium_library_minimal_native_t = Int32 Function();
