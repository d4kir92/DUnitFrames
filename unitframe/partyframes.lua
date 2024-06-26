local _, DUnitFrames = ...
function DUnitFrames:PartyMemberFramesSetup()
	for id = 1, 4 do
		local PartyMemberFrame = _G["PartyMemberFrame" .. id]
		if PartyMemberFrame then
			local func = _G["DUFUpdateParty" .. id .. "Texture"]
			func = function()
				local texture = "Interface\\Addons\\DUnitFrames\\media\\UI-PartyFrame"
				local PartyMemberTexture = _G["PartyMemberFrame" .. id .. "Texture"]
				PartyMemberTexture:SetTexture(texture)
				PartyMemberTexture:SetVertexColor(0, 0, 0)
			end

			func()
			hooksecurefunc(
				_G["PartyMemberFrame" .. id .. "HealthBar"],
				"SetStatusBarTexture",
				function(sel, texture)
					if sel.settexture then return end
					sel.settexture = true
					if DUFTAB["bartexture"] and DUFTAB["bartexture"] > 0 then
						sel:SetStatusBarTexture("Interface\\Addons\\DUnitFrames\\media\\bars\\bar_" .. DUFTAB["bartexture"])
					else
						sel:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar")
					end

					sel.settexture = false
				end
			)

			_G["PartyMemberFrame" .. id .. "HealthBar"]:SetStatusBarTexture("")
			hooksecurefunc(
				_G["PartyMemberFrame" .. id .. "ManaBar"],
				"SetStatusBarTexture",
				function(sel, texture)
					if sel.settexture then return end
					sel.settexture = true
					if DUFTAB["bartexture"] and DUFTAB["bartexture"] > 0 then
						sel:SetStatusBarTexture("Interface\\Addons\\DUnitFrames\\media\\bars\\bar_" .. DUFTAB["bartexture"])
					else
						sel:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar")
					end

					sel.settexture = false
				end
			)

			_G["PartyMemberFrame" .. id .. "ManaBar"]:SetStatusBarTexture("")
			hooksecurefunc(
				_G["PartyMemberFrame" .. id .. "HealthBar"],
				"SetStatusBarColor",
				function(sel, oR, oG, oB)
					if sel.dufsetvertexcolor then return end
					sel.dufsetvertexcolor = true
					local r, g, b = DUnitFrames:GetBarColor("PARTY" .. id, sel)
					if r and g and b then
						sel:SetStatusBarColor(r, g, b)
					else
						sel:SetStatusBarColor(oR, oG, oB)
					end

					sel.dufsetvertexcolor = false
				end
			)

			_G["PartyMemberFrame" .. id .. "HealthBar"].dr, _G["PartyMemberFrame" .. id .. "HealthBar"].dg, _G["PartyMemberFrame" .. id .. "HealthBar"].db = _G["PartyMemberFrame" .. id .. "HealthBar"]:GetStatusBarColor()
			_G["PartyMemberFrame" .. id .. "HealthBar"]:SetStatusBarColor(1, 1, 1)
			hooksecurefunc(
				_G["PartyMemberFrame" .. id .. "HealthBar"],
				"SetHeight",
				function(sel)
					if sel.dufsetheight then return end
					sel.dufsetheight = true
					sel:SetHeight(13)
					sel.dufsetheight = false
				end
			)

			_G["PartyMemberFrame" .. id .. "HealthBar"]:SetHeight(13)
			hooksecurefunc(
				_G["PartyMemberFrame" .. id .. "HealthBar"],
				"SetPoint",
				function(sel)
					if sel.dufsetpoint then return end
					sel.dufsetpoint = true
					sel:SetPoint("TOPLEFT", 45, -16)
					sel.dufsetpoint = false
				end
			)

			_G["PartyMemberFrame" .. id .. "HealthBar"]:SetPoint("TOPLEFT", 6, -24)
			hooksecurefunc(
				_G["PartyMemberFrame" .. id .. "ManaBar"],
				"SetPoint",
				function(sel)
					if sel.dufsetpoint then return end
					sel.dufsetpoint = true
					sel:ClearAllPoints()
					sel:SetPoint("TOP", _G["PartyMemberFrame" .. id .. "HealthBar"], "BOTTOM", 0, -1)
					sel.dufsetpoint = false
				end
			)

			_G["PartyMemberFrame" .. id .. "ManaBar"]:SetPoint("TOPLEFT", 6, -24)
			_G["PartyMemberFrame" .. id .. "Background"]:SetParent(DUFHIDDEN)
			function PartyMemberFrame.Think()
				if UnitExists("PARTY" .. id) then
					_G["PartyMemberFrame" .. id .. "Name"]:ClearAllPoints()
					local y = 3
					if DUnitFrames:GetConfig("namemode", "Over Portrait") == "Over Health" then
						_G["PartyMemberFrame" .. id .. "Name"]:SetPoint("BOTTOM", _G["PartyMemberFrame" .. id .. "HealthBar"], "TOP", 0, y)
					end

					if DUnitFrames:GetConfig("namemode", "Over Portrait") == "Over Portrait" then
						_G["PartyMemberFrame" .. id .. "Name"]:SetPoint("BOTTOM", _G["PartyMemberFrame" .. id .. "Portrait"], "TOP", 0, 3)
					end

					if PartyMemberFrame.hptc == nil then
						PartyMemberFrame.hptc = _G["PartyMemberFrame" .. id .. "HealthBar"]:CreateFontString(nil, "OVERLAY")
						PartyMemberFrame.hptc:SetFont(STANDARD_TEXT_FONT, 10)
						PartyMemberFrame.hptc:SetPoint("CENTER", _G["PartyMemberFrame" .. id .. "HealthBar"], "CENTER", 0, 0)
						PartyMemberFrame.hptl = _G["PartyMemberFrame" .. id .. "HealthBar"]:CreateFontString(nil, "OVERLAY")
						PartyMemberFrame.hptl:SetFont(STANDARD_TEXT_FONT, 10)
						PartyMemberFrame.hptl:SetPoint("LEFT", _G["PartyMemberFrame" .. id .. "HealthBar"], "LEFT", 0, 0)
						PartyMemberFrame.hptr = _G["PartyMemberFrame" .. id .. "HealthBar"]:CreateFontString(nil, "OVERLAY")
						PartyMemberFrame.hptr:SetFont(STANDARD_TEXT_FONT, 10)
						PartyMemberFrame.hptr:SetPoint("RIGHT", _G["PartyMemberFrame" .. id .. "HealthBar"], "RIGHT", 0, 0)
					end

					local cur = 1
					local max = 1
					if UnitHealthMax("PARTY" .. id) > 0 then
						cur = UnitHealth("PARTY" .. id)
						max = UnitHealthMax("PARTY" .. id)
					end

					if GetCVar("statusTextDisplay") == "PERCENT" then
						PartyMemberFrame.hptc:SetText(string.format("%.0f", cur / max * 100) .. "%")
						PartyMemberFrame.hptl:SetText("")
						PartyMemberFrame.hptr:SetText("")
					elseif GetCVar("statusTextDisplay") == "NUMERIC" then
						PartyMemberFrame.hptc:SetText(string.format("%s/%s", DUnitFrames:NN(cur), DUnitFrames:NN(max)))
						PartyMemberFrame.hptl:SetText("")
						PartyMemberFrame.hptr:SetText("")
					elseif GetCVar("statusTextDisplay") == "BOTH" then
						PartyMemberFrame.hptc:SetText("")
						PartyMemberFrame.hptl:SetText(string.format("%.0f", cur / max * 100) .. "%")
						PartyMemberFrame.hptr:SetText(string.format("%s", DUnitFrames:NN(cur)))
					else
						PartyMemberFrame.hptc:SetText("")
						PartyMemberFrame.hptl:SetText("")
						PartyMemberFrame.hptr:SetText("")
					end

					if PartyMemberFrame.potc == nil then
						PartyMemberFrame.potc = _G["PartyMemberFrame" .. id .. "ManaBar"]:CreateFontString(nil, "OVERLAY")
						PartyMemberFrame.potc:SetFont(STANDARD_TEXT_FONT, 9)
						PartyMemberFrame.potc:SetPoint("CENTER", _G["PartyMemberFrame" .. id .. "ManaBar"], "CENTER", 0, 0)
						PartyMemberFrame.potl = _G["PartyMemberFrame" .. id .. "ManaBar"]:CreateFontString(nil, "OVERLAY")
						PartyMemberFrame.potl:SetFont(STANDARD_TEXT_FONT, 9)
						PartyMemberFrame.potl:SetPoint("LEFT", _G["PartyMemberFrame" .. id .. "ManaBar"], "LEFT", 0, 0)
						PartyMemberFrame.potr = _G["PartyMemberFrame" .. id .. "ManaBar"]:CreateFontString(nil, "OVERLAY")
						PartyMemberFrame.potr:SetFont(STANDARD_TEXT_FONT, 9)
						PartyMemberFrame.potr:SetPoint("RIGHT", _G["PartyMemberFrame" .. id .. "ManaBar"], "RIGHT", 0, 0)
					end

					local curP = 1
					local maxP = 1
					if UnitPowerMax("PARTY" .. id) > 0 then
						curP = UnitPower("PARTY" .. id)
						maxP = UnitPowerMax("PARTY" .. id)
					end

					if GetCVar("statusTextDisplay") == "PERCENT" then
						PartyMemberFrame.potc:SetText(string.format("%.0f", curP / maxP * 100) .. "%")
						PartyMemberFrame.potl:SetText("")
						PartyMemberFrame.potr:SetText("")
					elseif GetCVar("statusTextDisplay") == "NUMERIC" then
						PartyMemberFrame.potc:SetText(string.format("%s/%s", DUnitFrames:NN(curP), DUnitFrames:NN(maxP)))
						PartyMemberFrame.potl:SetText("")
						PartyMemberFrame.potr:SetText("")
					elseif GetCVar("statusTextDisplay") == "BOTH" then
						PartyMemberFrame.potc:SetText("")
						PartyMemberFrame.potl:SetText(string.format("%.0f", curP / maxP * 100) .. "%")
						PartyMemberFrame.potr:SetText(string.format("%s", DUnitFrames:NN(curP)))
					else
						PartyMemberFrame.potc:SetText("")
						PartyMemberFrame.potl:SetText("")
						PartyMemberFrame.potr:SetText("")
					end
				end

				C_Timer.After(0.05, PartyMemberFrame.Think)
			end

			PartyMemberFrame.Think()
			hooksecurefunc(
				_G["PartyMemberFrame" .. id .. "Name"],
				"SetText",
				function(sel, text, ...)
					if sel.dufsettext then return end
					sel.dufsettext = true
					DUnitFrames:SetFont(sel, DUnitFrames:GetConfig("namesize", 10))
					if not InCombatLockdown() then
						if DUnitFrames:GetConfig("namemode", "Over Portrait") == "Hide" then
							sel:SetAlpha(0)
						else
							sel:SetAlpha(1)
						end
					end

					sel.dufsettext = false
				end
			)

			_G["PartyMemberFrame" .. id .. "Name"]:SetText(_G["PartyMemberFrame" .. id .. "Name"]:GetText())
			hooksecurefunc(
				_G["PartyMemberFrame" .. id .. "Texture"],
				"SetVertexColor",
				function(sel, oR, oG, oB)
					if sel.dufsetvertexcolor then return end
					sel.dufsetvertexcolor = true
					local r, g, b, isDefault = DUnitFrames:GetBorderColor("PARTY" .. id, sel)
					if r and g and b and not isDefault then
						sel:SetVertexColor(r, g, b, 1)
					else
						sel:SetVertexColor(oR, oG, oB, 1)
					end

					sel.dufsetvertexcolor = false
				end
			)

			_G["PartyMemberFrame" .. id .. "Texture"]:SetVertexColor(1, 1, 1)
			C_Timer.After(
				2,
				function()
					if _G["PartyFrameXPBar" .. id] then
						hooksecurefunc(
							_G["PartyFrameXPBar" .. id].textureLvlBg,
							"SetVertexColor",
							function(sel, oR, oG, oB)
								if sel.dufsetvertexcolor then return end
								sel.dufsetvertexcolor = true
								local r, g, b, isDefault = DUnitFrames:GetBorderColor("PARTY" .. id, sel)
								if r and g and b and not isDefault then
									sel:SetVertexColor(r, g, b, 1)
								else
									sel:SetVertexColor(oR, oG, oB, 1)
								end

								sel.dufsetvertexcolor = false
							end
						)

						_G["PartyFrameXPBar" .. id].textureLvlBg:SetVertexColor(1, 1, 1)
					end
				end
			)
		end
	end

	for i = 1, 4 do
		for id = 1, 4 do
			local debuff = _G["PartyMemberFrame" .. i .. "Debuff" .. id]
			local parent = _G["PartyMemberFrame" .. i .. "Debuff" .. id - 1]
			if parent == nil then
				parent = _G["PartyMemberFrame" .. i]
			end

			if debuff then
				hooksecurefunc(
					debuff,
					"SetPoint",
					function(sel)
						if sel.dufsetpoint then return end
						sel.dufsetpoint = true
						sel:ClearAllPoints()
						if parent == _G["PartyMemberFrame" .. i] then
							local py = -6
							sel:SetPoint("BOTTOMLEFT", parent, "BOTTOMRIGHT", -80, py)
						else
							sel:SetPoint("LEFT", parent, "RIGHT", 4, 0)
						end

						sel.dufsetpoint = false
					end
				)

				debuff:ClearAllPoints()
				debuff:SetPoint("LEFT", parent, "RIGHT", 4, 0)
			end
		end
	end
end

function DUnitFrames:UpdatePartyMemberFrames()
	for id = 1, 4 do
		local PartyMemberFrame = _G["PartyMemberFrame" .. id]
		if PartyMemberFrame then
			_G["PartyMemberFrame" .. id .. "HealthBar"]:SetHeight(1)
			_G["PartyMemberFrame" .. id .. "ManaBar"]:SetHeight(1)
			_G["PartyMemberFrame" .. id .. "ManaBar"]:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
		end
	end
end
