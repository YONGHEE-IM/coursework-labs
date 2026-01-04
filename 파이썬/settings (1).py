class Settings:
    """게임의 세팅을 저장하는 클래스"""

    def __init__(self):
        # 화면 세팅
        self.screen_width = 1200
        self.screen_height = 800
        self.bg_color = (230, 230, 230)

        # 우주선 세팅
        self.ship_speed = 1.5
        self.ship_limit = 

        # 탄환 세팅
        self.bullet_speed = 10
        self.bullet_width = 3
        self.bullet_height = 15
        self.bullet_color = (60, 60, 60)
        self.bullets_allowed = 3     #

        # 적 함대 세팅
        self.enemy_speed = 1.0
        self.fleet_drop_speed = 10  # 함대가 경계에 닿았을 때 내려올 위치좌표랑 
        self.fleet_direction = 1    # fleet_direction이 1이면 오른쪽, -1이면 왼쪽으로 이동 