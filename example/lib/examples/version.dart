import 'package:flutter_sodium/flutter_sodium.dart';
import '../example.dart';
import '../sample.dart';

final version = Example('Version',
    description: 'Provides libsodium version info.',
    docUrl: 'https://libsodium.gitbook.io/doc/',
    samples: [
      Sample(
          'Usage',
          'Retrieves the version details of the loaded libsodium library',
          '''final version = Sodium.sodiumVersionString;
final major = Sodium.sodiumLibraryVersionMajor;
final minor = Sodium.sodiumLibraryVersionMinor;
final minimal = Sodium.sodiumLibraryMinimal;

print('\$version (\$major.\$minor, min: \$minimal)');''', () async {
        final version = Sodium.sodiumVersionString;
        final major = Sodium.sodiumLibraryVersionMajor;
        final minor = Sodium.sodiumLibraryVersionMinor;
        final minimal = Sodium.sodiumLibraryMinimal;

        return "$version ($major.$minor, min: $minimal)";
      })
    ]);
