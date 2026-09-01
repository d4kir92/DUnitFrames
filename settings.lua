-- By D4KiR
local _, DUnitFrames = ...
local ICON = 134167
local DEFAULT_WIDTH = 520
local DEFAULT_HEIGHT = 560
local dufset = nil
function DUnitFrames:GetFontFlags()
	if DUnitFrames:GetConfig("outline", true) then return "THINOUTLINE" end
	return ""
end

local DefaultFontSize = 12
local fontStrings = {}
function DUnitFrames:SetFont(fontString, fs)
	fs = fs or DefaultFontSize
	local fontFamily, fontSize, fontFlags = fontString:GetFont()
	if fontFamily ~= STANDARD_TEXT_FONT or fontSize ~= fs or fontFlags ~= DUnitFrames:GetFontFlags() then
		fontString:SetFont(STANDARD_TEXT_FONT, fs, DUnitFrames:GetFontFlags())
		if DUnitFrames:GetConfig("outline", true) then
			fontString:SetShadowOffset(0, 0)
		else
			fontString:SetShadowOffset(1, -1)
		end
	end

	fontString:SetDrawLayer("ARTWORK", 7)
	if not tContains(fontStrings, fontString) then tinsert(fontStrings, fontString) end
end

function DUnitFrames:UpdateTexts()
	for i, v in pairs(fontStrings) do
		v:SetText(v:GetText())
	end
end

local DUFLoaded = false
function DUnitFrames:GetConfig(key, value, pc)
	if DUFLoaded and DUFTAB ~= nil and DUFTABPC ~= nil then
		if pc then
			if DUFTABPC[key] ~= nil then
				value = DUFTABPC[key]
			else
				DUFTABPC[key] = value
			end
		else
			if DUFTAB[key] ~= nil then
				value = DUFTAB[key]
			else
				DUFTAB[key] = value
			end
		end
	end
	return value
end

function DUnitFrames:SetConfig(key, value, pc)
	if pc then
		if DUFTABPC == nil then return end
		DUFTABPC[key] = value
		return
	end

	if DUFTAB == nil then return end
	DUFTAB[key] = value
end

function DUnitFrames:ToggleSettings()
	if dufset == nil then return end
	dufset:Toggle()
end

local function GetCollapsed(key)
	if key == nil then return nil end
	if type(DUFTAB) ~= "table" then return nil end
	if type(DUFTAB["COLLAPSED"]) ~= "table" then return nil end
	return DUFTAB["COLLAPSED"][key]
end

local function SetCollapsed(key, collapsed)
	if key == nil then return end
	if type(DUFTAB) ~= "table" then return end
	if type(DUFTAB["COLLAPSED"]) ~= "table" then DUFTAB["COLLAPSED"] = {} end
	if collapsed then
		DUFTAB["COLLAPSED"][key] = true
	else
		DUFTAB["COLLAPSED"][key] = nil
	end
end

local function LID(key)
	return "LID_" .. string.upper(key)
end

local function AddCategory(key, level)
	dufset:AddCategory({
		["label"] = LID(key),
		["key"] = key,
		["search"] = key,
		["level"] = level
	})
end

local function AddCheckbox(key, default, func)
	dufset:AddCheckbox({
		["label"] = LID(key),
		["search"] = key,
		["value"] = DUnitFrames:GetConfig(key, default),
		["func"] = function(value)
			DUnitFrames:SetConfig(key, value)
			if func then func(value) end
		end
	})
end

local function AddSlider(key, default, vmin, vmax, step, func)
	dufset:AddSlider({
		["label"] = LID(key),
		["search"] = key,
		["value"] = DUnitFrames:GetConfig(key, default),
		["min"] = vmin,
		["max"] = vmax,
		["step"] = step,
		["decimals"] = 0,
		["func"] = function(value)
			DUnitFrames:SetConfig(key, value)
			if func then func() end
		end
	})
end

local function AddDropdown(key, default, choices, func)
	dufset:AddDropdown({
		["label"] = LID(key),
		["search"] = key,
		["value"] = DUnitFrames:GetConfig(key, default),
		["choices"] = choices,
		["func"] = function(value)
			DUnitFrames:SetConfig(key, value)
			if func then func() end
		end
	})
end

local function Choices(...)
	local choices = {}
	for _, value in ipairs({...}) do
		local label = value
		if value == "Default" then label = "LID_DEFAULT" end
		tinsert(choices, {
			["value"] = value,
			["label"] = label
		})
	end
	return choices
end

local function PortraitChoices()
	return Choices("Dark", "Bright", "Dark-Grey", "DarkV2", "DarkV2Small", "Light", "MediumGrey", "Muted", "Old", "White", "New", "Default")
end

local function UpdatePortraits()
	if PlayerFrame then UnitFramePortrait_Update(PlayerFrame) end
	for id = 1, 4 do
		if _G["PartyMemberFrame" .. id] then UnitFramePortrait_Update(_G["PartyMemberFrame" .. id]) end
	end
end

local function UpdateHealthTextsRight()
	if PlayerFrameHealthBarTextRight then PlayerFrameHealthBarTextRight:SetText(PlayerFrameHealthBarTextRight:GetText()) end
	if TargetFrameHealthBarTextRight then TargetFrameHealthBarTextRight:SetText(TargetFrameHealthBarTextRight:GetText()) end
	if FocusFrameTextureFrameHealthBarTextRight then FocusFrameTextureFrameHealthBarTextRight:SetText(FocusFrameTextureFrameHealthBarTextRight:GetText()) end
end

local function UpdateHealthTextsLeft()
	if PlayerFrameHealthBarTextLeft then PlayerFrameHealthBarTextLeft:SetText(PlayerFrameHealthBarTextLeft:GetText()) end
	if TargetFrameHealthBarTextLeft then TargetFrameHealthBarTextLeft:SetText(TargetFrameHealthBarTextLeft:GetText()) end
	if FocusFrameTextureFrameHealthBarTextLeft then FocusFrameTextureFrameHealthBarTextLeft:SetText(FocusFrameTextureFrameHealthBarTextLeft:GetText()) end
end

local function UpdateNames()
	if PlayerName then PlayerName:SetText(PlayerName:GetText()) end
	if TargetFrameTextureFrameName then TargetFrameTextureFrameName:SetText(TargetFrameTextureFrameName:GetText()) end
	if FocusFrameTextureFrameName then FocusFrameTextureFrameName:SetText(FocusFrameTextureFrameName:GetText()) end
end

local function UpdateFrameSizes()
	DUnitFrames:UpdatePlayerFrame()
	DUnitFrames:UpdateTargetFrame()
	DUnitFrames:UpdateTargetTexture()
	if DUnitFrames.UpdateFocusFrame then DUnitFrames:UpdateFocusFrame() end
	if DUnitFrames.UpdateFocusTexture then DUnitFrames:UpdateFocusTexture() end
	if DUnitFrames.UpdatePartyMemberFrames then DUnitFrames:UpdatePartyMemberFrames() end
	for id = 1, 4 do
		local func = _G["DUFUpdateParty" .. id .. "Texture"]
		if func then func() end
	end
end

local function UpdateBarTextures()
	if PlayerFrameHealthBar then PlayerFrameHealthBar:SetStatusBarTexture("") end
	if PlayerFrameManaBar then PlayerFrameManaBar:SetStatusBarTexture("") end
	if TargetFrameHealthBar then TargetFrameHealthBar:SetStatusBarTexture("") end
	if TargetFrameManaBar then TargetFrameManaBar:SetStatusBarTexture("") end
	if FocusFrameHealthBar then FocusFrameHealthBar:SetStatusBarTexture("") end
	if FocusFrameManaBar then FocusFrameManaBar:SetStatusBarTexture("") end
end

local function AddDiscordFooter()
	local footer = dufset:AddFooter({
		["height"] = 24
	})

	local discord = CreateFrame("EditBox", "DUFSettingsDiscord", footer, "InputBoxTemplate")
	discord:SetSize(160, 24)
	discord:SetPoint("RIGHT", footer, "RIGHT", 0, 0)
	discord:SetAutoFocus(false)
	discord:SetText("discord.gg/UeBsafs")
	local label = footer:CreateFontString(nil, "ARTWORK", "GameFontNormal")
	label:SetPoint("RIGHT", discord, "LEFT", -6, 0)
	label:SetText("Discord")
end

local dufsetting = false
function DUnitFrames:InitSettings()
	if dufsetting then return end
	dufsetting = true
	dufset = DUnitFrames:CreateUIWindow({
		["name"] = "DUnitFramesSettings",
		["pTab"] = {"CENTER"},
		["width"] = DUnitFrames:GetConfig("WINDOWWIDTH", DEFAULT_WIDTH),
		["height"] = DUnitFrames:GetConfig("WINDOWHEIGHT", DEFAULT_HEIGHT),
		["minWidth"] = 360,
		["minHeight"] = 240,
		["onResize"] = function(width, height)
			DUnitFrames:SetConfig("WINDOWWIDTH", width)
			DUnitFrames:SetConfig("WINDOWHEIGHT", height)
		end,
		["getCollapsed"] = function(key) return GetCollapsed(key) end,
		["setCollapsed"] = function(key, collapsed) SetCollapsed(key, collapsed) end,
		["title"] = format("|T%d:16:16:0:0|t DUnitFrames by |cff55d2ffD4KiR|r v%s", ICON, DUnitFrames:GetVersion())
	})

	dufset:SuspendLayout()
	dufset:AddSearch()
	AddCategory("GENERAL")
	AddCheckbox("MMBTN", DUnitFrames:GetWoWBuild() ~= "RETAIL", function(value)
		if value then
			DUnitFrames:ShowMMBtn("DUnitFrames")
		else
			DUnitFrames:HideMMBtn("DUnitFrames")
		end
	end)

	AddCategory("PORTRAIT")
	AddDropdown("portraitmodeself", "Dark", PortraitChoices(), UpdatePortraits)
	AddDropdown("portraitmode", "Dark", PortraitChoices(), UpdatePortraits)
	AddCategory("BARS")
	AddDropdown("barmode", "Class+Status", Choices("Class+Status", "Class", "Status", "Default"), function() DUnitFrames:UpdateBarColors() end)
	AddSlider("bartexture", 0, 0, 18, 1, UpdateBarTextures)
	AddSlider("hpheight", 27, 12, 27, 1, UpdateFrameSizes)
	AddCheckbox("alternatemanabar", true)
	AddCategory("BORDER")
	AddDropdown("bordermode", "Class+Status", Choices("Class+Status", "Class", "Status", "Dark", "Black", "Default"), function() DUnitFrames:UpdateBorderColors() end)
	AddCategory("TEXT")
	AddCheckbox("outline", true, function() DUnitFrames:UpdateTexts() end)
	AddCategory("NAME", 2)
	AddDropdown("namemode", "Over Portrait", Choices("Over Portrait", "Over Health", "Inside Health", "Hide"), UpdateNames)
	AddSlider("namesize", 10, 6, 20, 1, UpdateNames)
	AddCategory("VALUES", 2)
	AddDropdown("numbermode", "X.X Dynamic", Choices("Default", "X Dynamic", "X.X Dynamic", "X.XX Dynamic", "X.XXX", "XK", "X.XK", "X.XXK"), UpdateHealthTextsRight)
	AddDropdown("percentmode", "X.X%", Choices("Default", "X.X%", "X.XX%"), UpdateHealthTextsLeft)
	AddCategory("PLAYERFRAME")
	AddCheckbox("hidewhenfull", false)
	if ComboPointPlayerFrame then AddCheckbox("hidecombopoints", false, UpdatePortraits) end
	AddCategory("TARGETFRAME")
	AddCheckbox("showthreat", true)
	if CanInspect and GetInspectSpecialization then AddCheckbox("showspecs", true) end
	AddDiscordFooter()
	dufset:ResumeLayout()
	DUnitFrames:CreateMinimapButton({
		["name"] = "DUnitFrames",
		["icon"] = ICON,
		["dbtab"] = DUFTAB,
		["dbkey"] = "MMBTN",
		["vTT"] = {{format("|T%d:16:16:0:0|t DUnitFrames", ICON), "v" .. DUnitFrames:GetVersion()}, {DUnitFrames:Trans("LID_LEFTCLICK"), DUnitFrames:Trans("LID_OPENSETTINGS")}, {DUnitFrames:Trans("LID_RIGHTCLICK"), DUnitFrames:Trans("LID_HIDEMINIMAPBUTTON")}},
		["funcL"] = function() DUnitFrames:ToggleSettings() end,
		["funcR"] = function()
			DUnitFrames:SetConfig("MMBTN", false)
			DUnitFrames:HideMMBtn("DUnitFrames")
		end
	})

	DUnitFrames:AddSlash("duf", function() DUnitFrames:ToggleSettings() end)
	DUnitFrames:AddSlash("dunitframes", function() DUnitFrames:ToggleSettings() end)
end

local f = CreateFrame("Frame")
f:RegisterEvent("PLAYER_ENTERING_WORLD")
local once = true
function f:OnEvent(event, ...)
	if event == "PLAYER_ENTERING_WORLD" and once then
		once = false
		DUFTAB = DUFTAB or {}
		DUFTABPC = DUFTABPC or {}
		DUnitFrames:SetAddonOutput("DUnitFrames", ICON)
		DUnitFrames:SetVersion(ICON, "1.4.0")
		if DUFTAB["bartexture"] == nil then DUFTAB["bartexture"] = 0 end
		DUFLoaded = true
		if PlayerPortrait then UnitFramePortrait_Update(PlayerPortrait) end
		if PlayerFrameTexture then PlayerFrameTexture:SetVertexColor(1, 1, 1) end
		DUnitFrames:PlayerFrameSetup()
		DUnitFrames:TargetFrameSetup()
		if DUnitFrames.FocusFrameSetup then DUnitFrames:FocusFrameSetup() end
		if DUnitFrames.PartyMemberFramesSetup then DUnitFrames:PartyMemberFramesSetup() end
		if PlayerFrame then UnitFramePortrait_Update(PlayerFrame) end
		for id = 1, 4 do
			if _G["PartyMemberFrame" .. id] then UnitFramePortrait_Update(_G["PartyMemberFrame" .. id]) end
		end

		-- PlayerFrame
		hooksecurefunc("PlayerFrame_ToPlayerArt", DUnitFrames.UpdatePlayerFrame)
		-- TargetFrame
		if TargetFrame_CheckClassification then
			hooksecurefunc("TargetFrame_CheckClassification", function()
				DUnitFrames:UpdateTargetTexture()
				if DUnitFrames.UpdateFocusTexture then DUnitFrames:UpdateFocusTexture() end
			end)
		end

		DUnitFrames:InitSettings()
	end
end

f:SetScript("OnEvent", f.OnEvent)
