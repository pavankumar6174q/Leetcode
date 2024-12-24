class Solution:
    def mostWordsFound(self, sentences: List[str]) -> int:
        maximum = 0
        for s in sentences:
            words = s.split()
            length = len(words)
            if length > maximum:
                maximum = length
        return maximum

        