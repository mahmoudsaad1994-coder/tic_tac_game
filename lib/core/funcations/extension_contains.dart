// بنعمل خاصيه زياده اننا بنحث فالداله باكتر من قيمه
extension ContainsAll on List {
  bool containsAll(int x, int y, [z]) {
    if (z == null) {
      return contains(x) && contains(y);
    } else {
      return contains(x) && contains(y) && contains(z);
    }
  }
}
