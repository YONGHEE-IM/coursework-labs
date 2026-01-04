import unittest
from name_function import get_formatted_name

class NameTestCase(unittest.TestCase):
    """name_function.py 테스트"""

    # 첫 번째 테스트 메서드
    def test_first_last_name(self):
        """taylor swift 같은 이름이 제대로 동작하는가?"""
        formatted_name = get_formatted_name('taylor', 'swift')
        self.assertEqual(formatted_name, 'taylor swift')

    # 두 번째 테스트 메서드
    def test_first_last_middle_name(self):
        formatted_name = get_formatted_name('wolfgang', 'mozart', 'amadeus')
        self.assertEqual(formatted_name, "Wolfgang Amadeus Mozart")

if __name__ == '__main__':
    unittest.main()