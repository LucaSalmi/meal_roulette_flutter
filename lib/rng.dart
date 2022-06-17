import 'dart:math';

class Rng {
  static int random(int min, int max) {
    return min + Random().nextInt(max - min);
  }
}
