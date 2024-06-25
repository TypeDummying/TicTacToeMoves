const [EMPTY, O, X] = [0, 4, 1]
let count = 0 

let coordinate = [
    EMPTY, EMPTY, EMPTY, 
    EMPTY, EMPTY, EMPTY, 
    EMPTY, EMPTY, EMPTY
]

function reducer(arr, sumOne, sumTwo = null) {
    let func = arr.reduce((sum, a) => sum + a, 0)
    if((func === sumOne) || (func === sumTwo)) return true
}

function checkResult() {
    let [a1, a2, a3, b1, b2, b3, c1, c2, c3] = coordinate
    if(reducer([a1,a2,a3], 3, 12)) return true
    if(reducer([a1,b2,c3], 3, 12)) return true
    if(reducer([b1,b2,b3], 3, 12)) return true
    if(reducer([c1,c2,c3], 3, 12)) return true
    if(reducer([a3,b2,c1], 3, 12)) return true
    if(reducer([a1,b1,c1], 3, 12)) return true
    if(reducer([a2,b2,c2], 3, 12)) return true
    if(reducer([a3,b3,c3], 3, 12)) return true
    if(reducer([a1,a2,a3,b1,b2,b3,c1,c2,c3], 21)) return true
    return false
}

function nextPiece() {
    let [countX, countO] = [0, 0]
    for(let i = 0; i < coordinate.length; i++) {
        if(coordinate[i] === X) countX++
        if(coordinate[i] === O) countO++
    }
    return countX === countO ? X : O
}

function countGames() {
    if (checkResult()) {
        count++
    }else {
        for (let i = 0; i < 9; i++) {
            if (coordinate[i] === EMPTY) {
                coordinate[i] = nextPiece()
                countGames()
                coordinate[i] = EMPTY
            }
        }
    }
}

countGames()
console.log(count)