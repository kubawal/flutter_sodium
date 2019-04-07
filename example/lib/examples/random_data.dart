import 'package:flutter_sodium/flutter_sodium.dart';
import 'package:convert/convert.dart';
import '../example.dart';
import '../sample.dart';

final randomData = Example('Random data',
        description:
            'Provides a set of functions to generate unpredictable data, suitable for creating secret keys.',
        docUrl: 'https://libsodium.gitbook.io/doc/generating_random_data/',
        samples: [
          Sample(
              'Random',
              'Returns an unpredictable value between 0 and 0xffffffff (included)',
              '''final rnd = RandomBytes.random();
print(rnd);''', () async {
            final rnd = RandomBytes.random();
            return rnd.toString();
          }),
          Sample(
              'Uniform',
              'Generates an unpredictable value between 0 and upperBound (excluded)',
              '''final rnd = RandomBytes.uniform(16);
print(rnd);''', () async {
            final rnd = RandomBytes.uniform(16);
            return rnd.toString();
          }),
          Sample(
              'Buffer',
              'Generates an unpredictable sequence of bytes of specified size.',
              '''final buffer = RandomBytes.buffer(16);
print(hex.encode(buffer));''', () async {
            final buffer = RandomBytes.buffer(16);
            return hex.encode(buffer);
          })
        ]);