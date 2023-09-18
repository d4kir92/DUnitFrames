-- #PlayerFrame
local DUFFontSize = 12
local borderTab = {}

function DUFGetBorderColor(unit, frame)
	if frame and not tContains(borderTab, frame) then
		tinsert(borderTab, frame)
	end

	local r = nil
	local g = nil
	local b = nil

	if frame and frame.brcr == nil and frame.brcg == nil and frame.brcb == nil then
		frame.brcr, frame.brcg, frame.brcb = frame:GetVertexColor()
	end

	local mode = DUFGetConfig("bordermode")
	local _, PlayerClassEng, _ = UnitClass(unit)

	if mode then
		if mode == "Class+Status" then
			if PlayerClassEng ~= nil and UnitIsPlayer(unit) then
				r, g, b = GetClassColor(PlayerClassEng)
			else
				r, g, b = GameTooltip_UnitColor(unit)
			end
		elseif mode == "Class" then
			if PlayerClassEng ~= nil and UnitIsPlayer(unit) then
				r, g, b = GetClassColor(PlayerClassEng)
			end
		elseif mode == "Status" then
			r, g, b = GameTooltip_UnitColor(unit)
		elseif mode == "Dark" then
			r = 0.1
			g = 0.1
			b = 0.1
		elseif mode == "Black" then
			r = 0
			g = 0
			b = 0
		else
			r, g, b = frame.brcr, frame.brcg, frame.brcb
		end
	end

	return r, g, b, mode == "Default"
end

local barTab = {}

function DUFGetBarColor(unit, frame)
	if frame and not tContains(barTab, frame) then
		tinsert(barTab, frame)
	end

	local r = nil
	local g = nil
	local b = nil

	if frame and frame.bacr == nil and frame.bacg == nil and frame.bacb == nil then
		frame.bacr, frame.bacg, frame.bacb = frame:GetStatusBarColor()
	end

	local mode = DUFGetConfig("barmode")
	--"Class+Status", "Class", "Status", "Default"
	local _, PlayerClassEng, _ = UnitClass(unit)

	if mode then
		if mode == "Class+Status" then
			if PlayerClassEng ~= nil and UnitIsPlayer(unit) then
				r, g, b = GetClassColor(PlayerClassEng)
			else
				r, g, b = GameTooltip_UnitColor(unit)
			end
		elseif mode == "Class" then
			if PlayerClassEng ~= nil and UnitIsPlayer(unit) then
				r, g, b = GetClassColor(PlayerClassEng)
			end
		elseif mode == "Status" then
			r, g, b = GameTooltip_UnitColor(unit)
		else
			r, g, b = frame.bacr, frame.bacg, frame.bacb
		end
	end

	if UnitPlayerControlled and UnitIsTapDenied and not UnitPlayerControlled(unit) and UnitIsTapDenied(unit) then return 0.75, 0.75, 0.75 end
	if not UnitIsConnected(unit) then return 0.5, 0.5, 0.5 end

	return r, g, b
end

function DUFUpdateBorderColors()
	for i, v in pairs(borderTab) do
		v:SetVertexColor(v:GetVertexColor())
	end
end

function DUFUpdateBarColors()
	for i, v in pairs(barTab) do
		v:SetStatusBarColor(v:GetStatusBarColor())
	end
end

local pff = CreateFrame("FRAME")
pff:RegisterEvent("UNIT_ENTERING_VEHICLE")
pff:RegisterEvent("UNIT_EXITED_VEHICLE")
pff.currentEvent = "UNIT_EXITED_VEHICLE"

pff:SetScript("OnEvent", function(event)
	pff.currentEvent = event

	C_Timer.After(0.3, function()
		if pff.currentEvent == "UNIT_ENTERING_VEHICLE" then
			PlayerFrameHealthBar:SetHeight(12)
		else
			PlayerFrameHealthBar:SetHeight(DUFHPHeight())
		end
	end)

	C_Timer.After(1, function()
		if pff.currentEvent == "UNIT_ENTERING_VEHICLE" then
			PlayerFrameHealthBar:SetHeight(12)
		else
			PlayerFrameHealthBar:SetHeight(DUFHPHeight())
		end
	end)

	C_Timer.After(1, function()
		if pff.currentEvent == "UNIT_ENTERING_VEHICLE" then
			PlayerFrameHealthBar:SetHeight(12)
		else
			PlayerFrameHealthBar:SetHeight(DUFHPHeight())
		end
	end)
end)

function DUFUpdatePlayerFrame()
	local texture = "Interface\\Addons\\DUnitFrames\\media\\UI-TargetingFrame"

	if PlayerFrameTexture then
		PlayerFrameTexture:SetTexture(texture)
	end

	if PlayerStatusTexture then
		PlayerStatusTexture:SetTexture("Interface\\Addons\\DUnitFrames\\media\\UI-Player-Status")
	end

	if PlayerFrameHealthBar then
		hooksecurefunc(PlayerFrameHealthBar, "SetHeight", function(self, height)
			if self.dufsetheight then return end
			self.dufsetheight = true
			local inVehicle = false

			if UnitInVehicle or pff.currentEvent == "UNIT_ENTERING_VEHICLE" then
				inVehicle = UnitInVehicle("PLAYER")
			end

			if inVehicle then
				PlayerFrameHealthBar:SetHeight(12)

				if PlayerFrameTexture and PlayerFrameTexture.spacer ~= nil then
					PlayerFrameTexture.spacer:Hide()
				end
			else
				PlayerFrameHealthBar:SetHeight(DUFHPHeight())

				if PlayerFrameTexture and PlayerFrameTexture.spacer ~= nil then
					PlayerFrameTexture.spacer:Show()
				end
			end

			self.dufsetheight = false
		end)

		PlayerFrameHealthBar:SetHeight(DUFHPHeight())
		PlayerFrameHealthBar:SetPoint("TOPLEFT", 107, -24)
	end

	if PlayerFrameTexture and PlayerFrameTexture.spacer == nil then
		PlayerFrameTexture.spacer = PlayerFrameTexture:GetParent():CreateTexture(nil, "ARTWORK")
		PlayerFrameTexture.spacer:SetDrawLayer("ARTWORK", 7)

		hooksecurefunc(PlayerFrameTexture.spacer, "SetVertexColor", function(self, r, g, b, a)
			if self.dufsetvertexcolor then return end
			self.dufsetvertexcolor = true
			self:SetVertexColor(r, g, b, a)
			self.dufsetvertexcolor = false
		end)

		PlayerFrameTexture.spacer:SetVertexColor(1, 1, 1)
	end

	if PlayerFrameTexture then
		PlayerFrameTexture.spacer:SetTexCoord(0, 1, 1, 0)
		PlayerFrameTexture.spacer:SetSize(128, 16)
		PlayerFrameTexture.spacer:SetPoint("RIGHT", PlayerFrameTexture, "RIGHT", 1, 30 - DUFHPHeight())
		PlayerFrameTexture.spacer:SetTexture(texture .. "_Spacer")

		if DUFHPHeight() >= 32 then
			PlayerFrameTexture.spacer:Hide()
		else
			PlayerFrameTexture.spacer:Show()
		end

		PlayerFrameTexture:SetVertexColor(1, 1, 1)
	end

	if PlayerFrameManaBar then
		PlayerFrameManaBar:SetHeight(38 - DUFHPHeight())
		PlayerFrameManaBar:SetPoint("TOPLEFT", 107, -24 - DUFHPHeight() - 1)
	end

	if PlayerFrameHealthBarTextLeft then
		if DUFGetConfig("namemode", "Over Portrait") == "Inside Health" then
			PlayerFrameHealthBarTextLeft:ClearAllPoints()
			PlayerFrameHealthBarTextLeft:SetPoint("BOTTOMLEFT", PlayerFrameHealthBar, "BOTTOMLEFT", 2, 2)
			PlayerFrameHealthBarTextRight:ClearAllPoints()
			PlayerFrameHealthBarTextRight:SetPoint("BOTTOMRIGHT", PlayerFrameHealthBar, "BOTTOMRIGHT", 0, 2)
			PlayerFrameHealthBarText:ClearAllPoints()
			PlayerFrameHealthBarText:SetPoint("BOTTOM", PlayerFrameHealthBar, "BOTTOM", 0, 2)
		else
			PlayerFrameHealthBarTextLeft:ClearAllPoints()
			PlayerFrameHealthBarTextLeft:SetPoint("LEFT", PlayerFrameHealthBar, "LEFT", 2, 0)
			PlayerFrameHealthBarTextRight:ClearAllPoints()
			PlayerFrameHealthBarTextRight:SetPoint("RIGHT", PlayerFrameHealthBar, "RIGHT", 0, 0)
			PlayerFrameHealthBarText:ClearAllPoints()
			PlayerFrameHealthBarText:SetPoint("CENTER", PlayerFrameHealthBar, "CENTER", 0, 0)
		end
	end

	if PlayerFrameManaBarTextLeft then
		if DUFGetConfig("namemode", "Over Portrait") == "Inside Health" then
			PlayerFrameManaBarTextLeft:ClearAllPoints()
			PlayerFrameManaBarTextLeft:SetPoint("LEFT", PlayerFrameManaBar, "LEFT", 2, 0)
			PlayerFrameManaBarTextRight:ClearAllPoints()
			PlayerFrameManaBarTextRight:SetPoint("RIGHT", PlayerFrameManaBar, "RIGHT", 0, 0)
			PlayerFrameManaBarText:ClearAllPoints()
			PlayerFrameManaBarText:SetPoint("CENTER", PlayerFrameManaBar, "CENTER", 0, 0)
		else
			PlayerFrameManaBarTextLeft:ClearAllPoints()
			PlayerFrameManaBarTextLeft:SetPoint("LEFT", PlayerFrameManaBar, "LEFT", 2, 0)
			PlayerFrameManaBarTextRight:ClearAllPoints()
			PlayerFrameManaBarTextRight:SetPoint("RIGHT", PlayerFrameManaBar, "RIGHT", 0, 0)
			PlayerFrameManaBarText:ClearAllPoints()
			PlayerFrameManaBarText:SetPoint("CENTER", PlayerFrameManaBar, "CENTER", 0, 0)
		end
	end
end

function DUFPlayerFrameSetup()
	if PlayerFrameHealthBar then
		hooksecurefunc(PlayerFrameHealthBar, "SetStatusBarTexture", function(self, texture)
			if self.settexture then return end
			self.settexture = true

			if DUFTAB["bartexture"] and DUFTAB["bartexture"] > 0 then
				self:SetStatusBarTexture("Interface\\Addons\\DUnitFrames\\media\\bars\\bar_" .. DUFTAB["bartexture"])
			else
				self:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar")
			end

			self.settexture = false
		end)

		PlayerFrameHealthBar:SetStatusBarTexture("")
	end

	if PlayerFrameManaBar then
		hooksecurefunc(PlayerFrameManaBar, "SetStatusBarTexture", function(self, texture)
			if self.settexture then return end
			self.settexture = true

			if DUFTAB["bartexture"] and DUFTAB["bartexture"] > 0 then
				self:SetStatusBarTexture("Interface\\Addons\\DUnitFrames\\media\\bars\\bar_" .. DUFTAB["bartexture"])
			else
				self:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar")
			end

			self.settexture = false
		end)

		PlayerFrameManaBar:SetStatusBarTexture("")
	end

	if PlayerFrame.HealthBarTextLeft then
		PlayerFrameHealthBarText = PlayerFrame.HealthBarText
		PlayerFrameHealthBarTextLeft = PlayerFrame.HealthBarTextLeft
		PlayerFrameHealthBarTextRight = PlayerFrame.HealthBarTextRight
		PlayerFrameManaBarText = PlayerFrame.ManaBarText
		PlayerFrameManaBarTextLeft = PlayerFrame.ManaBarTextLeft
		PlayerFrameManaBarTextRight = PlayerFrame.ManaBarTextRight
	end

	if PlayerFrameHealthBar then
		hooksecurefunc(PlayerFrameHealthBar, "SetStatusBarColor", function(self, oR, oG, oB)
			if self.dufsetvertexcolor then return end
			self.dufsetvertexcolor = true
			local r, g, b = DUFGetBarColor("PLAYER", self)

			if r and g and b then
				self:SetStatusBarColor(r, g, b)
			else
				self:SetStatusBarColor(oR, oG, oB)
			end

			self.dufsetvertexcolor = false
		end)

		PlayerFrameHealthBar:SetStatusBarColor(PlayerFrameHealthBar:GetStatusBarColor())
	end

	if PlayerFrameHealthBarTextRight then
		hooksecurefunc(PlayerFrameHealthBarTextRight, "SetText", function(self, text)
			if self.dufsettext then return end
			self.dufsettext = true
			local fontFamily, fontSize, fontFlags = self:GetFont()

			if fontSize ~= DUFFontSize then
				self:SetFont(fontFamily, DUFFontSize, fontFlags)
			end

			local newText = DUFModifyText(text, UnitHealth("PLAYER"), UnitHealthMax("PLAYER"), "PlayerFrameHealthBarTextRight")
			self:SetText(newText)
			self.dufsettext = false
		end)

		PlayerFrameHealthBarTextRight:SetText(PlayerFrameHealthBarTextRight:GetText())
	end

	if PlayerFrameHealthBarTextLeft then
		hooksecurefunc(PlayerFrameHealthBarTextLeft, "SetText", function(self, text)
			if self.dufsettext then return end
			self.dufsettext = true
			local fontFamily, fontSize, fontFlags = self:GetFont()

			if fontSize ~= DUFFontSize then
				self:SetFont(fontFamily, DUFFontSize, fontFlags)
			end

			local newText = DUFModifyText(text, UnitHealth("PLAYER"), UnitHealthMax("PLAYER"), "PlayerFrameHealthBarTextLeft")
			self:SetText(newText)
			self.dufsettext = false
		end)

		PlayerFrameHealthBarTextLeft:SetText(PlayerFrameHealthBarTextLeft:GetText())
	end

	if PlayerFrameHealthBarText then
		hooksecurefunc(PlayerFrameHealthBarText, "SetText", function(self, text)
			if self.dufsettext then return end
			self.dufsettext = true
			local fontFamily, fontSize, fontFlags = self:GetFont()

			if fontSize ~= DUFFontSize then
				self:SetFont(fontFamily, DUFFontSize, fontFlags)
			end

			local newText = DUFModifyText(text, UnitHealth("PLAYER"), UnitHealthMax("PLAYER"), "PlayerFrameHealthBarText")
			self:SetText(newText)
			self.dufsettext = false
		end)

		PlayerFrameHealthBarText:SetText(PlayerFrameHealthBarText:GetText())
	end

	if PlayerFrameManaBarTextLeft then
		hooksecurefunc(PlayerFrameManaBarTextLeft, "SetText", function(self, text)
			if self.dufsettext then return end
			self.dufsettext = true
			local fontFamily, fontSize, fontFlags = self:GetFont()

			if fontSize ~= DUFFontSize then
				self:SetFont(fontFamily, DUFFontSize, fontFlags)
			end

			local newText = DUFModifyText(text, UnitPower("PLAYER"), UnitPowerMax("PLAYER"), "PlayerFrameManaBarTextLeft")
			self:SetText(newText)
			self.dufsettext = false
		end)

		PlayerFrameManaBarTextLeft:SetText(PlayerFrameManaBarTextLeft:GetText())
	end

	if PlayerFrameManaBarTextRight then
		hooksecurefunc(PlayerFrameManaBarTextRight, "SetText", function(self, text)
			if self.dufsettext then return end
			self.dufsettext = true
			local fontFamily, fontSize, fontFlags = self:GetFont()

			if fontSize ~= DUFFontSize then
				self:SetFont(fontFamily, DUFFontSize, fontFlags)
			end

			local newText = DUFModifyText(text, UnitPower("PLAYER"), UnitPowerMax("PLAYER"), "PlayerFrameManaBarTextRight")
			self:SetText(newText)
			self.dufsettext = false
		end)

		PlayerFrameManaBarTextRight:SetText(PlayerFrameManaBarTextRight:GetText())
	end

	if PlayerFrameManaBarText then
		hooksecurefunc(PlayerFrameManaBarText, "SetText", function(self, text)
			if self.dufsettext then return end
			self.dufsettext = true
			local fontFamily, fontSize, fontFlags = self:GetFont()

			if fontSize ~= DUFFontSize then
				self:SetFont(fontFamily, DUFFontSize, fontFlags)
			end

			local newText = DUFModifyText(text, UnitPower("PLAYER"), UnitPowerMax("PLAYER"), "PlayerFrameManaBarText")
			self:SetText(newText)
			self.dufsettext = false
		end)

		PlayerFrameManaBarText:SetText(PlayerFrameManaBarText:GetText())
	end

	if PlayerName then
		if DUFGetConfig("namemode", "Over Portrait") ~= "Inside Health" then
			PlayerName:SetParent(DUFHIDDEN)
		else
			hooksecurefunc(PlayerName, "SetText", function(self, text, ...)
				if self.dufsettext then return end
				self.dufsettext = true
				local fontFamily, fontSize, fontFlags = self:GetFont()

				if fontSize ~= DUFGetConfig("namesize", 10) then
					self:SetFont(fontFamily, DUFGetConfig("namesize", 10), fontFlags) --, "OUTLINE")
					self:SetShadowOffset(1, -1)
				end

				self.dufsettext = false
			end)

			PlayerName:SetText(PlayerName:GetText())
		end
	end

	if PlayerFrameTexture then
		hooksecurefunc(PlayerFrameTexture, "SetVertexColor", function(self, oR, oG, oB)
			if self.dufsetvertexcolor then return end
			self.dufsetvertexcolor = true
			local r, g, b, isDefault = DUFGetBorderColor("PLAYER", self)

			if r and g and b and not isDefault then
				self:SetVertexColor(r, g, b, 1)
			else
				self:SetVertexColor(oR, oG, oB, 1)
			end

			if self.spacer then
				self.spacer:SetVertexColor(self:GetVertexColor())
			end

			self.dufsetvertexcolor = false
		end)

		PlayerFrameTexture:SetVertexColor(1, 1, 1)
	end

	if PlayerFrameManaBarTextLeft and not PlayerFrameManaBarTextLeft.hooked then
		PlayerFrameManaBarTextLeft.hooked = true

		hooksecurefunc(PlayerFrameManaBarTextLeft, "Show", function(self, ...)
			if DUFHPHeight() >= 32 then
				self:Hide()
			end
		end)
	end

	if PlayerFrameManaBarTextRight and not PlayerFrameManaBarTextRight.hooked then
		PlayerFrameManaBarTextRight.hooked = true

		hooksecurefunc(PlayerFrameManaBarTextRight, "Show", function(self, ...)
			if DUFHPHeight() >= 32 then
				self:Hide()
			end
		end)
	end

	if PlayerFrameManaBarText and not PlayerFrameManaBarText.hooked then
		PlayerFrameManaBarText.hooked = true

		hooksecurefunc(PlayerFrameManaBarText, "Show", function(self, ...)
			if DUFHPHeight() >= 32 then
				self:Hide()
			end
		end)
	end

	if PlayerFrameManaBar then
		hooksecurefunc(PlayerFrameManaBar, "SetHeight", function(self)
			if self.dufsetheight then return end
			self.dufsetheight = true

			if 38 - DUFHPHeight() > 1 then
				self:SetHeight(38 - DUFHPHeight())
			else
				self:SetHeight(1)
			end

			self.dufsetheight = false
		end)

		PlayerFrameManaBar:SetHeight(27)

		hooksecurefunc(PlayerFrameManaBar, "SetSize", function(self)
			if self.dufsetsize then return end
			self.dufsetsize = true

			if 38 - DUFHPHeight() > 1 then
				self:SetHeight(38 - DUFHPHeight())
			else
				self:SetHeight(1)
			end

			self.dufsetsize = false
		end)
	end

	-- EXTRAS
	ALT_MANA_BAR_PAIR_DISPLAY_INFO = {
		DRUID = {
			[Enum.PowerType.LunarPower] = true,
			[Enum.PowerType.Energy] = true,
			[Enum.PowerType.Rage] = true,
		},
		PRIEST = {
			[Enum.PowerType.Insanity] = true,
		},
		SHAMAN = {
			[Enum.PowerType.Maelstrom] = true,
		},
	}

	if PlayerFrameAlternateManaBar == nil then
		local sw = PlayerFrameManaBar:GetWidth() + 4
		local sh = 16
		PlayerFrameAlternateManaBar = CreateFrame("Frame", "PlayerFrameAlternateManaBar")
		PlayerFrameAlternateManaBar:SetParent(PlayerFrame)
		PlayerFrameAlternateManaBar:SetSize(sw, sh)
		PlayerFrameAlternateManaBar:SetPoint("TOP", PlayerFrameManaBar, "BOTTOM")
		PlayerFrameAlternateManaBar.texture = PlayerFrameAlternateManaBar:CreateTexture(nil, "BACKGROUND")
		PlayerFrameAlternateManaBar.texture:SetTexture("Interface\\TargetingFrame\\UI-StatusBar")
		PlayerFrameAlternateManaBar.texture:SetSize(10, sh - 4)
		PlayerFrameAlternateManaBar.texture:SetPoint("LEFT", PlayerFrameAlternateManaBar, "LEFT", 2, 0)
		PlayerFrameAlternateManaBar.texture:SetColorTexture(0, 0, 1, 1)
		PlayerFrameAlternateManaBar.texture2 = PlayerFrameAlternateManaBar:CreateTexture(nil, "BORDER")
		PlayerFrameAlternateManaBar.texture2:SetTexture("Interface\\Tooltips\\UI-StatusBar-Border")
		PlayerFrameAlternateManaBar.texture2:SetTexCoord(0, 1, 1, 0)
		PlayerFrameAlternateManaBar.texture2:SetSize(sw + 3, sh + 4)
		PlayerFrameAlternateManaBar.texture2:SetPoint("BOTTOM", PlayerFrameAlternateManaBar, "BOTTOM", 0, -2)
		PlayerFrameAlternateManaBar.textl = PlayerFrameAlternateManaBar:CreateFontString(nil, "ARTWORK", "TextStatusBarText")
		PlayerFrameAlternateManaBar.textl:SetFont(STANDARD_TEXT_FONT, 9, "")
		PlayerFrameAlternateManaBar.textl:SetShadowOffset(1, -1)
		PlayerFrameAlternateManaBar.textl:SetPoint("LEFT", PlayerFrameAlternateManaBar, "LEFT", 5, 0)
		PlayerFrameAlternateManaBar.textr = PlayerFrameAlternateManaBar:CreateFontString(nil, "ARTWORK", "TextStatusBarText")
		PlayerFrameAlternateManaBar.textr:SetFont(STANDARD_TEXT_FONT, 9, "")
		PlayerFrameAlternateManaBar.textr:SetShadowOffset(1, -1)
		PlayerFrameAlternateManaBar.textr:SetPoint("RIGHT", PlayerFrameAlternateManaBar, "RIGHT", -5, 0)

		function PlayerFrameAlternateManaBar.think()
			-- when current power is mana or the maxmana is <= 0
			if UnitPowerType("PLAYER") == Enum.PowerType.Mana or UnitPowerMax("PLAYER", Enum.PowerType.Mana) <= 0 then
				PlayerFrameAlternateManaBar:Hide() -- hide when warrior, rogue, ... or when current power is mana
			else
				PlayerFrameAlternateManaBar:Show()
				local per = UnitPower("PLAYER", Enum.PowerType.Mana) / UnitPowerMax("PLAYER", Enum.PowerType.Mana)
				PlayerFrameAlternateManaBar.texture:SetWidth(per * PlayerFrameAlternateManaBar:GetWidth() - 4)
				PlayerFrameAlternateManaBar.textl:SetText(DUFPN(UnitPower("PLAYER", Enum.PowerType.Mana), UnitPowerMax("PLAYER", Enum.PowerType.Mana)))
				PlayerFrameAlternateManaBar.textr:SetText(DUFNN(UnitPower("PLAYER", Enum.PowerType.Mana)))
			end

			if DUFGetConfig("namemode", "Over Portrait") == "Inside Health" then
				PlayerName:ClearAllPoints()
				PlayerName:SetPoint("TOP", PlayerFrameHealthBar, "TOP", 0, -1)
			end

			C_Timer.After(0.1, PlayerFrameAlternateManaBar.think)
		end

		PlayerFrameAlternateManaBar.think()
	end

	if ComboPointPlayerFrame ~= nil then
		hooksecurefunc(ComboPointPlayerFrame, "SetPoint", function(self, ...)
			local _, class = UnitClass("PLAYER")

			if class == "DRUID" then
				if self.dufsetpoint then return end
				self.dufsetpoint = true
				self:SetScale(0.82)
				self:SetPoint("TOP", PlayerFrameAlternateManaBar, "BOTTOM", 0, 0)
				self.dufsetpoint = false
			end
		end)
	end

	DUFUpdatePlayerFrame()
end