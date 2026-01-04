from car import Car

class ElectricCar(Car):
    def __init__(self, brand, model, production_year):
        # 부모클래스의 생성자를 호출하여 물려받은 부분(속성)을 초기화합니다.
        super().__init__(brand, model, production_year)
        self.battery = Battery()   # 배터리 클래스의 생성자를 호출해서 새 객체를 생성후 전기 자동차의 멤버로 저장
        
    # 부모로부터 물려받은 메서드 오버라이드
    def fill_gas_tank(self):
        pass

class Battery:
    def __init__(self, battery_size = 75):
        self.battery_size = battery_size

    def describe_battery(self):
        print(f"이 차의 배터리 용량은 {self.battery_size} kwh입니다.")

    def get_range(self):
        if self.battery_size == 75:
            range = 260
        elif self.battery_size == 100:
            range = 315