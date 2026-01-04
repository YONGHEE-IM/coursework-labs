import pygame

class ship:
    """우주선을 관리하는 클래스"""
    def __init__(self, uw_game):  # 메인모듈의 UniverseWar 클래스 타입 객체를 두번째 
                                  # 매개 변수로 받아 ship 클래스에서 사용합니다. 
        self.screen = uw_game.screen    # 게임 화면에 접근하기 위해 매개변수에 연결된 게임 객체의 screen 멤버에 접근

        self.settings = uw_game.settings     # ship_speed 속성은 UniverseWar 타입 객체가 가지고 있으므로 멤버 변수에 일어와서 저장합니다. 
        self.screen_rect = uw_game.screen_get_rect()
        # 우주선 이미지를 가져와서 저장합니다. 
        self.image = pygame.image.load('images/ship.png')
        self.rect = self.image.get_rect()    # 우주선 그림의 직사각형 영역 정보를 가져옵니다. 

        self.rect.midbottom = self.screen_rect.midbottom   # 우주선 그림을 화면 중앙 아랫쪽에 배치합니다. 
        
        # 우주선의 가로 위치를 나타내는 소수점이 있는 값을 저장합니다.
        self.x = float(self.rect.x)
        
        self.moving_right = False
        self.moving_left = False

    def update(self):
        """움직임 플래그에 따라 우주선 위치를 갱신합니다."""
        if self.moving_right and self.rect.right < self.screen_rect.right:
            self.x += self.settings.ship_speed

        if self.moving_left and self.rect.left > 0:
            self.x -= self.settings.ship_speed

        self.rect.x = self.x

    def blitme(self):    # 우주선 그림을 해당 영역에 그립니다. 
        self.screen.blit(self.image, self.rect)