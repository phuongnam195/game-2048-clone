import 'package:flutter/material.dart';

import './models/board.dart';

const List<List<Color>> GRADIENT_THEME = [
  [Color.fromRGBO(86, 193, 68, 1), Color.fromRGBO(0, 56, 106, 1)],
  [Color.fromRGBO(37, 185, 171, 1), Color.fromRGBO(21, 29, 109, 1)],
  [Color.fromRGBO(87, 176, 217, 1), Color.fromRGBO(128, 4, 124, 1)],
];

var currentTheme = 0;
var currentBoard = 1;

const List<Map<int, Color>> CELL_COLOR = [
  {
    0: Color(0x10FFFFFF),
    2: Color(0xFFEEF5E8),
    4: Color(0xFFDCEDC8),
    8: Color(0xFFAED581),
    16: Color(0xFF8FC94C),
    32: Color(0xFF6EA93B),
    64: Color(0xFF478C2D),
    128: Color(0xFF01858B),
    256: Color(0xFF02A3B4),
    512: Color(0xFF0992C4),
    1024: Color(0xFF026FC4),
    2048: Color(0xFF028CD7),
  },
  {
    0: Color(0x10FFFFFF),
    2: Color(0xFFe0f2f2),
    4: Color(0xFFb2dddf),
    8: Color(0xFF5cc5c9),
    16: Color(0xFF00aeb6),
    32: Color(0xFF018c99),
    64: Color(0xFF017e84),
    128: Color(0xFF1165c6),
    256: Color(0xFF1b7ddf),
    512: Color(0xFF2196f3),
    1024: Color(0xFF2f3a99),
    2048: Color(0xFF33529b),
  },
  {
    0: Color(0x10FFFFFF),
    2: Color(0xFFe3f2fd),
    4: Color(0xFFbbdefb),
    8: Color(0xFF6cb8f4),
    16: Color(0xFF319ef4),
    32: Color(0xFF2582e1),
    64: Color(0xFF2469d4),
    128: Color(0xFF5c19ae),
    256: Color(0xFF8522af),
    512: Color(0xFFaa2bbf),
    1024: Color(0xFF971058),
    2048: Color(0xFFb71958),
  },
];

List<Board> boards = [
  Board(3, 'Tiny'),
  Board(4, 'Classic'),
  Board(5, 'Big'),
  Board(6, 'Bigger'),
  Board(7, 'Huge'),
  Board(8, 'Huger'),
];
