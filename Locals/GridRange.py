def won(c, n):
  if c[0] == n and c[1] == n and c[2] == n: return 1
  if c[3] == n and c[4] == n and c[5] == n: return 1
  if c[6] == n and c[7] == n and c[8] == n: return 1

  if c[0] == n and c[3] == n and c[6] == n: return 1
  if c[1] == n and c[4] == n and c[7] == n: return 1
  if c[2] == n and c[5] == n and c[8] == n: return 1

  if c[0] == n and c[4] == n and c[8] == n: return 1
  if c[2] == n and c[4] == n and c[6] == n: return 1

  return 0

for count in range(3**9):
    grid = [(count // (3 ** i)) % 3 for i in range(9)]
    if won(grid, 1) + won(grid, 2) == 1:
       print(grid)
