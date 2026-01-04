def get_formatted_name(first, last, middle=""): 
    """풀네임을 생성해서 반환합니다."""
    if middle:
        full_name = f"{first} {middle} {last}"
    else:
        full_name = f"{first} {last}"
    
    return full_name.title()