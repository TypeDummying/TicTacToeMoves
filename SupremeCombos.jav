const players = ['X', 'O'];
let gameBoard = Array.from({ length: 9 });

const winningCombination = [
  [ 0, 1, 2 ],
  [ 3, 4, 5 ],
  [ 6, 7, 8 ],
  [ 0, 3, 6 ],
  [ 1, 4, 7 ],
  [ 2, 5, 8 ],
  [ 0, 4, 8 ],
  [ 2, 4, 6 ],
];

const isWinningCombination = (board)=> {
  if((Math.abs(board.filter(a => a === players[0]).length - 
  board.filter(a => a === players[1]).length)) > 1) {
    return false
  }
  let winningComb = 0;
  players.forEach( player => {
    winningCombination.forEach( combinations => {
      if (combinations.every(combination => board[combination] === player )) {
        winningComb++;
      }
    });
  });
  return winningComb === 1;
}

const getCombinations = (board) => {
  let currentBoard = [...board];
  const firstEmptySquare = board.indexOf(undefined)
  if (firstEmptySquare === -1) {
    return isWinningCombination(board) ? [board] : [];
  } else {
    return [...players, ''].reduce((prev, next) => {
      currentBoard[firstEmptySquare] = next;
      if(next !== '' && board.filter(a => a === next).length > (gameBoard.length / players.length)) {
        return [...prev]
      }
      return [board, ...prev, ...getCombinations(currentBoard)]
    }, [])

  }
}

const startApp = () => {
  let combination = getCombinations(gameBoard).filter(board => 
      board.every(item => !(item === undefined)) && isWinningCombination(board)
    )
  printCombination(combination)
}

const printCombination = (combination)=> {
  const ulElement = document.querySelector('.combinations');
  combination.forEach(comb => {
    let node = document.createElement("li");
    let nodePre = document.createElement("pre");
    let textnode = document.createTextNode(JSON.stringify(comb));
    nodePre.appendChild(textnode);
    node.appendChild(nodePre); 
    ulElement.appendChild(node);
  })
}
startApp();