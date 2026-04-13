int Mult(int m, int n) {
    if (n == 1) return m;
    return m + Mult(m, n - 1);
}