class TicTacToe:
    def __init__(self):
        self.board = [' ' for _ in range(9)]
        self.current_winner = None

    def print_board(self):
        for row in [self.board[i*3:(i+1)*3] for i in range(3)]:
            print('| ' + ' | '.join(row) + ' |')

    def available_moves(self):
        return [i for i, spot in enumerate(self.board) if spot == ' ']

    def make_move(self, square, letter):
        if self.board[square] == ' ':
            self.board[square] = letter
            if self.winner(square, letter):
                self.current_winner = letter
            return True
        return False

    def winner(self, square, letter):
        # Check the row
        row_ind = square // 3
        row = self.board[row_ind*3:(row_ind+1)*3]
        if all([spot == letter for spot in row]):
            return True
        # Check the column
        col_ind = square % 3
        column = [self.board[col_ind+i*3] for i in range(3)]
        if all([spot == letter for spot in column]):
            return True
        # Check diagonals
        if square % 2 == 0:
            diagonal1 = [self.board[i] for i in [0, 4, 8]]
            if all([spot == letter for spot in diagonal1]):
                return True
            diagonal2 = [self.board[i] for i in [2, 4, 6]]
            if all([spot == letter for spot in diagonal2]):
                return True
        return False

    def empty_squares(self):
        return ' ' in self.board

    def num_empty_squares(self):
        return self.board.count(' ')

    def play_game(self, game, player='X'):
        if not self.empty_squares():
            if self.current_winner:
                game['wins'][self.current_winner] += 1
            else:
                game['ties'] += 1
            return

        for move in self.available_moves():
            # Make the move
            self.make_move(move, player)
            # Recurse using the other player
            self.play_game(game, 'O' if player == 'X' else 'X')
            # Undo the move
            self.board[move] = ' '
            self.current_winner = None

        return game

# Initialize the game statistics
game_stats = {'wins': {'X': 0, 'O': 0}, 'ties': 0}

# Create a new game instance
game = TicTacToe()

# Simulate all possible games
all_games = game.play_game(game_stats)

print(f"Total games: {sum(all_games['wins'].values()) + all_games['ties']}")
print(f"X wins: {all_games['wins']['X']}")
print(f"O wins: {all_games['wins']['O']}")
print(f"Ties: {all_games['ties']}")
