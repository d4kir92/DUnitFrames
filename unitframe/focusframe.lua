local _, DUnitFrames = ...
-- #FocusFrame
if FocusFrame then
	function DUnitFrames:FocusFrameSetup()
		if FocusFrameHealthBar then
			hooksecurefunc(
				FocusFrameHealthBar,
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

			FocusFrameHealthBar:SetStatusBarTexture("")
		end

		if FocusFrameManaBar then
			hooksecurefunc(
				FocusFrameManaBar,
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

			FocusFrameManaBar:SetStatusBarTexture("")
		end

		if FocusFrameTextureFrame and FocusFrameTextureFrame.HealthBarTextLeft then
			FocusFrameTextureFrameHealthBarText = FocusFrameTextureFrame.HealthBarText
			FocusFrameTextureFrameHealthBarTextLeft = FocusFrameTextureFrame.HealthBarTextLeft
			FocusFrameTextureFrameHealthBarTextRight = FocusFrameTextureFrame.HealthBarTextRight
			FocusFrameTextureFrameManaBarText = FocusFrameTextureFrame.ManaBarText
			FocusFrameTextureFrameManaBarTextLeft = FocusFrameTextureFrame.ManaBarTextLeft
			FocusFrameTextureFrameManaBarTextRight = FocusFrameTextureFrame.ManaBarTextRight
		end

		if FocusFrameHealthBar then
			hooksecurefunc(
				FocusFrameHealthBar,
				"SetStatusBarColor",
				function(sel, oR, oG, oB)
					if sel.dufsetvertexcolor then return end
					sel.dufsetvertexcolor = true
					local r, g, b = DUnitFrames:GetBarColor("FOCUS", sel)
					if r and g and b then
						sel:SetStatusBarColor(r, g, b)
					else
						sel:SetStatusBarColor(oR, oG, oB)
					end

					sel.dufsetvertexcolor = false
				end
			)

			FocusFrameHealthBar:SetStatusBarColor(FocusFrameHealthBar:GetStatusBarColor())
		end

		if FocusFrameHealthBarTextLeft ~= nil and FocusFrameHealthBarTextLeft.hooked == nil then
			FocusFrameHealthBarTextLeft.hooked = true
			hooksecurefunc(
				FocusFrameHealthBarTextRight,
				"SetText",
				function(sel, text)
					if sel.dufsettext then return end
					sel.dufsettext = true
					DUnitFrames:SetFont(sel)
					local newText = DUnitFrames:ModifyText(text, UnitHealth("FOCUS"), UnitHealthMax("FOCUS"), "FocusFrameHealthBarTextRight")
					sel:SetText(newText)
					sel.dufsettext = false
				end
			)

			FocusFrameHealthBarTextRight:SetText(FocusFrameHealthBarTextRight:GetText())
			hooksecurefunc(
				FocusFrameHealthBarTextLeft,
				"SetText",
				function(sel, text)
					if sel.dufsettext then return end
					sel.dufsettext = true
					DUnitFrames:SetFont(sel)
					local newText = DUnitFrames:ModifyText(text, UnitHealth("FOCUS"), UnitHealthMax("FOCUS"), "FocusFrameHealthBarTextLeft")
					sel:SetText(newText)
					sel.dufsettext = false
				end
			)

			FocusFrameHealthBarTextLeft:SetText(FocusFrameHealthBarTextLeft:GetText())
			hooksecurefunc(
				FocusFrameHealthBarText,
				"SetText",
				function(sel, text)
					if sel.dufsettext then return end
					sel.dufsettext = true
					DUnitFrames:SetFont(sel)
					local newText = DUnitFrames:ModifyText(text, UnitHealth("FOCUS"), UnitHealthMax("FOCUS"), "FocusFrameHealthBarText")
					sel:SetText(newText)
					sel.dufsettext = false
				end
			)

			FocusFrameHealthBarText:SetText(FocusFrameHealthBarText:GetText())
			hooksecurefunc(
				FocusFrameManaBarTextLeft,
				"SetText",
				function(sel, text)
					if sel.dufsettext then return end
					sel.dufsettext = true
					DUnitFrames:SetFont(sel)
					local newText = DUnitFrames:ModifyText(text, UnitPower("FOCUS"), UnitPowerMax("FOCUS"), "FocusFrameManaBarTextLeft")
					sel:SetText(newText)
					sel.dufsettext = false
				end
			)

			FocusFrameManaBarTextLeft:SetText(FocusFrameManaBarTextLeft:GetText())
			hooksecurefunc(
				FocusFrameManaBarTextRight,
				"SetText",
				function(sel, text)
					if sel.dufsettext then return end
					sel.dufsettext = true
					DUnitFrames:SetFont(sel)
					local newText = DUnitFrames:ModifyText(text, UnitPower("FOCUS"), UnitPowerMax("FOCUS"), "FocusFrameManaBarTextRight")
					sel:SetText(newText)
					sel.dufsettext = false
				end
			)

			FocusFrameManaBarTextRight:SetText(FocusFrameManaBarTextRight:GetText())
			hooksecurefunc(
				FocusFrameManaBarText,
				"SetText",
				function(sel, text)
					if sel.dufsettext then return end
					sel.dufsettext = true
					DUnitFrames:SetFont(sel)
					local newText = DUnitFrames:ModifyText(text, UnitPower("FOCUS"), UnitPowerMax("FOCUS"), "FocusFrameManaBarText")
					sel:SetText(newText)
					sel.dufsettext = false
				end
			)

			FocusFrameManaBarText:SetText(FocusFrameManaBarText:GetText())
		end

		if FocusFrameTextureFrameHealthBarTextLeft ~= nil and FocusFrameTextureFrameHealthBarTextLeft.hooked == nil then
			FocusFrameTextureFrameHealthBarTextLeft.hooked = true
			hooksecurefunc(
				FocusFrameTextureFrameHealthBarTextLeft,
				"SetText",
				function(sel, text)
					if sel.dufsettext then return end
					sel.dufsettext = true
					DUnitFrames:SetFont(sel)
					local newText = DUnitFrames:ModifyText(text, UnitHealth("FOCUS"), UnitHealthMax("FOCUS"), "FocusFrameTextureFrameHealthBarTextLeft")
					sel:SetText(newText)
					sel.dufsettext = false
				end
			)

			FocusFrameTextureFrameHealthBarTextLeft:SetText(FocusFrameTextureFrameHealthBarTextLeft:GetText())
			hooksecurefunc(
				FocusFrameTextureFrameHealthBarTextRight,
				"SetText",
				function(sel, text)
					if sel.dufsettext then return end
					sel.dufsettext = true
					DUnitFrames:SetFont(sel)
					local newText = DUnitFrames:ModifyText(text, UnitHealth("FOCUS"), UnitHealthMax("FOCUS"), "FocusFrameTextureFrameHealthBarTextRight")
					sel:SetText(newText)
					sel.dufsettext = false
				end
			)

			FocusFrameTextureFrameHealthBarTextRight:SetText(FocusFrameTextureFrameHealthBarTextRight:GetText())
			hooksecurefunc(
				FocusFrameTextureFrameHealthBarText,
				"SetText",
				function(sel, text)
					if sel.dufsettext then return end
					sel.dufsettext = true
					DUnitFrames:SetFont(sel)
					local newText = DUnitFrames:ModifyText(text, UnitHealth("FOCUS"), UnitHealthMax("FOCUS"), "FocusFrameTextureFrameHealthBarText")
					sel:SetText(newText)
					sel.dufsettext = false
				end
			)

			FocusFrameTextureFrameHealthBarText:SetText(FocusFrameTextureFrameHealthBarText:GetText())
			hooksecurefunc(
				FocusFrameTextureFrameManaBarTextLeft,
				"SetText",
				function(sel, text)
					if sel.dufsettext then return end
					sel.dufsettext = true
					DUnitFrames:SetFont(sel)
					local newText = DUnitFrames:ModifyText(text, UnitPower("FOCUS"), UnitPowerMax("FOCUS"), "FocusFrameTextureFrameManaBarTextLeft")
					sel:SetText(newText)
					sel.dufsettext = false
				end
			)

			FocusFrameTextureFrameManaBarTextLeft:SetText(FocusFrameTextureFrameManaBarTextLeft:GetText())
			hooksecurefunc(
				FocusFrameTextureFrameManaBarTextRight,
				"SetText",
				function(sel, text)
					if sel.dufsettext then return end
					sel.dufsettext = true
					DUnitFrames:SetFont(sel)
					local newText = DUnitFrames:ModifyText(text, UnitPower("FOCUS"), UnitPowerMax("FOCUS"), "FocusFrameTextureFrameManaBarTextRight")
					sel:SetText(newText)
					sel.dufsettext = false
				end
			)

			FocusFrameTextureFrameManaBarTextRight:SetText(FocusFrameTextureFrameManaBarTextRight:GetText())
			hooksecurefunc(
				FocusFrameTextureFrameManaBarText,
				"SetText",
				function(sel, text)
					if sel.dufsettext then return end
					sel.dufsettext = true
					DUnitFrames:SetFont(sel)
					local newText = DUnitFrames:ModifyText(text, UnitPower("FOCUS"), UnitPowerMax("FOCUS"), "FocusFrameTextureFrameManaBarText")
					sel:SetText(newText)
					sel.dufsettext = false
				end
			)

			FocusFrameTextureFrameManaBarText:SetText(FocusFrameTextureFrameManaBarText:GetText())
		end

		-- #FocusFrame
		if FocusFrameHealthBar then
			hooksecurefunc(
				FocusFrameHealthBar,
				"SetHeight",
				function(sel)
					if sel.dufsetheight then return end
					sel.dufsetheight = true
					sel:SetHeight(DUnitFrames:HPHeight())
					sel.dufsetheight = false
				end
			)

			FocusFrameHealthBar:SetHeight(27)
			hooksecurefunc(
				FocusFrameHealthBar,
				"SetSize",
				function(sel)
					if sel.dufsetsize then return end
					sel.dufsetsize = true
					sel:SetHeight(DUnitFrames:HPHeight())
					sel.dufsetsize = false
				end
			)

			hooksecurefunc(
				FocusFrameHealthBar,
				"SetPoint",
				function(sel)
					if sel.dufsetpoint then return end
					sel.dufsetpoint = true
					sel:SetPoint("TOPLEFT", 6, -24)
					sel.dufsetpoint = false
				end
			)

			FocusFrameHealthBar:SetPoint("TOPLEFT", 6, -24)
		end

		if FocusFrameManaBar then
			hooksecurefunc(
				FocusFrameManaBar,
				"SetHeight",
				function(sel)
					if sel.dufsetheight then return end
					sel.dufsetheight = true
					if 38 - DUnitFrames:HPHeight() > 1 then
						sel:SetHeight(38 - DUnitFrames:HPHeight())
					else
						sel:SetHeight(1)
					end

					sel.dufsetheight = false
				end
			)

			FocusFrameManaBar:SetHeight(27)
			hooksecurefunc(
				FocusFrameManaBar,
				"SetSize",
				function(sel)
					if sel.dufsetsize then return end
					sel.dufsetsize = true
					if 38 - DUnitFrames:HPHeight() > 1 then
						sel:SetHeight(38 - DUnitFrames:HPHeight())
					else
						sel:SetHeight(1)
					end

					sel.dufsetsize = false
				end
			)

			hooksecurefunc(
				FocusFrameManaBar,
				"SetPoint",
				function(sel)
					if sel.dufsetpoint then return end
					sel.dufsetpoint = true
					sel:SetPoint("TOPLEFT", 6, -23 - DUnitFrames:HPHeight() - 1)
					sel.dufsetpoint = false
				end
			)

			FocusFrameManaBar:SetPoint("TOPLEFT", 6, -24)
		end

		if FocusFrameBackground then
			FocusFrameBackground:SetHeight(40)
			FocusFrameBackground:ClearAllPoints()
			FocusFrameBackground:SetPoint("TOPLEFT", 6, -24)
		end

		if FocusFrameNameBackground then
			FocusFrameNameBackground:SetParent(DUFHIDDEN)
		end

		function DUnitFrames:UpdateFocusTexture()
			local texture = "Interface\\Addons\\DUnitFrames\\media\\UI-TargetingFrame"
			local class = UnitClassification("FOCUS")
			if class == "worldboss" or class == "elite" then
				texture = "Interface\\Addons\\DUnitFrames\\media\\UI-TargetingFrame-Elite"
			elseif class == "rareelite" then
				texture = "Interface\\Addons\\DUnitFrames\\media\\UI-TargetingFrame-Rare-Elite"
			elseif class == "rare" then
				texture = "Interface\\Addons\\DUnitFrames\\media\\UI-TargetingFrame-Rare"
			end

			FocusFrameTextureFrameTexture:SetTexture(texture)
			if class == "minus" then
				FocusFrameFlash:SetTexture("")
			end

			if FocusFrameTextureFrameTexture.spacer == nil then
				FocusFrameTextureFrameTexture.spacer = FocusFrameTextureFrame:CreateTexture(nil, "ARTWORK")
				FocusFrameTextureFrameTexture.spacer:SetDrawLayer("ARTWORK", 7)
				hooksecurefunc(
					FocusFrameTextureFrameTexture.spacer,
					"SetVertexColor",
					function(sel, r, g, b, a)
						if sel.dufsetvertexcolor then return end
						sel.dufsetvertexcolor = true
						sel:SetVertexColor(r, g, b, a)
						sel.dufsetvertexcolor = false
					end
				)

				FocusFrameTextureFrameTexture.spacer:SetVertexColor(1, 1, 1)
			end

			if FocusFrameTextureFrameTexture.spacer then
				FocusFrameTextureFrameTexture.spacer:SetSize(128, 16)
				FocusFrameTextureFrameTexture.spacer:SetPoint("LEFT", FocusFrameTextureFrameTexture, "LEFT", 5, 21 - DUnitFrames:HPHeight())
				FocusFrameTextureFrameTexture.spacer:SetTexture("Interface\\Addons\\DUnitFrames\\media\\UI-TargetingFrame" .. "_Spacer")
				if DUnitFrames:HPHeight() >= 32 then
					FocusFrameTextureFrameTexture.spacer:Hide()
				else
					FocusFrameTextureFrameTexture.spacer:Show()
				end
			end

			FocusFrameTextureFrameTexture:SetVertexColor(0, 0, 0)
			if DUnitFrames:GetConfig("namemode", "Over Portrait") == "Inside Health" then
				FocusFrameTextureFrameDeadText:ClearAllPoints()
				FocusFrameTextureFrameDeadText:SetPoint("BOTTOM", TargetFrameHealthBar, "BOTTOM", 0, 0)
			else
				FocusFrameTextureFrameDeadText:ClearAllPoints()
				FocusFrameTextureFrameDeadText:SetPoint("CENTER", TargetFrameHealthBar, "CENTER", 0, 0)
			end

			if FocusFrameHealthBarTextLeft ~= nil then
				if DUnitFrames:GetConfig("namemode", "Over Portrait") == "Inside Health" then
					FocusFrameHealthBarTextLeft:ClearAllPoints()
					FocusFrameHealthBarTextLeft:SetPoint("BOTTOMLEFT", FocusFrameHealthBar, "BOTTOMLEFT", 2, 2)
					FocusFrameHealthBarTextRight:ClearAllPoints()
					FocusFrameHealthBarTextRight:SetPoint("BOTTOMRIGHT", FocusFrameHealthBar, "BOTTOMRIGHT", -2, 2)
					FocusFrameHealthBarText:ClearAllPoints()
					FocusFrameHealthBarText:SetPoint("BOTTOM", FocusFrameHealthBar, "BOTTOM", 0, 2)
				else
					FocusFrameHealthBarTextLeft:ClearAllPoints()
					FocusFrameHealthBarTextLeft:SetPoint("LEFT", FocusFrameHealthBar, "LEFT", 2, 0)
					FocusFrameHealthBarTextRight:ClearAllPoints()
					FocusFrameHealthBarTextRight:SetPoint("RIGHT", FocusFrameHealthBar, "RIGHT", -2, 0)
					FocusFrameHealthBarText:ClearAllPoints()
					FocusFrameHealthBarText:SetPoint("CENTER", FocusFrameHealthBar, "CENTER", 0, 0)
				end

				if not FocusFrameManaBarTextLeft.hooked then
					FocusFrameManaBarTextLeft.hooked = true
					hooksecurefunc(
						FocusFrameManaBarTextLeft,
						"Show",
						function(sel, ...)
							if DUnitFrames:HPHeight() >= 32 then
								sel:Hide()
							end
						end
					)
				end

				if not FocusFrameManaBarTextRight.hooked then
					FocusFrameManaBarTextRight.hooked = true
					hooksecurefunc(
						FocusFrameManaBarTextRight,
						"Show",
						function(sel, ...)
							if DUnitFrames:HPHeight() >= 32 then
								sel:Hide()
							end
						end
					)
				end

				if not FocusFrameManaBarText.hooked then
					FocusFrameManaBarText.hooked = true
					hooksecurefunc(
						FocusFrameManaBarText,
						"Show",
						function(sel, ...)
							if DUnitFrames:HPHeight() >= 32 then
								sel:Hide()
							end
						end
					)
				end

				if DUnitFrames:GetConfig("namemode", "Over Portrait") == "Inside Health" then
					FocusFrameManaBarTextLeft:ClearAllPoints()
					FocusFrameManaBarTextLeft:SetPoint("LEFT", FocusFrameManaBar, "LEFT", 2, 0)
					FocusFrameManaBarTextRight:ClearAllPoints()
					FocusFrameManaBarTextRight:SetPoint("RIGHT", FocusFrameManaBar, "RIGHT", -2, 0)
					FocusFrameManaBarText:ClearAllPoints()
					FocusFrameManaBarText:SetPoint("CENTER", FocusFrameManaBar, "CENTER", 0, 0)
				else
					FocusFrameManaBarTextLeft:ClearAllPoints()
					FocusFrameManaBarTextLeft:SetPoint("LEFT", FocusFrameManaBar, "LEFT", 2, 0)
					FocusFrameManaBarTextRight:ClearAllPoints()
					FocusFrameManaBarTextRight:SetPoint("RIGHT", FocusFrameManaBar, "RIGHT", -2, 0)
					FocusFrameManaBarText:ClearAllPoints()
					FocusFrameManaBarText:SetPoint("CENTER", FocusFrameManaBar, "CENTER", 0, 0)
				end
			elseif FocusFrameTextureFrameHealthBarTextLeft ~= nil then
				FocusFrameTextureFrameHealthBarTextLeft:SetPoint("LEFT", FocusFrameHealthBar, "LEFT", 2, 0)
				FocusFrameTextureFrameHealthBarTextRight:SetPoint("RIGHT", FocusFrameHealthBar, "RIGHT", -2, 0)
				FocusFrameTextureFrameHealthBarText:SetPoint("CENTER", FocusFrameHealthBar, "CENTER", 0, 0)
				if not FocusFrameTextureFrameManaBarTextLeft.hooked then
					FocusFrameTextureFrameManaBarTextLeft.hooked = true
					hooksecurefunc(
						FocusFrameTextureFrameManaBarTextLeft,
						"Show",
						function(sel, ...)
							if DUnitFrames:HPHeight() >= 32 then
								sel:Hide()
							end
						end
					)
				end

				if not FocusFrameTextureFrameManaBarTextRight.hooked then
					FocusFrameTextureFrameManaBarTextRight.hooked = true
					hooksecurefunc(
						FocusFrameTextureFrameManaBarTextRight,
						"Show",
						function(sel, ...)
							if DUnitFrames:HPHeight() >= 32 then
								sel:Hide()
							end
						end
					)
				end

				if not FocusFrameTextureFrameManaBarText.hooked then
					FocusFrameTextureFrameManaBarText.hooked = true
					hooksecurefunc(
						FocusFrameTextureFrameManaBarText,
						"Show",
						function(sel, ...)
							if DUnitFrames:HPHeight() >= 32 then
								sel:Hide()
							end
						end
					)
				end

				FocusFrameTextureFrameManaBarTextLeft:SetPoint("LEFT", FocusFrameManaBar, "LEFT", 2, -1)
				FocusFrameTextureFrameManaBarTextRight:SetPoint("RIGHT", FocusFrameManaBar, "RIGHT", -2, -1)
				FocusFrameTextureFrameManaBarText:SetPoint("CENTER", FocusFrameManaBar, "CENTER", 0, 0)
			end

			if InspectFocusSpec then
				InspectFocusSpec()
			end
		end

		local ThreatBorder = nil
		if FocusFrameNumericalThreat ~= nil then
			ThreatBorder = select(3, FocusFrameNumericalThreat:GetRegions())
		end

		function FocusFrame.Think()
			if FocusFrameTextureFrameName then
				FocusFrameTextureFrameName:ClearAllPoints()
				if FocusFrame.buffsOnTop then
					local y = -4
					if DUnitFrames:GetConfig("namemode", "Over Portrait") == "Over Health" then
						FocusFrameTextureFrameName:SetPoint("TOP", FocusFrameManaBar, "BOTTOM", 0, y)
					end
				else
					local y = 6
					if DUnitFrames:GetConfig("namemode", "Over Portrait") == "Over Health" then
						FocusFrameTextureFrameName:SetPoint("BOTTOM", FocusFrameHealthBar, "TOP", 0, y)
					end
				end

				if DUnitFrames:GetConfig("namemode", "Over Portrait") == "Over Portrait" then
					FocusFrameTextureFrameName:SetPoint("BOTTOM", FocusFramePortrait, "TOP", 0, 12)
				end

				if DUnitFrames:GetConfig("namemode", "Over Portrait") == "Inside Health" then
					FocusFrameTextureFrameName:ClearAllPoints()
					FocusFrameTextureFrameName:SetPoint("TOP", FocusFrameHealthBar, "TOP", 0, -1)
				end
			end

			if ThreatBorder and ThreatBorder:IsShown() then
				y = 24
				local r, g, b, isDefault = DUnitFrames:GetBorderColor("FOCUS", ThreatBorder)
				if r and g and b and not isDefault then
					ThreatBorder:SetVertexColor(r, g, b, 1)
				else
					ThreatBorder:SetVertexColor(1, 0, 0, 1)
				end
			end

			C_Timer.After(0.5, FocusFrame.Think)
		end

		FocusFrame.Think()
		if FocusFrameTextureFrameName then
			hooksecurefunc(
				FocusFrameTextureFrameName,
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

			FocusFrameTextureFrameName:SetText(FocusFrameTextureFrameName:GetText())
		end

		if FocusFrameTextureFrameTexture then
			hooksecurefunc(
				FocusFrameTextureFrameTexture,
				"SetVertexColor",
				function(sel, oR, oG, oB)
					if sel.dufsetvertexcolor then return end
					sel.dufsetvertexcolor = true
					local r, g, b, isDefault = DUnitFrames:GetBorderColor("FOCUS", sel)
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

			FocusFrameTextureFrameTexture:SetVertexColor(1, 1, 1)
		end

		if CanInspect and GetInspectSpecialization then
			local f = CreateFrame("Frame")
			function InspectFocusSpec()
				if UnitIsPlayer("FOCUS") and CanInspect("FOCUS") and CheckInteractDistance("FOCUS", 1) then
					f:RegisterEvent("INSPECT_READY")
					NotifyInspect("FOCUS")
				end
			end

			f:SetScript(
				"OnEvent",
				function(sel, event, ...)
					if GetInspectSpecialization ~= nil then
						local currentSpec = GetInspectSpecialization("FOCUS")
						f:UnregisterEvent("INSPECT_READY")
						ClearInspectPlayer()
						local id, _, _, icon, _, _ = GetSpecializationInfoByID(currentSpec)
						if id ~= nil and not InCombatLockdown() and DUnitFrames:GetConfig("showspecs", true) and icon then
							FocusFramePortrait:SetTexture(icon)
							FocusFramePortrait:SetTexCoord(0, 1, 0, 1)
						end
					end
				end
			)
		end
	end

	function DUnitFrames:UpdateFocusFrame()
		if FocusFrame then
			FocusFrameHealthBar:SetHeight(1)
			FocusFrameManaBar:SetHeight(1)
			FocusFrameManaBar:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
		end
	end
end
