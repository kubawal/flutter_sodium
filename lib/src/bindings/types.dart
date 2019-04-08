import 'dart:convert';
import 'dart:ffi';
import 'dart:typed_data';

/// Represents a String in C memory.
class CString extends Pointer<Int8> {
  /// Read the string for C memory into Dart.
  static String fromUtf8(CString str) {
    if (str == null) return null;
    int len = 0;
    while (str.elementAt(++len).load<int>() != 0);
    List<int> units = List(len);
    for (int i = 0; i < len; ++i) units[i] = str.elementAt(i).load();
    return Utf8Decoder().convert(units);
  }
}

Pointer<Int8> toUtf8Pointer(String s, {bool appendNull}) {
  if (s == null) {
    return null;
  }
  List<int> units = Utf8Encoder().convert(s);
  Pointer<Int8> sPtr = allocate(count: units.length + (appendNull ? 1 : 0));
  for (int i = 0; i < units.length; ++i) {
    sPtr.elementAt(i).store(units[i]);
  }
  if (appendNull){
  sPtr.elementAt(units.length).store(0);
  }
  return sPtr.cast();
}

Uint8List toUint8List(Pointer<Int8> p, int size) {
  final list = Uint8List(size);
  for (int i = 0; i < size; i++) {
    list[i] = p.elementAt(i).load();
  }

  return list;
}

String toString(Pointer<Int8> p, int size) {
  final list = List<int>(size);
  for (int i = 0; i < size; i++) {
    list[i] = p.elementAt(i).load();
  }

  return Utf8Decoder().convert(list);
}

Pointer<Int8> toListPointer(Uint8List list) {
  Pointer<Int8> listPtr = allocate(count: list.length);

  for (int i = 0; i < list.length; ++i) {
    listPtr.elementAt(i).store(list[i]);
  }
  return listPtr;
}
