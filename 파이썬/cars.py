class Car():
    def __init__(self, brand, model, production_year):
        self.brand = brand
        self.model = model
        self.production_year = production_year
        self.odometer_reading = 0     #클래스의 속성에는 기본값을 줄 수 있습니다.
        self.fuel = 0
        
    def get_descriptive_name(self):
        long_name = f"{self.production_year} {self.brand} {self.model}"
        return long_name

    def read_odometer(self):
        print(f"This car has {self.odometer_reading} miles on it.")

    # 주행거리를 롤백할 수 없으므로 현재 주행거리보다 입력값이 큰 경우에만 업데이트합니다.
    def update_odometer(self, mile_age):
        if mile_age >= self.odometer_reading:
            self.odometer_reading = mile_age
            
    # 호출시 매개변수로 들어오는 입력값 만큼 현재의 주행거리에 더하는 기능
    def increment_odometer(self, miles):
        # 추가할 값의 유효성 검사
        if miles >= 0:
            self.odometer_reading += miles
        else:
            print("주행거리를 감소할 수 없습니다.")

    def fill_gas_tank(self):
        self.fuel += 30
        print("연료를 30리터를 주유합니다.")

# car 클래스를 기반으로 전기 자동차 클래스를 정의합니다.

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

        print(f"주행 가능 거리: {range}")