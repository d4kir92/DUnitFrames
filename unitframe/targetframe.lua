local _, DUnitFrames = ...
function DUnitFrames:TargetFrameSetup()
	if TargetFrameHealthBar then
		hooksecurefunc(
			TargetFrameHealthBar,
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

		TargetFrameHealthBar:SetStatusBarTexture("")
	end

	if TargetFrameManaBar then
		hooksecurefunc(
			TargetFrameManaBar,
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

		TargetFrameManaBar:SetStatusBarTexture("")
	end

	if TargetFrameTextureFrame and TargetFrameTextureFrame.HealthBarTextLeft then
		TargetFrameTextureFrameHealthBarText = TargetFrameTextureFrame.HealthBarText
		TargetFrameTextureFrameHealthBarTextLeft = TargetFrameTextureFrame.HealthBarTextLeft
		TargetFrameTextureFrameHealthBarTextRight = TargetFrameTextureFrame.HealthBarTextRight
		TargetFrameTextureFrameManaBarText = TargetFrameTextureFrame.ManaBarText
		TargetFrameTextureFrameManaBarTextLeft = TargetFrameTextureFrame.ManaBarTextLeft
		TargetFrameTextureFrameManaBarTextRight = TargetFrameTextureFrame.ManaBarTextRight
	end

	if TargetFrameHealthBar then
		hooksecurefunc(
			TargetFrameHealthBar,
			"SetStatusBarColor",
			function(sel, oR, oG, oB)
				if sel.dufsetvertexcolor then return end
				sel.dufsetvertexcolor = true
				local r, g, b = DUnitFrames:GetBarColor("TARGET", sel)
				if r and g and b then
					sel:SetStatusBarColor(r, g, b)
				else
					sel:SetStatusBarColor(oR, oG, oB)
				end

				sel.dufsetvertexcolor = false
			end
		)

		TargetFrameHealthBar:SetStatusBarColor(TargetFrameHealthBar:GetStatusBarColor())
	end

	C_Timer.After(
		3,
		function()
			if TargetFrameHealthBarTextLeft ~= nil and TargetFrameHealthBarTextLeft.hooked == nil then
				TargetFrameHealthBarTextLeft.hooked = true
				hooksecurefunc(
					TargetFrameHealthBarTextRight,
					"SetText",
					function(sel, text)
						if sel.dufsettext then return end
						sel.dufsettext = true
						DUnitFrames:SetFont(sel)
						local newText = DUnitFrames:ModifyText(text, UnitHealth("TARGET"), UnitHealthMax("TARGET"), "TargetFrameHealthBarTextRight")
						sel:SetText(newText)
						sel.dufsettext = false
					end
				)

				TargetFrameHealthBarTextRight:SetText(TargetFrameHealthBarTextRight:GetText())
				hooksecurefunc(
					TargetFrameHealthBarTextLeft,
					"SetText",
					function(sel, text)
						if sel.dufsettext then return end
						sel.dufsettext = true
						DUnitFrames:SetFont(sel)
						local newText = DUnitFrames:ModifyText(text, UnitHealth("TARGET"), UnitHealthMax("TARGET"), "TargetFrameHealthBarTextLeft")
						sel:SetText(newText)
						sel.dufsettext = false
					end
				)

				TargetFrameHealthBarTextLeft:SetText(TargetFrameHealthBarTextLeft:GetText())
				hooksecurefunc(
					TargetFrameHealthBarText,
					"SetText",
					function(sel, text)
						if sel.dufsettext then return end
						sel.dufsettext = true
						DUnitFrames:SetFont(sel)
						local newText = DUnitFrames:ModifyText(text, UnitHealth("TARGET"), UnitHealthMax("TARGET"), "TargetFrameHealthBarText")
						sel:SetText(newText)
						sel.dufsettext = false
					end
				)

				TargetFrameHealthBarText:SetText(TargetFrameHealthBarText:GetText())
				hooksecurefunc(
					TargetFrameManaBarTextLeft,
					"SetText",
					function(sel, text)
						if sel.dufsettext then return end
						sel.dufsettext = true
						DUnitFrames:SetFont(sel)
						local newText = DUnitFrames:ModifyText(text, UnitPower("TARGET"), UnitPowerMax("TARGET"), "TargetFrameManaBarTextLeft")
						sel:SetText(newText)
						sel.dufsettext = false
					end
				)

				TargetFrameManaBarTextLeft:SetText(TargetFrameManaBarTextLeft:GetText())
				hooksecurefunc(
					TargetFrameManaBarTextRight,
					"SetText",
					function(sel, text)
						if sel.dufsettext then return end
						sel.dufsettext = true
						DUnitFrames:SetFont(sel)
						local newText = DUnitFrames:ModifyText(text, UnitPower("TARGET"), UnitPowerMax("TARGET"), "TargetFrameManaBarTextRight")
						sel:SetText(newText)
						sel.dufsettext = false
					end
				)

				TargetFrameManaBarTextRight:SetText(TargetFrameManaBarTextRight:GetText())
				hooksecurefunc(
					TargetFrameManaBarText,
					"SetText",
					function(sel, text)
						if sel.dufsettext then return end
						sel.dufsettext = true
						DUnitFrames:SetFont(sel)
						local newText = DUnitFrames:ModifyText(text, UnitPower("TARGET"), UnitPowerMax("TARGET"), "TargetFrameManaBarText")
						sel:SetText(newText)
						sel.dufsettext = false
					end
				)

				TargetFrameManaBarText:SetText(TargetFrameManaBarText:GetText())
			end

			if TargetFrameTextureFrameHealthBarTextLeft ~= nil and TargetFrameTextureFrameHealthBarTextLeft.hooked == nil then
				TargetFrameTextureFrameHealthBarTextLeft.hooked = true
				hooksecurefunc(
					TargetFrameTextureFrameHealthBarTextLeft,
					"SetText",
					function(sel, text)
						if sel.dufsettext then return end
						sel.dufsettext = true
						DUnitFrames:SetFont(sel)
						local newText = DUnitFrames:ModifyText(text, UnitHealth("TARGET"), UnitHealthMax("TARGET"), "TargetFrameTextureFrameHealthBarTextLeft")
						sel:SetText(newText)
						sel.dufsettext = false
					end
				)

				TargetFrameTextureFrameHealthBarTextLeft:SetText(TargetFrameTextureFrameHealthBarTextLeft:GetText())
				hooksecurefunc(
					TargetFrameTextureFrameHealthBarTextRight,
					"SetText",
					function(sel, text)
						if sel.dufsettext then return end
						sel.dufsettext = true
						DUnitFrames:SetFont(sel)
						local newText = DUnitFrames:ModifyText(text, UnitHealth("TARGET"), UnitHealthMax("TARGET"), "TargetFrameTextureFrameHealthBarTextRight")
						sel:SetText(newText)
						sel.dufsettext = false
					end
				)

				TargetFrameTextureFrameHealthBarTextRight:SetText(TargetFrameTextureFrameHealthBarTextRight:GetText())
				hooksecurefunc(
					TargetFrameTextureFrameHealthBarText,
					"SetText",
					function(sel, text)
						if sel.dufsettext then return end
						sel.dufsettext = true
						DUnitFrames:SetFont(sel)
						local newText = DUnitFrames:ModifyText(text, UnitHealth("TARGET"), UnitHealthMax("TARGET"), "TargetFrameTextureFrameHealthBarText")
						sel:SetText(newText)
						sel.dufsettext = false
					end
				)

				TargetFrameTextureFrameHealthBarText:SetText(TargetFrameTextureFrameHealthBarText:GetText())
				hooksecurefunc(
					TargetFrameTextureFrameManaBarTextLeft,
					"SetText",
					function(sel, text)
						if sel.dufsettext then return end
						sel.dufsettext = true
						DUnitFrames:SetFont(sel)
						local newText = DUnitFrames:ModifyText(text, UnitPower("TARGET"), UnitPowerMax("TARGET"), "TargetFrameTextureFrameManaBarTextLeft")
						sel:SetText(newText)
						sel.dufsettext = false
					end
				)

				TargetFrameTextureFrameManaBarTextLeft:SetText(TargetFrameTextureFrameManaBarTextLeft:GetText())
				hooksecurefunc(
					TargetFrameTextureFrameManaBarTextRight,
					"SetText",
					function(sel, text)
						if sel.dufsettext then return end
						sel.dufsettext = true
						DUnitFrames:SetFont(sel)
						local newText = DUnitFrames:ModifyText(text, UnitPower("TARGET"), UnitPowerMax("TARGET"), "TargetFrameTextureFrameManaBarTextRight")
						sel:SetText(newText)
						sel.dufsettext = false
					end
				)

				TargetFrameTextureFrameManaBarTextRight:SetText(TargetFrameTextureFrameManaBarTextRight:GetText())
				hooksecurefunc(
					TargetFrameTextureFrameManaBarText,
					"SetText",
					function(sel, text)
						if sel.dufsettext then return end
						sel.dufsettext = true
						DUnitFrames:SetFont(sel)
						local newText = DUnitFrames:ModifyText(text, UnitPower("TARGET"), UnitPowerMax("TARGET"), "TargetFrameTextureFrameManaBarText")
						sel:SetText(newText)
						sel.dufsettext = false
					end
				)

				TargetFrameTextureFrameManaBarText:SetText(TargetFrameTextureFrameManaBarText:GetText())
			end
		end
	)

	-- #TargetFrame
	if TargetFrameHealthBar then
		hooksecurefunc(
			TargetFrameHealthBar,
			"SetHeight",
			function(sel)
				if sel.dufsetheight then return end
				sel.dufsetheight = true
				sel:SetHeight(DUnitFrames:HPHeight())
				sel.dufsetheight = false
			end
		)

		TargetFrameHealthBar:SetHeight(27)
		hooksecurefunc(
			TargetFrameHealthBar,
			"SetSize",
			function(sel)
				if sel.dufsetsize then return end
				sel.dufsetsize = true
				sel:SetHeight(DUnitFrames:HPHeight())
				sel.dufsetsize = false
			end
		)

		hooksecurefunc(
			TargetFrameHealthBar,
			"SetPoint",
			function(sel)
				if sel.dufsetpoint then return end
				sel.dufsetpoint = true
				if DUnitFrames:GetWoWBuild() == "TBC" then
					sel:SetPoint("TOPLEFT", 24, -27)
				else
					sel:SetPoint("TOPLEFT", 6, -24)
				end

				sel.dufsetpoint = false
			end
		)

		if DUnitFrames:GetWoWBuild() == "TBC" then
			TargetFrameHealthBar:SetPoint("TOPLEFT", 24, -27)
		else
			TargetFrameHealthBar:SetPoint("TOPLEFT", 6, -24)
		end
	end

	if TargetFrameManaBar then
		hooksecurefunc(
			TargetFrameManaBar,
			"SetHeight",
			function(sel)
				if sel.dufsetheight then return end
				sel.dufsetheight = true
				if DUnitFrames:GetWoWBuild() == "TBC" then
					if 38 - DUnitFrames:HPHeight() > 1 then
						sel:SetHeight(38 - DUnitFrames:HPHeight())
					else
						sel:SetHeight(1)
					end
				else
					if 38 - DUnitFrames:HPHeight() > 1 then
						sel:SetHeight(38 - DUnitFrames:HPHeight())
					else
						sel:SetHeight(1)
					end
				end

				sel.dufsetheight = false
			end
		)

		TargetFrameManaBar:SetHeight(27)
		hooksecurefunc(
			TargetFrameManaBar,
			"SetSize",
			function(sel)
				if sel.dufsetsize then return end
				sel.dufsetsize = true
				if DUnitFrames:GetWoWBuild() == "TBC" then
					if 38 - DUnitFrames:HPHeight() > 1 then
						sel:SetHeight(38 - DUnitFrames:HPHeight())
					else
						sel:SetHeight(1)
					end
				else
					if 38 - DUnitFrames:HPHeight() > 1 then
						sel:SetHeight(38 - DUnitFrames:HPHeight())
					else
						sel:SetHeight(1)
					end
				end

				sel.dufsetsize = false
			end
		)

		hooksecurefunc(
			TargetFrameManaBar,
			"SetPoint",
			function(sel)
				if sel.dufsetpoint then return end
				sel.dufsetpoint = true
				if DUnitFrames:GetWoWBuild() == "TBC" then
					sel:SetPoint("TOPLEFT", 24, -27 - DUnitFrames:HPHeight() - 1)
				else
					sel:SetPoint("TOPLEFT", 6, -23 - DUnitFrames:HPHeight() - 1)
				end

				sel.dufsetpoint = false
			end
		)

		if DUnitFrames:GetWoWBuild() == "TBC" then
			TargetFrameManaBar:SetPoint("TOPLEFT", 24, -29)
		else
			TargetFrameManaBar:SetPoint("TOPLEFT", 6, -23)
		end
	end

	if TargetFrameBackground then
		TargetFrameBackground:SetHeight(40)
		TargetFrameBackground:ClearAllPoints()
		TargetFrameBackground:Hide()
		if DUnitFrames:GetWoWBuild() == "TBC" then
			TargetFrameBackground:SetPoint("TOPLEFT", 24, -26)
		else
			TargetFrameBackground:SetPoint("TOPLEFT", 6, -24)
		end
	end

	if TargetFrameNameBackground then
		TargetFrameNameBackground:SetParent(DUFHIDDEN)
	end

	local updateTexture = false
	hooksecurefunc(
		TargetFrameTextureFrameTexture,
		"SetTexture",
		function()
			if updateTexture then return end
			updateTexture = true
			DUnitFrames:UpdateTargetTexture()
			updateTexture = false
		end
	)

	function DUnitFrames:UpdateTargetTexture()
		local texture = "Interface\\Addons\\DUnitFrames\\media\\UI-TargetingFrame"
		local class = UnitClassification("TARGET")
		if class == "worldboss" or class == "elite" then
			texture = "Interface\\Addons\\DUnitFrames\\media\\UI-TargetingFrame-Elite"
		elseif class == "rareelite" then
			texture = "Interface\\Addons\\DUnitFrames\\media\\UI-TargetingFrame-Rare-Elite"
		elseif class == "rare" then
			texture = "Interface\\Addons\\DUnitFrames\\media\\UI-TargetingFrame-Rare"
		end

		TargetFrameTextureFrameTexture:SetTexture(texture)
		if class == "minus" then
			TargetFrameFlash:SetTexture("")
		end

		if TargetFrameTextureFrameTexture.spacer == nil then
			TargetFrameTextureFrameTexture.spacer = TargetFrameTextureFrame:CreateTexture(nil, "ARTWORK")
			TargetFrameTextureFrameTexture.spacer:SetDrawLayer("ARTWORK", 7)
			hooksecurefunc(
				TargetFrameTextureFrameTexture.spacer,
				"SetVertexColor",
				function(sel, r, g, b, a)
					if sel.dufsetvertexcolor then return end
					sel.dufsetvertexcolor = true
					sel:SetVertexColor(r, g, b, a)
					sel.dufsetvertexcolor = false
				end
			)

			TargetFrameTextureFrameTexture.spacer:SetVertexColor(1, 1, 1)
		end

		if TargetFrameTextureFrameTexture.spacer then
			TargetFrameTextureFrameTexture.spacer:SetSize(128, 16)
			if DUnitFrames:GetWoWBuild() == "TBC" then
				TargetFrameTextureFrameTexture.spacer:SetPoint("LEFT", TargetFrameTextureFrameTexture, "LEFT", 2, 22 - DUnitFrames:HPHeight())
			else
				TargetFrameTextureFrameTexture.spacer:SetPoint("LEFT", TargetFrameTextureFrameTexture, "LEFT", 4, 21 - DUnitFrames:HPHeight())
			end

			TargetFrameTextureFrameTexture.spacer:SetTexture("Interface\\Addons\\DUnitFrames\\media\\UI-TargetingFrame" .. "_Spacer")
			if DUnitFrames:HPHeight() >= 32 then
				TargetFrameTextureFrameTexture.spacer:Hide()
			else
				TargetFrameTextureFrameTexture.spacer:Show()
			end
		end

		TargetFrameTextureFrameTexture:SetVertexColor(TargetFrameTextureFrameTexture:GetVertexColor())
		if DUnitFrames:GetConfig("namemode", "Over Portrait") == "Inside Health" then
			TargetFrameTextureFrameDeadText:ClearAllPoints()
			TargetFrameTextureFrameDeadText:SetPoint("BOTTOM", TargetFrameHealthBar, "BOTTOM", 0, 0)
		else
			TargetFrameTextureFrameDeadText:ClearAllPoints()
			TargetFrameTextureFrameDeadText:SetPoint("CENTER", TargetFrameHealthBar, "CENTER", 0, 0)
		end

		if TargetFrameHealthBarTextLeft ~= nil then
			if DUnitFrames:GetConfig("namemode", "Over Portrait") == "Inside Health" then
				TargetFrameHealthBarTextLeft:ClearAllPoints()
				TargetFrameHealthBarTextLeft:SetPoint("BOTTOMLEFT", TargetFrameHealthBar, "BOTTOMLEFT", 2, 2)
				TargetFrameHealthBarTextRight:ClearAllPoints()
				TargetFrameHealthBarTextRight:SetPoint("BOTTOMRIGHT", TargetFrameHealthBar, "BOTTOMRIGHT", -2, 2)
				TargetFrameHealthBarText:ClearAllPoints()
				TargetFrameHealthBarText:SetPoint("BOTTOM", TargetFrameHealthBar, "BOTTOM", 0, 2)
			else
				TargetFrameHealthBarTextLeft:ClearAllPoints()
				TargetFrameHealthBarTextLeft:SetPoint("LEFT", TargetFrameHealthBar, "LEFT", 2, 0)
				TargetFrameHealthBarTextRight:ClearAllPoints()
				TargetFrameHealthBarTextRight:SetPoint("RIGHT", TargetFrameHealthBar, "RIGHT", -2, 0)
				TargetFrameHealthBarText:ClearAllPoints()
				TargetFrameHealthBarText:SetPoint("CENTER", TargetFrameHealthBar, "CENTER", 0, 0)
			end

			if not TargetFrameManaBarTextLeft.hooked then
				TargetFrameManaBarTextLeft.hooked = true
				hooksecurefunc(
					TargetFrameManaBarTextLeft,
					"Show",
					function(sel, ...)
						if DUnitFrames:HPHeight() >= 32 then
							sel:Hide()
						end
					end
				)
			end

			if not TargetFrameManaBarTextRight.hooked then
				TargetFrameManaBarTextRight.hooked = true
				hooksecurefunc(
					TargetFrameManaBarTextRight,
					"Show",
					function(sel, ...)
						if DUnitFrames:HPHeight() >= 32 then
							sel:Hide()
						end
					end
				)
			end

			if not TargetFrameManaBarText.hooked then
				TargetFrameManaBarText.hooked = true
				hooksecurefunc(
					TargetFrameManaBarText,
					"Show",
					function(sel, ...)
						if DUnitFrames:HPHeight() >= 32 then
							sel:Hide()
						end
					end
				)
			end

			if DUnitFrames:GetConfig("namemode", "Over Portrait") == "Inside Health" then
				TargetFrameHealthBarTextLeft:ClearAllPoints()
				TargetFrameHealthBarTextLeft:SetPoint("BOTTOMLEFT", TargetFrameHealthBar, "BOTTOMLEFT", 2, 2)
				TargetFrameHealthBarTextRight:ClearAllPoints()
				TargetFrameHealthBarTextRight:SetPoint("BOTTOMRIGHT", TargetFrameHealthBar, "BOTTOMRIGHT", -3, 2)
				TargetFrameHealthBarText:ClearAllPoints()
				TargetFrameHealthBarText:SetPoint("BOTTOM", TargetFrameHealthBar, "BOTTOM", 0, 2)
			else
				TargetFrameHealthBarTextLeft:ClearAllPoints()
				TargetFrameHealthBarTextLeft:SetPoint("LEFT", TargetFrameHealthBar, "LEFT", 2, 0)
				TargetFrameHealthBarTextRight:ClearAllPoints()
				TargetFrameHealthBarTextRight:SetPoint("RIGHT", TargetFrameHealthBar, "RIGHT", -3, 0)
				TargetFrameHealthBarText:ClearAllPoints()
				TargetFrameHealthBarText:SetPoint("CENTER", TargetFrameHealthBar, "CENTER", 0, 0)
			end
		elseif TargetFrameTextureFrameHealthBarTextLeft ~= nil then
			if DUnitFrames:GetConfig("namemode", "Over Portrait") == "Inside Health" then
				TargetFrameTextureFrameHealthBarTextLeft:ClearAllPoints()
				TargetFrameTextureFrameHealthBarTextLeft:SetPoint("BOTTOMLEFT", TargetFrameHealthBar, "BOTTOMLEFT", 2, 2)
				TargetFrameTextureFrameHealthBarTextRight:ClearAllPoints()
				TargetFrameTextureFrameHealthBarTextRight:SetPoint("BOTTOMRIGHT", TargetFrameHealthBar, "BOTTOMRIGHT", -3, 2)
				TargetFrameTextureFrameHealthBarText:ClearAllPoints()
				TargetFrameTextureFrameHealthBarText:SetPoint("BOTTOM", TargetFrameHealthBar, "BOTTOM", 0, 2)
			else
				TargetFrameTextureFrameHealthBarTextLeft:ClearAllPoints()
				TargetFrameTextureFrameHealthBarTextLeft:SetPoint("LEFT", TargetFrameHealthBar, "LEFT", 2, 0)
				TargetFrameTextureFrameHealthBarTextRight:ClearAllPoints()
				TargetFrameTextureFrameHealthBarTextRight:SetPoint("RIGHT", TargetFrameHealthBar, "RIGHT", -3, 0)
				TargetFrameTextureFrameHealthBarText:ClearAllPoints()
				TargetFrameTextureFrameHealthBarText:SetPoint("CENTER", TargetFrameHealthBar, "CENTER", 0, 0)
			end

			if not TargetFrameTextureFrameManaBarTextLeft.hooked then
				TargetFrameTextureFrameManaBarTextLeft.hooked = true
				hooksecurefunc(
					TargetFrameTextureFrameManaBarTextLeft,
					"Show",
					function(sel, ...)
						if DUnitFrames:HPHeight() >= 32 then
							sel:Hide()
						end
					end
				)
			end

			if not TargetFrameTextureFrameManaBarTextRight.hooked then
				TargetFrameTextureFrameManaBarTextRight.hooked = true
				hooksecurefunc(
					TargetFrameTextureFrameManaBarTextRight,
					"Show",
					function(sel, ...)
						if DUnitFrames:HPHeight() >= 32 then
							sel:Hide()
						end
					end
				)
			end

			if not TargetFrameTextureFrameManaBarText.hooked then
				TargetFrameTextureFrameManaBarText.hooked = true
				hooksecurefunc(
					TargetFrameTextureFrameManaBarText,
					"Show",
					function(sel, ...)
						if DUnitFrames:HPHeight() >= 32 then
							sel:Hide()
						end
					end
				)
			end

			if DUnitFrames:GetConfig("namemode", "Over Portrait") == "Inside Health" then
				TargetFrameTextureFrameManaBarTextLeft:ClearAllPoints()
				TargetFrameTextureFrameManaBarTextLeft:SetPoint("LEFT", TargetFrameManaBar, "LEFT", 2, 0)
				TargetFrameTextureFrameManaBarTextRight:ClearAllPoints()
				TargetFrameTextureFrameManaBarTextRight:SetPoint("RIGHT", TargetFrameManaBar, "RIGHT", -3, 0)
				TargetFrameTextureFrameManaBarText:ClearAllPoints()
				TargetFrameTextureFrameManaBarText:SetPoint("CENTER", TargetFrameManaBar, "CENTER", 0, 0)
			else
				TargetFrameTextureFrameManaBarTextLeft:ClearAllPoints()
				TargetFrameTextureFrameManaBarTextLeft:SetPoint("LEFT", TargetFrameManaBar, "LEFT", 2, 0)
				TargetFrameTextureFrameManaBarTextRight:ClearAllPoints()
				TargetFrameTextureFrameManaBarTextRight:SetPoint("RIGHT", TargetFrameManaBar, "RIGHT", -3, 0)
				TargetFrameTextureFrameManaBarText:ClearAllPoints()
				TargetFrameTextureFrameManaBarText:SetPoint("CENTER", TargetFrameManaBar, "CENTER", 0, 0)
			end
		end

		if CanInspect and GetInspectSpecialization then
			InspectTargetSpec()
		end
	end

	local ThreatBorder = nil
	if TargetFrameNumericalThreat ~= nil then
		ThreatBorder = select(3, TargetFrameNumericalThreat:GetRegions())
	end

	function TargetFrame.Think()
		if TargetFrameTextureFrameName then
			TargetFrameTextureFrameName:ClearAllPoints()
			if TargetFrame.buffsOnTop then
				local y = -4
				if DUnitFrames:GetConfig("namemode", "Over Portrait") == "Over Health" then
					TargetFrameTextureFrameName:SetPoint("TOP", TargetFrameManaBar, "BOTTOM", 0, y)
				end
			else
				local y = 6
				if DUnitFrames:GetConfig("namemode", "Over Portrait") == "Over Health" then
					TargetFrameTextureFrameName:SetPoint("BOTTOM", TargetFrameHealthBar, "TOP", 0, y)
				end
			end

			if DUnitFrames:GetConfig("namemode", "Over Portrait") == "Over Portrait" then
				TargetFrameTextureFrameName:SetPoint("BOTTOM", TargetFramePortrait, "TOP", 0, 12)
			end

			if DUnitFrames:GetConfig("namemode", "Over Portrait") == "Inside Health" then
				TargetFrameTextureFrameName:ClearAllPoints()
				TargetFrameTextureFrameName:SetPoint("TOP", TargetFrameHealthBar, "TOP", 0, -1)
			end
		end

		if ThreatBorder and ThreatBorder:IsShown() then
			y = 24
			local r, g, b, isDefault = DUnitFrames:GetBorderColor("TARGET", TargetFrame)
			if ThreatBorder then
				if r and g and b and not isDefault then
					ThreatBorder:SetVertexColor(r, g, b, 1)
				else
					ThreatBorder:SetVertexColor(1, 0, 0, 1)
				end
			end
		else
			local _, _, threatpct, _, _, _ = UnitDetailedThreatSituation("PLAYER", "TARGET")
			if TargetFrame.DUFThreat == nil then
				TargetFrame.DUFThreat = TargetFrame:CreateFontString(nil, "ARTWORK")
			end

			TargetFrame.DUFThreat:SetFont(STANDARD_TEXT_FONT, 12, DUnitFrames:GetFontFlags())
			if DUnitFrames:GetConfig("namemode") == "Over Health" then
				TargetFrame.DUFThreat:SetPoint("BOTTOM", TargetFrameHealthBar, "TOP", 0, 20)
			else
				TargetFrame.DUFThreat:SetPoint("BOTTOM", TargetFrameHealthBar, "TOP", 0, 6)
			end

			if threatpct == nil then
				threatpct = 0
			end

			if threatpct > 0 and DUnitFrames:GetConfig("showthreat", true) then
				threatpct = string.format("%.0f", threatpct)
				TargetFrame.DUFThreat:SetText(threatpct .. "%")
			else
				TargetFrame.DUFThreat:SetText("")
			end
		end

		C_Timer.After(0.5, TargetFrame.Think)
	end

	TargetFrame.Think()
	if TargetFrameTextureFrameName then
		hooksecurefunc(
			TargetFrameTextureFrameName,
			"SetText",
			function(sel, text, ...)
				if sel.dufsettext then return end
				sel.dufsettext = true
				DUnitFrames:SetFont(sel, DUnitFrames:GetConfig("namesize", 10))
				if DUnitFrames:GetConfig("namemode", "Over Portrait") == "Hide" then
					sel:SetAlpha(0)
				else
					sel:SetAlpha(1)
				end

				sel.dufsettext = false
			end
		)

		TargetFrameTextureFrameName:SetText(TargetFrameTextureFrameName:GetText())
	end

	if TargetFrameTextureFrameTexture then
		hooksecurefunc(
			TargetFrameTextureFrameTexture,
			"SetVertexColor",
			function(sel, oR, oG, oB)
				if sel.dufsetvertexcolor then return end
				sel.dufsetvertexcolor = true
				local r, g, b, isDefault = DUnitFrames:GetBorderColor("TARGET", sel)
				if r and g and b and not isDefault then
					sel:SetVertexColor(r, g, b, 1)
				else
					sel:SetVertexColor(oR, oG, oB, 1)
				end

				if sel.spacer then
					sel.spacer:SetVertexColor(sel:GetVertexColor())
				end

				sel.dufsetvertexcolor = false
			end
		)

		TargetFrameTextureFrameTexture:SetVertexColor(TargetFrameTextureFrameTexture:GetVertexColor())
	end

	if TargetFrameToTTextureFrameTexture then
		hooksecurefunc(
			TargetFrameToTTextureFrameTexture,
			"SetVertexColor",
			function(sel, oR, oG, oB)
				if sel.dufsetvertexcolor then return end
				sel.dufsetvertexcolor = true
				local r, g, b, isDefault = DUnitFrames:GetBorderColor("TARGETTARGET", sel)
				if r and g and b and not isDefault then
					sel:SetVertexColor(r, g, b, 1)
				else
					sel:SetVertexColor(oR, oG, oB, 1)
				end

				sel.dufsetvertexcolor = false
			end
		)

		TargetFrameToTTextureFrameTexture:SetVertexColor(1, 1, 1)
	end

	if CanInspect and GetInspectSpecialization then
		local f = CreateFrame("Frame")
		function InspectTargetSpec()
			if UnitIsPlayer("TARGET") and CanInspect("TARGET") and CheckInteractDistance("TARGET", 1) then
				f:RegisterEvent("INSPECT_READY")
				NotifyInspect("TARGET")
			end
		end

		f:SetScript(
			"OnEvent",
			function(sel, event, ...)
				if GetInspectSpecialization ~= nil then
					local currentSpec = GetInspectSpecialization("TARGET")
					f:UnregisterEvent("INSPECT_READY")
					ClearInspectPlayer()
					local id, _, _, icon, _, _ = GetSpecializationInfoByID(currentSpec)
					if id ~= nil and not InCombatLockdown() and DUnitFrames:GetConfig("showspecs", true) and icon then
						TargetFramePortrait:SetTexture(icon)
						TargetFramePortrait:SetTexCoord(0, 1, 0, 1)
					end
				end
			end
		)
	end
end

function DUnitFrames:UpdateTargetFrame()
	TargetFrameManaBar:ClearAllPoints()
	TargetFrameManaBar:SetPoint("CENTER", TargetFrame, "CENTER", 0, 0)
	TargetFrameHealthBar:SetHeight(1)
	TargetFrameManaBar:SetHeight(1)
end
