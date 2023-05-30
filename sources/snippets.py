def all_unique(l):
    return len(l) == len(set(l))

def is_palindrome(l):
    return l == l[::-1]