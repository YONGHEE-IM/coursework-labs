class AnonymousSurvey:
    """ 설문 조사에서 익명 응답을 저장합니다."""

    def __init__(self, question):
        self.question = question    # 질문을 멤버 변수로 저장
        self.responses = []       # 응답을 저장할 리스트 

    def show_question(self):
        """설문을 출력"""
        print(self.question)

    def store_response(self, new_response):
        """받은 응답을 리스트에 저장합니다."""
        self.responses.append(new_response)


    def show_result(self):
        """받은 응답을 모두 표시합니다."""
        print("설문 결과:  ")
        for response in self.responses:
            print(f"- {response}")
        