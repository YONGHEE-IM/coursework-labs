import pygame
from pygame.sprite import Sprite

class Enemy(Sprite):

    def __init__(self, uw_game):
        """ 외계인 우주선을 초기화하고 시작 위치를 정합니다. """
        super().__init__()
        self.screen = uw_game.screen
        self.settings = uw_game.settings

        # 외계인 이미지를 불러오고 객체의 rect 속성을 설정합니다.
        self.image = pygame.image.load('images/enemy.png')
        self.rect = self.image.get_rect()

        # 외계인을 화면 좌측 상단에 배치합니다. 
        self.rect.x = self.rect.width
        self.rect.y = self.rect.height

        self.x = float(self.rect.x)

    def check_edges(self):
        """적 우주선이 화면 경계에 닿으면 True를 반환합니다."""
        screen_rect = self.screen.get_rect()

        if self.rect.right >= screen_rect.right or self.rect.left <= 0:
            return True

    def update(self):
        """적 우주선을 오른쪽이나 왼쪽으로 움직입니다."""
        self.x += (self.settings.enemy_speed * self.settings.fleet_direction)
        self.rect.x = self.x
        