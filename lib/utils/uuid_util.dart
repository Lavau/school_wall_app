import 'dart:math';

String uuid() {
  Function id = () => (((1 + Random().nextInt(10000)) * 0x10000) | 0).toRadixString(16).substring(0, 3);
  return id() + id() + id() + id() + id() + id() + id() + id();
}
