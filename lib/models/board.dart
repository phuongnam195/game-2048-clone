import 'dart:math';

class Board {
  final String title;
  final int size;
  late List<List<int>> matrix;
  int currentScore = 0;
  int highScore = 0;
  bool isOver = false;

  late List<List<int>> _oldMatrix;
  bool _canRollback = true;
  late int _oldCurrentScore;
  late int _oldHighScore;
  var _rng = new Random();

  Board(this.size, this.title) {
    matrix = List.generate(size, (row) => List.filled(size, 0, growable: false),
        growable: false);
    _oldMatrix = List.generate(
        size, (row) => List.filled(size, 0, growable: false),
        growable: false);
    int i = _rng.nextInt(this.size);
    int j = _rng.nextInt(this.size);
    matrix[i][j] = 2;
  }

  int valueAt(int i) {
    return matrix[i ~/ size][i % size];
  }

  void rollback() {
    if (!_canRollback) return;
    for (int row = 0; row < size; row++)
      for (int col = 0; col < size; col++)
        matrix[row][col] = _oldMatrix[row][col];
    currentScore = _oldCurrentScore;
    highScore = _oldHighScore;
    isOver = false;

    _canRollback = false;
  }

  void reset() {
    currentScore = 0;
    int i = _rng.nextInt(this.size);
    int j = _rng.nextInt(this.size);
    for (int row = 0; row < size; row++)
      for (int col = 0; col < size; col++)
        if (row == i && col == j)
          matrix[row][col] = 2;
        else
          matrix[row][col] = 0;
    isOver = false;
  }

  void _addCell() {
    int i;
    int j;
    do {
      i = _rng.nextInt(size);
      j = _rng.nextInt(size);
    } while (matrix[i][j] != 0);
    matrix[i][j] = 2;
  }

  void _backUp() {
    for (int row = 0; row < size; row++)
      for (int col = 0; col < size; col++)
        _oldMatrix[row][col] = matrix[row][col];
    _oldCurrentScore = currentScore;
    _oldHighScore = highScore;
  }

  bool _checkOver() {
    for (int row = 1; row < size - 1; row++)
      for (int col = 1; col < size - 1; col++) {
        if (matrix[row][col] == 0) return false;
        if (matrix[row][col] == matrix[row + 1][col]) return false;
        if (matrix[row][col] == matrix[row - 1][col]) return false;
        if (matrix[row][col] == matrix[row][col + 1]) return false;
        if (matrix[row][col] == matrix[row][col - 1]) return false;
      }
    for (int row = 0; row < size - 1; row++) {
      if (matrix[row][0] == 0) return false;
      if (matrix[row][size - 1] == 0) return false;
      if (matrix[row][0] == matrix[row + 1][0]) return false;
      if (matrix[row][size - 1] == matrix[row + 1][size - 1]) return false;
    }
    for (int col = 0; col < size - 1; col++) {
      if (matrix[0][col] == 0) return false;
      if (matrix[size - 1][col] == 0) return false;
      if (matrix[0][col] == matrix[0][col + 1]) return false;
      if (matrix[size - 1][col] == matrix[size - 1][col + 1]) return false;
    }

    if (matrix[size - 1][size - 1] == 0) return false;

    return true;
  }

  void up() {
    if (isOver) return;

    _backUp();
    bool isChanged = false;

    for (int col = 0; col < size; col++) {
      int i = 0;
      for (int row = 1; row < size; row++)
        if (matrix[row][col] != 0) {
          if (matrix[row][col] == matrix[i][col]) {
            matrix[i][col] *= 2;
            currentScore += matrix[i][col];
            i++;
          } else {
            if (matrix[i][col] == 0) {
              matrix[i][col] = matrix[row][col];
            } else {
              matrix[++i][col] = matrix[row][col];
              if (i == row) continue;
            }
          }
          isChanged = true;
          matrix[row][col] = 0;
        }
    }
    if (isChanged) _addCell();
    if (currentScore > highScore) highScore = currentScore;
    isOver = _checkOver();
    _canRollback = true;
  }

  void down() {
    if (isOver) return;

    _backUp();
    bool isChanged = false;

    for (int col = 0; col < size; col++) {
      int i = size - 1;
      for (int row = size - 2; row >= 0; row--)
        if (matrix[row][col] != 0) {
          if (matrix[row][col] == matrix[i][col]) {
            matrix[i][col] *= 2;
            currentScore += matrix[i][col];
            i--;
          } else {
            if (matrix[i][col] == 0) {
              matrix[i][col] = matrix[row][col];
            } else {
              matrix[--i][col] = matrix[row][col];
              if (i == row) continue;
            }
          }
          isChanged = true;
          matrix[row][col] = 0;
        }
    }
    if (isChanged) _addCell();
    if (currentScore > highScore) highScore = currentScore;
    isOver = _checkOver();
    _canRollback = true;
  }

  void left() {
    if (isOver) return;

    _backUp();
    bool isChanged = false;

    for (int row = 0; row < size; row++) {
      int j = 0;
      for (int col = 1; col < size; col++)
        if (matrix[row][col] != 0) {
          if (matrix[row][col] == matrix[row][j]) {
            matrix[row][j] *= 2;
            currentScore += matrix[row][j];
            j++;
          } else {
            if (matrix[row][j] == 0) {
              matrix[row][j] = matrix[row][col];
            } else {
              matrix[row][++j] = matrix[row][col];
              if (j == col) continue;
            }
          }
          isChanged = true;
          matrix[row][col] = 0;
        }
    }
    if (isChanged) _addCell();
    if (currentScore > highScore) highScore = currentScore;
    isOver = _checkOver();
    _canRollback = true;
  }

  void right() {
    if (isOver) return;

    _backUp();
    bool isChanged = false;

    for (int row = 0; row < size; row++) {
      int j = size - 1;
      for (int col = size - 2; col >= 0; col--)
        if (matrix[row][col] != 0) {
          if (matrix[row][col] == matrix[row][j]) {
            matrix[row][j] *= 2;
            currentScore += matrix[row][j];
            j--;
          } else {
            if (matrix[row][j] == 0) {
              matrix[row][j] = matrix[row][col];
            } else {
              matrix[row][--j] = matrix[row][col];
              if (j == col) continue;
            }
          }
          isChanged = true;
          matrix[row][col] = 0;
        }
    }
    if (isChanged) _addCell();
    if (currentScore > highScore) highScore = currentScore;
    isOver = _checkOver();
    _canRollback = true;
  }
}
