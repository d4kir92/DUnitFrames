local _, DUnitFrames = ...
DUnitFrames:SetAddonOutput("DUnitFrames", 134167)
-- LIB Design
local lang = {}
function DUnitFrames:GetLang()
	return lang
end

function DUnitFrames:GT(str, tab)
	local strid = str
	local result = lang[strid]
	if result ~= nil then
		if tab ~= nil then
			for i, v in pairs(tab) do
				local find = i -- "[" .. i .. "]"
				local replace = v
				if find ~= nil and replace ~= nil then
					result = string.gsub(result, find, replace)
				end
			end
		end

		return result
	else
		return str
	end
end

function DUnitFrames:UpdateLanguage()
	DUnitFrames:DUFLang_enUS()
	if GetLocale() == "enUS" then
		DUnitFrames:DUFLang_enUS()
	elseif GetLocale() == "deDE" then
		DUnitFrames:DUFLang_deDE()
	elseif GetLocale() == "ruRU" then
		DUnitFrames:DUFLang_ruRU()
	elseif GetLocale() == "zhTW" then
		DUnitFrames:DUFLang_zhTW()
	end
end

DUnitFrames:UpdateLanguage()
