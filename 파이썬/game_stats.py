# game_stats.py

class GameStats:
    """ 게임 기록 저장 """
    def __init__(self, uw_game):
        """ 기록 초기화 """
        self.settings = uw_game.settings
        self.reset_stats()

        self.game_active = True

    def reset_stats(self):
        """ 게임을 진행하는 동안 바뀔 수 있는 기록을 초기화합니다. """
        self.ships_left = self.settings.ship_limit