function q = quat_conj(a)

a1 = a(1);
a2 = a(2);
a3 = a(3);
a4 = a(4);

q = [a1, -a2, -a3, -a4].';