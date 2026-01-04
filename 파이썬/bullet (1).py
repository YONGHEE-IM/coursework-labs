# bullet.py

import pygame
from pygame.sprite import Sprite

class bullet(Sprite):
    """우주선에서 발사하는 탄환을 관리하는 클래스"""
    def __init__(self, uw_game):
        super().__init__()
        self.screen = uw_game.screen
        self.settings = uw_game.settings
        self.color = self.settings.bullet_color 

        # (0, 0)에 탄환 사각형을 만들고 정확한 위치를 지정합니다. 
        self.rect = pygame.Rect(0, 0, self.settings.bullet_width,
                                self.settings.bullet_height)
        self.rect.midtop = uw_game.ship.rect.midtop  # 총알은 우주선의 꼭대기에서 발사되므로 위치 지정 
        self.y = float(self.rect.y) 

    # 탄환의 위치를 갱신합니다.

    def update(self):
        self.y -= self.settings.bullet_speed
        self.rect.y = self.y

    def draw_bullet(self):
        # 탄환을 화면에 그립니다.
        pygame.draw.rect(self.screen, self.color, self.rect)

