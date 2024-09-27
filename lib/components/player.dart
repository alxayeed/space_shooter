import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class Player extends SpriteComponent {
  void move(Vector2 delta) {
    position.add(delta);
  }
}
