import 'package:flutter_sodium/flutter_sodium.dart';
import 'package:convert/convert.dart';
import '../example.dart';
import '../sample.dart';

final keyDerivation = Example('Key derivation',
        description: 'Derive secret subkeys from a single master key.',
        docUrl: 'https://libsodium.gitbook.io/doc/key_derivation/',
        samples: [
          Sample('Usage', 'Compute a set of shared keys.',
              '''// Generate master key
final masterkey = KeyDerivation.generateKey();

// Derives subkeys of various lengths
final subkey1 = KeyDerivation.deriveFromKey(
    masterkey, 1, subKeyLength: 32);
final subkey2 = KeyDerivation.deriveFromKey(
    masterkey, 2, subKeyLength: 32);
final subkey3 = KeyDerivation.deriveFromKey(
    masterkey, 3, subKeyLength: 64);

print('subkey1: \${hex.encode(subkey1)}')
print('subkey2: \${hex.encode(subkey2)}')
print('subkey3: \${hex.encode(subkey3)}');''', () async {
            // Generate master key
            final masterkey = KeyDerivation.generateKey();

            // Derives subkeys of various lengths
            final subkey1 = KeyDerivation.deriveFromKey(masterkey, 1,
                subkeyLength: 32);
            final subkey2 = KeyDerivation.deriveFromKey(masterkey, 2,
                subkeyLength: 32);
            final subkey3 = KeyDerivation.deriveFromKey(masterkey, 3,
                subkeyLength: 64);

            return 'subkey1: ${hex.encode(subkey1)}\nsubkey2: ${hex.encode(subkey2)}\nsubkey3: ${hex.encode(subkey3)}\n';
          })
        ]);