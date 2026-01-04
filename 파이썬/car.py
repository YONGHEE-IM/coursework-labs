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