from environment.environment import Environment
from agent.reflex_agent import ReflexAgent
from metrics.metrics import Metrics
import time

def main():
    env = Environment(width=5, height=5)
    agent = ReflexAgent()
    metrics = Metrics()

    while not env.is_clean():
        env.display()
        percept = env.sense()
        action = agent.choose_action(percept)
        print(f"Agent action: {action}")

        if action == 'CLEAN':
            env.clean()
        else:
            env.move_agent(action)

        metrics.update(action, percept)
        time.sleep(0.5)

    print("\nFinal Environment State:")
    env.display()
    metrics.summary()

if __name__ == "__main__":
    main()
