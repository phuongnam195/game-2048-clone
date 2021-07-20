import 'package:flutter/material.dart';

import './models/board.dart';

const List<List<Color>> GRADIENT_THEME = [
  [Color.fromRGBO(86, 193, 68, 1), Color.fromRGBO(0, 56, 106, 1)],
  [Color.fromRGBO(37, 185, 171, 1), Color.fromRGBO(21, 29, 109, 1)],
  [Color.fromRGBO(87, 176, 217, 1), Color.fromRGBO(128, 4, 124, 1)],
];

var currentTheme = 0;
var currentBoard = 1;

const Map<int, Color> CELL_COLOR = {
  0: Color(0x10FFFFFF),
  2: Color(0xFFEEF5E8),
  4: Color(0xFFDCEDC8),
  8: Color(0xFFAED581),
  16: Color(0xFF8FC94C),
  32: Color(0xFF6EA93B),
  64: Color(0xFF478C2D),
  128: Color(0xFF01858B),
  256: Color(0xFF02A3B4),
};

List<Board> boards = [
  Board(3, 'Tiny'),
  Board(4, 'Classic'),
  Board(5, 'Big'),
  Board(6, 'Bigger'),
  Board(7, 'Huge'),
  Board(8, 'Huger'),
];
