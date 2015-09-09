--[[
@brief 获取utf-8字符串的长度
utf-8
0xxxxxxx
110xxxxx 10xxxxxx
1110xxxx 10xxxxxx 10xxxxxx
11110xxx 10xxxxxx 10xxxxxx 10xxxxxx
111110xx 10xxxxxx 10xxxxxx 10xxxxxx 10xxxxxx
1111110x 10xxxxxx 10xxxxxx 10xxxxxx 10xxxxxx 10xxxxxx

0xxxxxxx >= 0
110xxxxx >= 0xc0
1110xxxx >= 0xe0
11110xxx >= 0xf0
111110xx >= 0xf8
1111110x >= 0xfc

https://en.wikipedia.org/wiki/UTF-8
]]

function getUtf8len(str)
	local len = string.len(str)
	local compare = {0xfc, 0xf8, 0xf0, 0xe0, 0xc0, 0}
	local cnt = 0
	local i = 1
	while true do
		if i > len then
			break
		end
		local asciiValue = string.byte(str, i)
		for j = 1, #compare do
			if asciiValue >= compare[j] then
				--跳过 7-j 个字符
				i = i + 7-j
				cnt = cnt + 1
				break
			end
		end
	end
	return cnt
end
