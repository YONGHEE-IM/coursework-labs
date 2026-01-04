
import unittest
from survey import AnonymousSurvey

# 클래스 테스트를 위한 테스트 케이스 작성
class TestAnonymousSurvey(unittest.TestCase):
    """AnonymousSurvey 클래스 테스트"""
    def test_store_single_response(self):
        """응답 하나가 제대로 저장되는지 테스트"""
        question = "당신이 처음 배운 언어는 무엇인가요?"
        my_survey = AnonymousSurvey(question)
        my_survey.store_response('영어')
        # 응답이 제대로 저장되었는지 검증
        self.assertIn('영어', my_survey.responses)

if __name__ == '__main__':
    unittest.main()