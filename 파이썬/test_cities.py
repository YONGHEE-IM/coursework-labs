import unittest
from city_functions import city_country

class CitiesTestCase(unittest. TestCase):
    # 테스트 메서드
    def test_city_country(self):
        """도시명 국가명이 올바르게 하나의 문자열로 연결되는가?"""
        santiago_chile = city_country('santiago', 'chile')
        self.assertEqual(santiago_chile, 'Santiago, chile')

if __name__ == '__main__':
    unittest.main()