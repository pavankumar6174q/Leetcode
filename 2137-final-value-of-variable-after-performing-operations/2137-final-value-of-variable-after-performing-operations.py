class Solution:
    def finalValueAfterOperations(self, operations: List[str]) -> int:
        a = 0
        for i in operations:
            if i == '--X' or i == 'X--':
                a -= 1
            else:
                a += 1
        return a

        