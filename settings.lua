-- By D4KiR
local _, DUnitFrames = ...
local LibDD = LibStub:GetLibrary("LibUIDropDownMenu-4.0")
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
	if not tContains(fontStrings, fontString) then
		tinsert(fontStrings, fontString)
	end
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

function DUnitFrames:CreateSlider(parent, key, vval, x, y, vmin, vmax, steps, lstr, func)
	local SL = CreateFrame("Slider", nil, parent, "UISliderTemplate")
	SL:SetSize(600, 16)
	SL:SetPoint("TOPLEFT", x, y)
	if SL.Low == nil then
		SL.Low = SL:CreateFontString(nil, nil, "GameFontNormal")
		SL.Low:SetPoint("BOTTOMLEFT", SL, "BOTTOMLEFT", 0, -12)
		SL.Low:SetFont(STANDARD_TEXT_FONT, 10, "THINOUTLINE")
		SL.Low:SetTextColor(1, 1, 1)
	end

	if SL.High == nil then
		SL.High = SL:CreateFontString(nil, nil, "GameFontNormal")
		SL.High:SetPoint("BOTTOMRIGHT", SL, "BOTTOMRIGHT", 0, -12)
		SL.High:SetFont(STANDARD_TEXT_FONT, 10, "THINOUTLINE")
		SL.High:SetTextColor(1, 1, 1)
	end

	if SL.Text == nil then
		SL.Text = SL:CreateFontString(nil, nil, "GameFontNormal")
		SL.Text:SetPoint("TOP", SL, "TOP", 0, 16)
		SL.Text:SetFont(STANDARD_TEXT_FONT, 12, "THINOUTLINE")
		SL.Text:SetTextColor(1, 1, 1)
	end

	SL.Low:SetText(vmin)
	SL.High:SetText(vmax)
	SL.Text:SetText(DUnitFrames:GT(lstr) .. ": " .. DUnitFrames:GetConfig(key, vval))
	SL:SetMinMaxValues(vmin, vmax)
	SL:SetValue(DUnitFrames:GetConfig(key, vval))
	SL:SetObeyStepOnDrag(steps)
	SL:SetValueStep(steps)
	SL.oldval = nil
	SL:SetScript(
		"OnValueChanged",
		function(sel, val)
			val = tonumber(string.format("%.0f", val))
			if vmin and val < vmin then
				val = vmin
			end

			if vmax and val > vmax then
				val = vmax
			end

			if val ~= sel.oldval then
				sel.oldval = val
				SL.Text:SetText(DUnitFrames:GT(lstr) .. ": " .. val)
				DUFTAB[key] = val
				if func ~= nil then
					func()
				end
			end
		end
	)

	return SL
end

function DUnitFrames:CreateCheckBox(parent, key, vval, x, y, lstr, pc, func)
	local CB = CreateFrame("CheckButton", nil, parent, "ChatConfigCheckButtonTemplate")
	CB:SetSize(24, 24)
	CB:SetPoint("TOPLEFT", x, y)
	CB.Text:SetPoint("LEFT", CB, "RIGHT", 0, 0)
	CB.Text:SetText(DUnitFrames:GT(lstr))
	CB:SetChecked(DUnitFrames:GetConfig(key, vval))
	CB:SetScript(
		"OnClick",
		function(sel, val)
			val = CB:GetChecked()
			if pc then
				DUFTABPC[key] = val
			else
				DUFTAB[key] = val
			end

			CB.Text:SetText(DUnitFrames:GT(lstr))
			if func then
				func()
			end
		end
	)

	return CB
end

function DUnitFrames:CreateComboBox(parent, key, vval, x, y, lstr, tab, func)
	local CB = LibDD:Create_UIDropDownMenu("Frame", parent)
	CB:SetPoint("TOPLEFT", x, y)
	CB.text = CB:CreateFontString(nil, "ARTWORK")
	CB.text:SetFont(STANDARD_TEXT_FONT, 12, "")
	CB.text:SetText(DUnitFrames:GT(lstr))
	CB.text:SetPoint("LEFT", CB, "RIGHT", 0, 3)
	CB.Text:SetText(DUnitFrames:GT(lstr) .. ": " .. tostring(DUnitFrames:GetConfig(key, vval)))
	LibDD:UIDropDownMenu_SetWidth(CB, 120)
	LibDD:UIDropDownMenu_SetText(CB, DUnitFrames:GetConfig(key, vval))
	-- Create and bind the initialization function to the dropdown menu
	LibDD:UIDropDownMenu_Initialize(
		CB,
		function(sel, level, menuList)
			for i, v in pairs(tab) do
				local info = LibDD:UIDropDownMenu_CreateInfo()
				info.func = sel.SetValue
				info.text = v
				info.arg1 = v
				LibDD:UIDropDownMenu_AddButton(info)
			end
		end
	)

	function CB:SetValue(newValue)
		DUFTAB[key] = newValue
		LibDD:UIDropDownMenu_SetText(CB, newValue)
		LibDD:CloseDropDownMenus()
		if func ~= nil then
			func()
		end
	end

	return CB
end

local Y = 0
local dufsetting = false
function DUnitFrames:InitSettings()
	if not dufsetting then
		dufsetting = true
		local DUFSettings = {}
		local DUFname = "DUnitFrames |T134167:16:16:0:0|t by |cff3FC7EBD4KiR |T132115:16:16:0:0|t"
		local settingname = DUFname
		DUFSettings.panel = CreateFrame("FRAME")
		DUFSettings.panel.name = settingname
		Y = 0
		Y = Y - 10
		local text = DUFSettings.panel:CreateFontString(nil, "ARTWORK")
		text:SetFont(STANDARD_TEXT_FONT, 10, "OUTLINE")
		text:SetPoint("TOPLEFT", DUFSettings.panel, "TOPLEFT", 10, Y)
		text:SetText("Settings (v" .. DUnitFrames:GetVersion() .. ")")
		DUnitFrames:CreateComboBox(
			DUFSettings.panel,
			"portraitmode",
			"Dark",
			0,
			-30,
			"portraitmode",
			{"Dark", "Bright", "Dark-Grey", "DarkV2", "DarkV2Small", "Light", "MediumGrey", "Muted", "Old", "White", "New", "Default"},
			function()
				if PlayerFrame then
					UnitFramePortrait_Update(PlayerFrame)
				end

				for id = 1, 4 do
					if _G["PartyMemberFrame" .. id] then
						UnitFramePortrait_Update(_G["PartyMemberFrame" .. id])
					end
				end
			end
		)

		DUnitFrames:CreateComboBox(
			DUFSettings.panel,
			"portraitmodeself",
			"Dark",
			0,
			-60,
			"portraitmodeself",
			{"Dark", "Bright", "Dark-Grey", "DarkV2", "DarkV2Small", "Light", "MediumGrey", "Muted", "Old", "White", "New", "Default"},
			function()
				if PlayerFrame then
					UnitFramePortrait_Update(PlayerFrame)
				end

				for id = 1, 4 do
					if _G["PartyMemberFrame" .. id] then
						UnitFramePortrait_Update(_G["PartyMemberFrame" .. id])
					end
				end
			end
		)

		DUnitFrames:CreateComboBox(
			DUFSettings.panel,
			"bordermode",
			"Class+Status",
			0,
			-90,
			"bordermode",
			{"Class+Status", "Class", "Status", "Dark", "Black", "Default"},
			function()
				DUnitFrames:UpdateBorderColors()
			end
		)

		DUnitFrames:CreateComboBox(
			DUFSettings.panel,
			"barmode",
			"Class+Status",
			0,
			-120,
			"barmode",
			{"Class+Status", "Class", "Status", "Default"},
			function()
				DUnitFrames:UpdateBarColors()
			end
		)

		DUnitFrames:CreateComboBox(
			DUFSettings.panel,
			"numbermode",
			"X.X Dynamic",
			0,
			-150,
			"numbermode",
			{"Default", "X Dynamic", "X.X Dynamic", "X.XX Dynamic", "X.XXX", "XK", "X.XK", "X.XXK"},
			function()
				if PlayerFrameHealthBarTextRight then
					PlayerFrameHealthBarTextRight:SetText(PlayerFrameHealthBarTextRight:GetText())
				end

				if TargetFrameHealthBarTextRight then
					TargetFrameHealthBarTextRight:SetText(TargetFrameHealthBarTextRight:GetText())
				end

				if FocusFrameTextureFrameHealthBarTextRight then
					FocusFrameTextureFrameHealthBarTextRight:SetText(FocusFrameTextureFrameHealthBarTextRight:GetText())
				end
			end
		)

		DUnitFrames:CreateComboBox(
			DUFSettings.panel,
			"percentmode",
			"X.X%",
			0,
			-180,
			"percentmode",
			{"Default", "X.X%", "X.XX%"},
			function()
				if PlayerFrameHealthBarTextLeft then
					PlayerFrameHealthBarTextLeft:SetText(PlayerFrameHealthBarTextLeft:GetText())
				end

				if TargetFrameHealthBarTextLeft then
					TargetFrameHealthBarTextLeft:SetText(TargetFrameHealthBarTextLeft:GetText())
				end

				if FocusFrameTextureFrameHealthBarTextLeft then
					FocusFrameTextureFrameHealthBarTextLeft:SetText(FocusFrameTextureFrameHealthBarTextLeft:GetText())
				end
			end
		)

		DUnitFrames:CreateComboBox(
			DUFSettings.panel,
			"namemode",
			"Over Portrait",
			0,
			-210,
			"namemode",
			{"Over Portrait", "Over Health", "Inside Health", "Hide"},
			function()
				TargetFrameTextureFrameName:SetText(TargetFrameTextureFrameName:GetText())
			end
		)

		DUnitFrames:CreateCheckBox(
			DUFSettings.panel,
			"outline",
			true,
			400,
			-210,
			"outline",
			nil,
			function()
				DUnitFrames:UpdateTexts()
			end
		)

		DUnitFrames:CreateSlider(
			DUFSettings.panel,
			"hpheight",
			27,
			10,
			-270,
			12,
			27,
			1,
			"hpheight",
			function()
				DUnitFrames:UpdatePlayerFrame()
				DUnitFrames:UpdateTargetFrame()
				DUnitFrames:UpdateTargetTexture()
				if DUnitFrames.UpdateFocusFrame then
					DUnitFrames:UpdateFocusFrame()
				end

				if DUnitFrames.UpdateFocusTexture then
					DUnitFrames:UpdateFocusTexture()
				end

				if DUnitFrames.UpdatePartyMemberFrames then
					DUnitFrames:UpdatePartyMemberFrames()
				end

				for id = 1, 4 do
					local func = _G["DUFUpdateParty" .. id .. "Texture"]
					if func then
						func()
					end
				end
			end
		)

		DUnitFrames:CreateSlider(
			DUFSettings.panel,
			"namesize",
			10,
			10,
			-320,
			6,
			20,
			1,
			"namesize",
			function()
				if PlayerName then
					PlayerName:SetText(PlayerName:GetText())
				end

				if TargetFrameTextureFrameName then
					TargetFrameTextureFrameName:SetText(TargetFrameTextureFrameName:GetText())
				end

				if FocusFrameTextureFrameName then
					FocusFrameTextureFrameName:SetText(FocusFrameTextureFrameName:GetText())
				end
			end
		)

		DUnitFrames:CreateCheckBox(DUFSettings.panel, "hidewhenfull", false, 10, -340, "hidewhenfull")
		if ComboPointPlayerFrame then
			DUnitFrames:CreateCheckBox(DUFSettings.panel, "hidecombopoints", false, 10, -360, "hidecombopoints")
		end

		if CanInspect and GetInspectSpecialization then
			DUnitFrames:CreateCheckBox(DUFSettings.panel, "showspecs", true, 10, -380, "showspecs")
		end

		DUnitFrames:CreateCheckBox(DUFSettings.panel, "showthreat", true, 10, -420, "showthreat")
		DUnitFrames:CreateSlider(
			DUFSettings.panel,
			"bartexture",
			0,
			10,
			-460,
			0,
			18,
			1,
			"bartexture",
			function()
				if PlayerFrameHealthBar then
					PlayerFrameHealthBar:SetStatusBarTexture("")
				end

				if PlayerFrameManaBar then
					PlayerFrameManaBar:SetStatusBarTexture("")
				end

				if TargetFrameHealthBar then
					TargetFrameHealthBar:SetStatusBarTexture("")
				end

				if TargetFrameManaBar then
					TargetFrameManaBar:SetStatusBarTexture("")
				end

				if FocusFrameHealthBar then
					FocusFrameHealthBar:SetStatusBarTexture("")
				end

				if FocusFrameManaBar then
					FocusFrameManaBar:SetStatusBarTexture("")
				end
			end
		)

		local b = CreateFrame("Button", "MyButton", DUFSettings.panel, "UIPanelButtonTemplate")
		b:SetSize(200, 24) -- width, height
		b:SetText("DISCORD")
		b:SetPoint("BOTTOMLEFT", 10, 10)
		b:SetScript(
			"OnClick",
			function()
				local iconbtn = 32
				local s = CreateFrame("Frame", nil, UIParent) -- or you actual parent instead
				s:SetSize(300, 2 * iconbtn + 2 * 10)
				s:SetPoint("CENTER")
				s.texture = s:CreateTexture(nil, "BACKGROUND")
				s.texture:SetColorTexture(0, 0, 0, 0.5)
				s.texture:SetAllPoints(s)
				s.text = s:CreateFontString(nil, "ARTWORK")
				s.text:SetFont(STANDARD_TEXT_FONT, 11, "")
				s.text:SetText("Feedback")
				s.text:SetPoint("CENTER", s, "TOP", 0, -10)
				local eb = CreateFrame("EditBox", "logEditBox", s, "InputBoxTemplate")
				eb:SetFrameStrata("DIALOG")
				eb:SetSize(280, iconbtn)
				eb:SetAutoFocus(false)
				eb:SetText("https://discord.gg/UeBsafs")
				eb:SetPoint("TOPLEFT", 10, -10 - iconbtn)
				s.close = CreateFrame("Button", "closediscord", s, "UIPanelButtonTemplate")
				s.close:SetFrameStrata("DIALOG")
				s.close:SetPoint("TOPLEFT", 300 - 10 - iconbtn, -10)
				s.close:SetSize(iconbtn, iconbtn)
				s.close:SetText("X")
				s.close:SetScript(
					"OnClick",
					function(sel, btn, down)
						s:Hide()
					end
				)
			end
		)

		DUnitFrames:CreateCheckBox(DUFSettings.panel, "alternatemanabar", true, 400, -230, "alternatemanabar")
		if InterfaceOptions_AddCategory then
			InterfaceOptions_AddCategory(DUFSettings.panel)
		else
			local category, _ = _G.Settings.RegisterCanvasLayoutCategory(DUFSettings.panel, "DUnitFrames")
			_G.Settings.RegisterAddOnCategory(category)
		end
	end
end

local f = CreateFrame("Frame")
f:RegisterEvent("PLAYER_ENTERING_WORLD")
local once = true
function f:OnEvent(event, ...)
	if event == "PLAYER_ENTERING_WORLD" and once then
		once = false
		DUFTAB = DUFTAB or {}
		DUFTABPC = DUFTABPC or {}
		DUnitFrames:SetVersion(134167, "1.3.84")
		if DUFTAB["bartexture"] == nil then
			DUFTAB["bartexture"] = 0
		end

		DUFLoaded = true
		if PlayerPortrait then
			UnitFramePortrait_Update(PlayerPortrait)
		end

		if PlayerFrameTexture then
			PlayerFrameTexture:SetVertexColor(1, 1, 1)
		end

		DUnitFrames:PlayerFrameSetup()
		DUnitFrames:TargetFrameSetup()
		if DUnitFrames.FocusFrameSetup then
			DUnitFrames:FocusFrameSetup()
		end

		if DUnitFrames.PartyMemberFramesSetup then
			DUnitFrames:PartyMemberFramesSetup()
		end

		if PlayerFrame then
			UnitFramePortrait_Update(PlayerFrame)
		end

		for id = 1, 4 do
			if _G["PartyMemberFrame" .. id] then
				UnitFramePortrait_Update(_G["PartyMemberFrame" .. id])
			end
		end

		-- PlayerFrame
		hooksecurefunc("PlayerFrame_ToPlayerArt", DUnitFrames.UpdatePlayerFrame)
		-- TargetFrame
		if TargetFrame_CheckClassification then
			hooksecurefunc(
				"TargetFrame_CheckClassification",
				function()
					DUnitFrames:UpdateTargetTexture()
					if DUnitFrames.UpdateFocusTexture then
						DUnitFrames:UpdateFocusTexture()
					end
				end
			)
		end

		DUnitFrames:InitSettings()
	end
end

f:SetScript("OnEvent", f.OnEvent)
