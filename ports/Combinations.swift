// Not used yet: 0
// Used with x : 1
// Used with 0 : 2
// 8 lines code to get the next combination
func increment ( _ list: inout [Int], _ base: Int ) -> Bool {
    for digit in 0..<list.count {
        list[digit] += 1
        if list[digit] < base { return true }
        list[digit] = 0
    }
    return false
}
let incrementTicTacToe = { increment(&$0, 3) }

let win0_ = [0,1,2] // [1,1,1,0,0,0,0,0,0]
let win1_ = [3,4,5] // [0,0,0,1,1,1,0,0,0]
let win2_ = [6,7,8] // [0,0,0,0,0,0,1,1,1]
let win_0 = [0,3,6] // [1,0,0,1,0,0,1,0,0]
let win_1 = [1,4,7] // [0,1,0,0,1,0,0,1,0]
let win_2 = [2,5,8] // [0,0,1,0,0,1,0,0,1]
let win00 = [0,4,8] // [1,0,0,0,1,0,0,0,1]
let win11 = [2,4,6] // [0,0,1,0,1,0,1,0,0]
let winList = [ win0_, win1_, win2_, win_0, win_1, win_2, win00, win11]
// 16 lines to check a valid board, wihtout countin lines of comment.
func winCombination (_ tictactoe: [Int]) -> Bool {
    var count = 0
    for win in winList {
        if tictactoe[win[0]] == tictactoe[win[1]],
            tictactoe[win[1]] == tictactoe[win[2]],
            tictactoe[win[2]] != 0 {
            // If the combination exist increment count by 1.
            count += 1
        }
        if count == 2 {
            return false
        }
    }
    var indexes = Array(repeating:0, count:3)
    for num in tictactoe { indexes[num] += 1 }
    // '0' and 'X' must be used the same times or with a diference of one.
    // Must one and only one valid combination
    return abs(indexes[1] - indexes[2]) <= 1 && count == 1
}
// Test
var listToIncrement = Array(repeating:0, count:9)
var combinationsCount = 1
var winCount = 0
while incrementTicTacToe(&listToIncrement) {
    if winCombination(listToIncrement) == true {
        winCount += 1
    }
    combinationsCount += 1
}
print("There is \(combinationsCount) combinations including possible and impossible ones.")
print("There is \(winCount) combinations for wining positions.")
/*
  There are 19683 combinations including possible and impossible ones.
  There are 2032 combinations for winning positions.
*/

listToIncrement = Array(repeating:0, count:9)
var listOfIncremented = ""
for _ in 0..<1000 { // Win combinations for the first 1000 combinations
    _ = incrementTicTacToe(&listToIncrement)
    if winCombination(listToIncrement) == true {
        listOfIncremented += ", \(listToIncrement)"
    }
}
print("List of combinations: \(listOfIncremented)")

/* 
  List of combinations: , [2, 2, 2, 1, 1, 0, 0, 0, 0], [1, 1, 1, 2, 2, 0, 0, 0, 0], 
  [2, 2, 2, 1, 0, 1, 0, 0, 0], [2, 2, 2, 0, 1, 1, 0, 0, 0], [2, 2, 0, 1, 1, 1, 0, 0, 0],
  [2, 0, 2, 1, 1, 1, 0, 0, 0], [0, 2, 2, 1, 1, 1, 0, 0, 0], [1, 1, 1, 2, 0, 2, 0, 0, 0],
  [1, 1, 1, 0, 2, 2, 0, 0, 0], [1, 1, 0, 2, 2, 2, 0, 0, 0], [1, 0, 1, 2, 2, 2, 0, 0, 0],
  [0, 1, 1, 2, 2, 2, 0, 0, 0], [1, 2, 2, 1, 0, 0, 1, 0, 0], [2, 2, 2, 1, 0, 0, 1, 0, 0],
  [2, 2, 1, 0, 1, 0, 1, 0, 0], [2, 2, 2, 0, 1, 0, 1, 0, 0], [2, 2, 2, 1, 1, 0, 1, 0, 0],
  [2, 0, 1, 2, 1, 0, 1, 0, 0], [0, 2, 1, 2, 1, 0, 1, 0, 0], [2, 2, 1, 2, 1, 0, 1, 0, 0],
  [1, 2, 0, 1, 2, 0, 1, 0, 0], [1, 0, 2, 1, 2, 0, 1, 0, 0], [1, 2, 2, 1, 2, 0, 1, 0, 0],
  [2, 2, 2, 0, 0, 1, 1, 0, 0]
*/