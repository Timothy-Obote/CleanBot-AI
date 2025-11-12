@echo off
echo ========================================
echo Setting up Vacuum Cleaner Simulation...
echo ========================================

REM 1. Check Python
python --version >nul 2>&1
IF %ERRORLEVEL% NEQ 0 (
    echo Python not found. Please install Python 3.8 or higher.
    pause
    exit /b
)
echo Python detected.

REM 2. Create virtual environment
python -m venv venv
echo Virtual environment created.

REM 3. Activate environment
call venv\Scripts\activate

REM 4. Upgrade pip
pip install --upgrade pip

REM 5. Install dependencies
pip install matplotlib numpy

REM 6. Create folder structure
mkdir environment
mkdir agents
mkdir metrics
mkdir visualization
mkdir tests

REM 7. Create files with starter code

REM main.py
echo from environment.environment import Environment> main.py
echo from agents.reflex_agent import ReflexAgent>> main.py
echo from metrics.metrics import Metrics>> main.py
echo import time>> main.py
echo.>> main.py
echo def main():>> main.py
echo     env = Environment(width=5, height=5)>> main.py
echo     agent = ReflexAgent()>> main.py
echo     metrics = Metrics()>> main.py
echo.>> main.py
echo     while not env.is_clean():>> main.py
echo         env.display()>> main.py
echo         percept = env.sense()>> main.py
echo         action = agent.choose_action(percept)>> main.py
echo         print(f"Agent action: {action}")>> main.py
echo.>> main.py
echo         if action == 'CLEAN':>> main.py
echo             env.clean()>> main.py
echo         else:>> main.py
echo             env.move_agent(action)>> main.py
echo.>> main.py
echo         metrics.update(action, percept)>> main.py
echo         time.sleep(0.5)>> main.py
echo.>> main.py
echo     print("\nFinal Environment State:")>> main.py
echo     env.display()>> main.py
echo     metrics.summary()>> main.py
echo.>> main.py
echo if __name__ == "__main__":>> main.py
echo     main()>> main.py

REM environment/environment.py
(
echo import random
echo.
echo class Environment:
echo     def __init__(self, width=5, height=5, dirt_prob=0.3):
echo         self.width = width
echo         self.height = height
echo         self.grid = [['Clean' for _ in range(width)] for _ in range(height)]
echo         self.agent_position = (0, 0)
echo         self.generate_dirt(dirt_prob)
echo.
echo     def generate_dirt(self, dirt_prob):
echo         for i in range(self.height):
echo             for j in range(self.width):
echo                 if random.random() ^< dirt_prob:
echo                     self.grid[i][j] = 'Dirty'
echo.
echo     def display(self):
echo         for i in range(self.height):
echo             row = ''
echo             for j in range(self.width):
echo                 if (i, j) == self.agent_position:
echo                     row += '[A] '
echo                 elif self.grid[i][j] == 'Dirty':
echo                     row += '[D] '
echo                 else:
echo                     row += '[C] '
echo             print(row)
echo         print()
echo.
echo     def sense(self):
echo         i, j = self.agent_position
echo         return self.grid[i][j]
echo.
echo     def move_agent(self, direction):
echo         i, j = self.agent_position
echo         if direction == 'UP' and i > 0:
echo             i -= 1
echo         elif direction == 'DOWN' and i < self.height - 1:
echo             i += 1
echo         elif direction == 'LEFT' and j > 0:
echo             j -= 1
echo         elif direction == 'RIGHT' and j < self.width - 1:
echo             j += 1
echo         self.agent_position = (i, j)
echo.
echo     def clean(self):
echo         i, j = self.agent_position
echo         if self.grid[i][j] == 'Dirty':
echo             self.grid[i][j] = 'Clean'
echo             print("Cell cleaned!")
echo.
echo     def is_clean(self):
echo         return all(cell == 'Clean' for row in self.grid for cell in row)
) > environment\environment.py

REM agents/reflex_agent.py
(
echo import random
echo.
echo class ReflexAgent:
echo     def __init__(self, name="ReflexAgent"):
echo         self.name = name
echo.
echo     def choose_action(self, percept):
echo         if percept == 'Dirty':
echo             return 'CLEAN'
echo         return random.choice(['UP','DOWN','LEFT','RIGHT'])
) > agents\reflex_agent.py

REM agents/model_agent.py
(
echo class ModelBasedAgent:
echo     def __init__(self):
echo         self.internal_model = {}
echo.
echo     def update_model(self, position, percept):
echo         self.internal_model[position] = percept
echo.
echo     def choose_action(self, position, percept):
echo         self.update_model(position, percept)
echo         if percept == 'Dirty':
echo             return 'CLEAN'
echo         return 'MOVE_RANDOM'
) > agents\model_agent.py

REM metrics/metrics.py
(
echo class Metrics:
echo     def __init__(self):
echo         self.cleaned_cells = 0
echo         self.total_moves = 0
echo.
echo     def update(self, action, percept):
echo         if action == 'CLEAN' and percept == 'Dirty':
echo             self.cleaned_cells += 1
echo         elif action in ['UP','DOWN','LEFT','RIGHT']:
echo             self.total_moves += 1
echo.
echo     def summary(self):
echo         print(f"Total cleaned cells: {self.cleaned_cells}")
echo         print(f"Total moves: {self.total_moves}")
) > metrics\metrics.py

REM 8. Create requirements.txt
echo matplotlib> requirements.txt
echo numpy>> requirements.txt

echo ========================================
echo ✅ Setup Complete! All files generated.
echo ========================================
echo Activate your environment with: venv\Scripts\activate
echo Run project: python main.py
pause
