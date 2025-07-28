#!/usr/bin/env lua

morse_alphabet = {
    ["A"] = ".-",    ["B"] = "-...",  ["C"] = "-.-.",  ["D"] = "-..",   ["E"] = ".",
    ["F"] = "..-.",  ["G"] = "--.",   ["H"] = "....",  ["I"] = "..",    ["J"] = ".---",
    ["K"] = "-.-",   ["L"] = ".-..",  ["M"] = "--",    ["N"] = "-.",    ["O"] = "---",
    ["P"] = ".--.",  ["Q"] = "--.-",  ["R"] = ".-.",   ["S"] = "...",   ["T"] = "-",
    ["U"] = "..-",   ["V"] = "...-",  ["W"] = ".--",   ["X"] = "-..-",  ["Y"] = "-.--",
    ["Z"] = "--..",
    ["0"] = "-----", ["1"] = ".----", ["2"] = "..---", ["3"] = "...--", ["4"] = "....-",
    ["5"] = ".....", ["6"] = "-....", ["7"] = "--...", ["8"] = "---..", ["9"] = "----."
}

local function char_to_morse(char)
	return morse_alphabet[char:upper()] or nil
end

local function txt_to_morse(txt)
	local morse_txt = {}
	for i = 1, #txt do
		local char = txt:sub(i, i)
		if char == " " then
			table.insert(morse_txt, "/") -- word separator
		elseif char == "\n" then
			table.insert(morse_txt, "\n")
		else
			local morse_char = char_to_morse(char)
			if morse_char then
				table.insert(morse_txt, morse_char)
			else
				table.insert(morse_txt, "?")
			end
		end
	end
	return table.concat(morse_txt, " ")
end

local filename = arg[1]

local txt_file = io.open(filename, "r")
if not txt_file then
    print("Error: could not open file '" .. filename .. "'")
    os.exit(1)
end

local txt = txt_file:read("*all")
txt_file:close()

print("Plain text:\n" .. txt)
print("Morse:\n" .. txt_to_morse(txt))
