let xs: List<Int> = .cons(42, .cons(0, .cons(-1, .empty)))
print(xs)
let succ = { $0 + 1 }
print(xs.map(succ))
print(xs.map1(succ))
print(map2(succ, xs))
print(sum(xs))
print(length(xs))
