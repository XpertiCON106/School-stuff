// Using Mult from Program 1
int Fact(int n) {
    if (n == 0) return 1;
    if (n == 1) return 1;
    return Mult(n, Fact(n - 1));
}