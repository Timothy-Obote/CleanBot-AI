import random

class Environment:
    def __init__(self, width=5, height=5, dirt_prob=0.3):
        self.width = width
        self.height = height
        self.grid = [['Clean' for _ in range(width)] for _ in range(height)]
        self.agent_position = (0, 0)
        self.generate_dirt(dirt_prob)

    def generate_dirt(self, dirt_prob):
        """Randomly place dirt on the grid"""
        for i in range(self.height):
            for j in range(self.width):
                if random.random() < dirt_prob:
                    self.grid[i][j] = 'Dirty'

    def display(self):
        """Display the grid in terminal"""
        for i in range(self.height):
            row = ''
            for j in range(self.width):
                if (i, j) == self.agent_position:
                    row += '[A] '
                elif self.grid[i][j] == 'Dirty':
                    row += '[D] '
                else:
                    row += '[C] '
            print(row)
        print()

    def sense(self):
        """Return current cell state"""
        i, j = self.agent_position
        return self.grid[i][j]

    def move_agent(self, direction):
        """Move agent in the grid"""
        i, j = self.agent_position
        if direction == 'UP' and i > 0:
            i -= 1
        elif direction == 'DOWN' and i < self.height - 1:
            i += 1
        elif direction == 'LEFT' and j > 0:
            j -= 1
        elif direction == 'RIGHT' and j < self.width - 1:
            j += 1
        self.agent_position = (i, j)

    def clean(self):
        """Clean the current cell"""
        i, j = self.agent_position
        if self.grid[i][j] == 'Dirty':
            self.grid[i][j] = 'Clean'
            print("Cell cleaned!")

    def is_clean(self):
        """Check if all cells are clean"""
        return all(cell == 'Clean' for row in self.grid for cell in row)
