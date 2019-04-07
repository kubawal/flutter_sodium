import 'package:flutter_sodium/flutter_sodium.dart';
import '../example.dart';
import '../sample.dart';

final versionExample = Example('Version',
    description: 'Provides libsodium version info.',
    docUrl: 'https://libsodium.gitbook.io/doc/',
    samples: [
      Sample('Usage', 'Retrieves the version of the loaded libsodium library',
          '''final version = Sodium.sodiumVersionString;
print(version);''', () async {
        final version = Sodium.sodiumVersionString;
        return version;
      })
    ]);
