def make_pizza(size, *toppings):
    """
    docstring:
    만들려는 피자에 대한 설명
    따로 모듈로 함수를 빼내서 호출합니다.
    """
    print(f"\nMaking a {size}-inch pizza with the following toppings: ")
    for topping in toppings:
        print(f" - {topping}")


def make_sandwich(*items):
    for item in items:
        print(f"{item}을 샌드위치에 추가합니다.")
    print("\n샌드위치가 만들어졌습니다.")