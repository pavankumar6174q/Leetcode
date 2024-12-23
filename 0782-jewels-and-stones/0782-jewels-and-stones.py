class Solution:
    def numJewelsInStones(self, jewels: str, stones: str) -> int:
        ans = 0
        for i in jewels:
            for j in stones:
                if i == j:
                    ans += 1
        return ans

        