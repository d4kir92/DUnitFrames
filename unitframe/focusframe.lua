local _, DUnitFrames = ...
-- #FocusFrame
local DUFFontSize = 12
if FocusFrame then
	function DUFFocusFrameSetup()
		if FocusFrameHealthBar then
			hooksecurefunc(
				FocusFrameHealthBar,
				"SetStatusBarTexture",
				function(self, texture)
					if self.settexture then return end
					self.settexture = true
					if DUFTAB["bartexture"] and DUFTAB["bartexture"] > 0 then
						self:SetStatusBarTexture("Interface\\Addons\\DUnitFrames\\media\\bars\\bar_" .. DUFTAB["bartexture"])
					else
						self:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar")
					end

					self.settexture = false
				end
			)

			FocusFrameHealthBar:SetStatusBarTexture("")
		end

		if FocusFrameManaBar then
			hooksecurefunc(
				FocusFrameManaBar,
				"SetStatusBarTexture",
				function(self, texture)
					if self.settexture then return end
					self.settexture = true
					if DUFTAB["bartexture"] and DUFTAB["bartexture"] > 0 then
						self:SetStatusBarTexture("Interface\\Addons\\DUnitFrames\\media\\bars\\bar_" .. DUFTAB["bartexture"])
					else
						self:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar")
					end

					self.settexture = false
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
				function(self, oR, oG, oB)
					if self.dufsetvertexcolor then return end
					self.dufsetvertexcolor = true
					local r, g, b = DUFGetBarColor("FOCUS", self)
					if r and g and b then
						self:SetStatusBarColor(r, g, b)
					else
						self:SetStatusBarColor(oR, oG, oB)
					end

					self.dufsetvertexcolor = false
				end
			)

			FocusFrameHealthBar:SetStatusBarColor(FocusFrameHealthBar:GetStatusBarColor())
		end

		if FocusFrameHealthBarTextLeft ~= nil and FocusFrameHealthBarTextLeft.hooked == nil then
			FocusFrameHealthBarTextLeft.hooked = true
			hooksecurefunc(
				FocusFrameHealthBarTextRight,
				"SetText",
				function(self, text)
					if self.dufsettext then return end
					self.dufsettext = true
					local fontFamily, fontSize, _ = self:GetFont()
					if fontFamily ~= STANDARD_TEXT_FONT or fontSize ~= DUFFontSize then
						self:SetFont(STANDARD_TEXT_FONT, DUFFontSize, DUnitFrames:GetFontFlags())
					end

					local newText = DUFModifyText(text, UnitHealth("FOCUS"), UnitHealthMax("FOCUS"), "FocusFrameHealthBarTextRight")
					self:SetText(newText)
					self.dufsettext = false
				end
			)

			FocusFrameHealthBarTextRight:SetText(FocusFrameHealthBarTextRight:GetText())
			hooksecurefunc(
				FocusFrameHealthBarTextLeft,
				"SetText",
				function(self, text)
					if self.dufsettext then return end
					self.dufsettext = true
					local fontFamily, fontSize, _ = self:GetFont()
					if fontFamily ~= STANDARD_TEXT_FONT or fontSize ~= DUFFontSize then
						self:SetFont(STANDARD_TEXT_FONT, DUFFontSize, DUnitFrames:GetFontFlags())
					end

					local newText = DUFModifyText(text, UnitHealth("FOCUS"), UnitHealthMax("FOCUS"), "FocusFrameHealthBarTextLeft")
					self:SetText(newText)
					self.dufsettext = false
				end
			)

			FocusFrameHealthBarTextLeft:SetText(FocusFrameHealthBarTextLeft:GetText())
			hooksecurefunc(
				FocusFrameHealthBarText,
				"SetText",
				function(self, text)
					if self.dufsettext then return end
					self.dufsettext = true
					local fontFamily, fontSize, _ = self:GetFont()
					if fontFamily ~= STANDARD_TEXT_FONT or fontSize ~= DUFFontSize then
						self:SetFont(STANDARD_TEXT_FONT, DUFFontSize, DUnitFrames:GetFontFlags())
					end

					local newText = DUFModifyText(text, UnitHealth("FOCUS"), UnitHealthMax("FOCUS"), "FocusFrameHealthBarText")
					self:SetText(newText)
					self.dufsettext = false
				end
			)

			FocusFrameHealthBarText:SetText(FocusFrameHealthBarText:GetText())
			hooksecurefunc(
				FocusFrameManaBarTextLeft,
				"SetText",
				function(self, text)
					if self.dufsettext then return end
					self.dufsettext = true
					local fontFamily, fontSize, _ = self:GetFont()
					if fontFamily ~= STANDARD_TEXT_FONT or fontSize ~= DUFFontSize then
						self:SetFont(STANDARD_TEXT_FONT, DUFFontSize, DUnitFrames:GetFontFlags())
					end

					local newText = DUFModifyText(text, UnitPower("FOCUS"), UnitPowerMax("FOCUS"), "FocusFrameManaBarTextLeft")
					self:SetText(newText)
					self.dufsettext = false
				end
			)

			FocusFrameManaBarTextLeft:SetText(FocusFrameManaBarTextLeft:GetText())
			hooksecurefunc(
				FocusFrameManaBarTextRight,
				"SetText",
				function(self, text)
					if self.dufsettext then return end
					self.dufsettext = true
					local fontFamily, fontSize, _ = self:GetFont()
					if fontFamily ~= STANDARD_TEXT_FONT or fontSize ~= DUFFontSize then
						self:SetFont(STANDARD_TEXT_FONT, DUFFontSize, DUnitFrames:GetFontFlags())
					end

					local newText = DUFModifyText(text, UnitPower("FOCUS"), UnitPowerMax("FOCUS"), "FocusFrameManaBarTextRight")
					self:SetText(newText)
					self.dufsettext = false
				end
			)

			FocusFrameManaBarTextRight:SetText(FocusFrameManaBarTextRight:GetText())
			hooksecurefunc(
				FocusFrameManaBarText,
				"SetText",
				function(self, text)
					if self.dufsettext then return end
					self.dufsettext = true
					local fontFamily, fontSize, _ = self:GetFont()
					if fontFamily ~= STANDARD_TEXT_FONT or fontSize ~= DUFFontSize then
						self:SetFont(STANDARD_TEXT_FONT, DUFFontSize, DUnitFrames:GetFontFlags())
					end

					local newText = DUFModifyText(text, UnitPower("FOCUS"), UnitPowerMax("FOCUS"), "FocusFrameManaBarText")
					self:SetText(newText)
					self.dufsettext = false
				end
			)

			FocusFrameManaBarText:SetText(FocusFrameManaBarText:GetText())
		end

		if FocusFrameTextureFrameHealthBarTextLeft ~= nil and FocusFrameTextureFrameHealthBarTextLeft.hooked == nil then
			FocusFrameTextureFrameHealthBarTextLeft.hooked = true
			hooksecurefunc(
				FocusFrameTextureFrameHealthBarTextLeft,
				"SetText",
				function(self, text)
					if self.dufsettext then return end
					self.dufsettext = true
					local fontFamily, fontSize, _ = self:GetFont()
					if fontFamily ~= STANDARD_TEXT_FONT or fontSize ~= DUFFontSize then
						self:SetFont(STANDARD_TEXT_FONT, DUFFontSize, DUnitFrames:GetFontFlags())
					end

					local newText = DUFModifyText(text, UnitHealth("FOCUS"), UnitHealthMax("FOCUS"), "FocusFrameTextureFrameHealthBarTextLeft")
					self:SetText(newText)
					self.dufsettext = false
				end
			)

			FocusFrameTextureFrameHealthBarTextLeft:SetText(FocusFrameTextureFrameHealthBarTextLeft:GetText())
			hooksecurefunc(
				FocusFrameTextureFrameHealthBarTextRight,
				"SetText",
				function(self, text)
					if self.dufsettext then return end
					self.dufsettext = true
					local fontFamily, fontSize, _ = self:GetFont()
					if fontFamily ~= STANDARD_TEXT_FONT or fontSize ~= DUFFontSize then
						self:SetFont(STANDARD_TEXT_FONT, DUFFontSize, DUnitFrames:GetFontFlags())
					end

					local newText = DUFModifyText(text, UnitHealth("FOCUS"), UnitHealthMax("FOCUS"), "FocusFrameTextureFrameHealthBarTextRight")
					self:SetText(newText)
					self.dufsettext = false
				end
			)

			FocusFrameTextureFrameHealthBarTextRight:SetText(FocusFrameTextureFrameHealthBarTextRight:GetText())
			hooksecurefunc(
				FocusFrameTextureFrameHealthBarText,
				"SetText",
				function(self, text)
					if self.dufsettext then return end
					self.dufsettext = true
					local fontFamily, fontSize, _ = self:GetFont()
					if fontFamily ~= STANDARD_TEXT_FONT or fontSize ~= DUFFontSize then
						self:SetFont(STANDARD_TEXT_FONT, DUFFontSize, DUnitFrames:GetFontFlags())
					end

					local newText = DUFModifyText(text, UnitHealth("FOCUS"), UnitHealthMax("FOCUS"), "FocusFrameTextureFrameHealthBarText")
					self:SetText(newText)
					self.dufsettext = false
				end
			)

			FocusFrameTextureFrameHealthBarText:SetText(FocusFrameTextureFrameHealthBarText:GetText())
			hooksecurefunc(
				FocusFrameTextureFrameManaBarTextLeft,
				"SetText",
				function(self, text)
					if self.dufsettext then return end
					self.dufsettext = true
					local fontFamily, fontSize, _ = self:GetFont()
					if fontFamily ~= STANDARD_TEXT_FONT or fontSize ~= DUFFontSize then
						self:SetFont(STANDARD_TEXT_FONT, DUFFontSize, DUnitFrames:GetFontFlags())
					end

					local newText = DUFModifyText(text, UnitPower("FOCUS"), UnitPowerMax("FOCUS"), "FocusFrameTextureFrameManaBarTextLeft")
					self:SetText(newText)
					self.dufsettext = false
				end
			)

			FocusFrameTextureFrameManaBarTextLeft:SetText(FocusFrameTextureFrameManaBarTextLeft:GetText())
			hooksecurefunc(
				FocusFrameTextureFrameManaBarTextRight,
				"SetText",
				function(self, text)
					if self.dufsettext then return end
					self.dufsettext = true
					local fontFamily, fontSize, _ = self:GetFont()
					if fontFamily ~= STANDARD_TEXT_FONT or fontSize ~= DUFFontSize then
						self:SetFont(STANDARD_TEXT_FONT, DUFFontSize, DUnitFrames:GetFontFlags())
					end

					local newText = DUFModifyText(text, UnitPower("FOCUS"), UnitPowerMax("FOCUS"), "FocusFrameTextureFrameManaBarTextRight")
					self:SetText(newText)
					self.dufsettext = false
				end
			)

			FocusFrameTextureFrameManaBarTextRight:SetText(FocusFrameTextureFrameManaBarTextRight:GetText())
			hooksecurefunc(
				FocusFrameTextureFrameManaBarText,
				"SetText",
				function(self, text)
					if self.dufsettext then return end
					self.dufsettext = true
					local fontFamily, fontSize, _ = self:GetFont()
					if fontFamily ~= STANDARD_TEXT_FONT or fontSize ~= DUFFontSize then
						self:SetFont(STANDARD_TEXT_FONT, DUFFontSize, DUnitFrames:GetFontFlags())
					end

					local newText = DUFModifyText(text, UnitPower("FOCUS"), UnitPowerMax("FOCUS"), "FocusFrameTextureFrameManaBarText")
					self:SetText(newText)
					self.dufsettext = false
				end
			)

			FocusFrameTextureFrameManaBarText:SetText(FocusFrameTextureFrameManaBarText:GetText())
		end

		-- #FocusFrame
		if FocusFrameHealthBar then
			hooksecurefunc(
				FocusFrameHealthBar,
				"SetHeight",
				function(self)
					if self.dufsetheight then return end
					self.dufsetheight = true
					self:SetHeight(DUFHPHeight())
					self.dufsetheight = false
				end
			)

			FocusFrameHealthBar:SetHeight(27)
			hooksecurefunc(
				FocusFrameHealthBar,
				"SetSize",
				function(self)
					if self.dufsetsize then return end
					self.dufsetsize = true
					self:SetHeight(DUFHPHeight())
					self.dufsetsize = false
				end
			)

			hooksecurefunc(
				FocusFrameHealthBar,
				"SetPoint",
				function(self)
					if self.dufsetpoint then return end
					self.dufsetpoint = true
					self:SetPoint("TOPLEFT", 6, -24)
					self.dufsetpoint = false
				end
			)

			FocusFrameHealthBar:SetPoint("TOPLEFT", 6, -24)
		end

		if FocusFrameManaBar then
			hooksecurefunc(
				FocusFrameManaBar,
				"SetHeight",
				function(self)
					if self.dufsetheight then return end
					self.dufsetheight = true
					if 38 - DUFHPHeight() > 1 then
						self:SetHeight(38 - DUFHPHeight())
					else
						self:SetHeight(1)
					end

					self.dufsetheight = false
				end
			)

			FocusFrameManaBar:SetHeight(27)
			hooksecurefunc(
				FocusFrameManaBar,
				"SetSize",
				function(self)
					if self.dufsetsize then return end
					self.dufsetsize = true
					if 38 - DUFHPHeight() > 1 then
						self:SetHeight(38 - DUFHPHeight())
					else
						self:SetHeight(1)
					end

					self.dufsetsize = false
				end
			)

			hooksecurefunc(
				FocusFrameManaBar,
				"SetPoint",
				function(self)
					if self.dufsetpoint then return end
					self.dufsetpoint = true
					self:SetPoint("TOPLEFT", 6, -23 - DUFHPHeight() - 1)
					self.dufsetpoint = false
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

		function DUFUpdateFocusTexture()
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
					function(self, r, g, b, a)
						if self.dufsetvertexcolor then return end
						self.dufsetvertexcolor = true
						self:SetVertexColor(r, g, b, a)
						self.dufsetvertexcolor = false
					end
				)

				FocusFrameTextureFrameTexture.spacer:SetVertexColor(1, 1, 1)
			end

			FocusFrameTextureFrameTexture.spacer:SetSize(128, 16)
			FocusFrameTextureFrameTexture.spacer:SetPoint("LEFT", FocusFrameTextureFrameTexture, "LEFT", 5, 21 - DUFHPHeight())
			FocusFrameTextureFrameTexture.spacer:SetTexture("Interface\\Addons\\DUnitFrames\\media\\UI-TargetingFrame" .. "_Spacer")
			if DUFHPHeight() >= 32 then
				FocusFrameTextureFrameTexture.spacer:Hide()
			else
				FocusFrameTextureFrameTexture.spacer:Show()
			end

			FocusFrameTextureFrameTexture:SetVertexColor(0, 0, 0)
			FocusFrameTextureFrameDeadText:ClearAllPoints()
			FocusFrameTextureFrameDeadText:SetPoint("CENTER", TargetFrameHealthBar, "CENTER", 0, 0)
			if DUFGetConfig("namemode", "Over Portrait") == "Inside Health" then
				FocusFrameTextureFrameDeadText:ClearAllPoints()
				FocusFrameTextureFrameDeadText:SetPoint("BOTTOM", TargetFrameHealthBar, "BOTTOM", 0, 0)
			end

			if FocusFrameHealthBarTextLeft ~= nil then
				FocusFrameHealthBarTextLeft:ClearAllPoints()
				FocusFrameHealthBarTextLeft:SetPoint("LEFT", FocusFrameHealthBar, "LEFT", 2, 0)
				FocusFrameHealthBarTextRight:ClearAllPoints()
				FocusFrameHealthBarTextRight:SetPoint("RIGHT", FocusFrameHealthBar, "RIGHT", -2, 0)
				FocusFrameHealthBarText:ClearAllPoints()
				FocusFrameHealthBarText:SetPoint("CENTER", FocusFrameHealthBar, "CENTER", 0, 0)
				if DUFGetConfig("namemode", "Over Portrait") == "Inside Health" then
					FocusFrameHealthBarTextLeft:ClearAllPoints()
					FocusFrameHealthBarTextLeft:SetPoint("BOTTOMLEFT", FocusFrameHealthBar, "BOTTOMLEFT", 2, 2)
					FocusFrameHealthBarTextRight:ClearAllPoints()
					FocusFrameHealthBarTextRight:SetPoint("BOTTOMRIGHT", FocusFrameHealthBar, "BOTTOMRIGHT", -2, 2)
					FocusFrameHealthBarText:ClearAllPoints()
					FocusFrameHealthBarText:SetPoint("BOTTOM", FocusFrameHealthBar, "BOTTOM", 0, 2)
				end

				if not FocusFrameManaBarTextLeft.hooked then
					FocusFrameManaBarTextLeft.hooked = true
					hooksecurefunc(
						FocusFrameManaBarTextLeft,
						"Show",
						function(self, ...)
							if DUFHPHeight() >= 32 then
								self:Hide()
							end
						end
					)
				end

				if not FocusFrameManaBarTextRight.hooked then
					FocusFrameManaBarTextRight.hooked = true
					hooksecurefunc(
						FocusFrameManaBarTextRight,
						"Show",
						function(self, ...)
							if DUFHPHeight() >= 32 then
								self:Hide()
							end
						end
					)
				end

				if not FocusFrameManaBarText.hooked then
					FocusFrameManaBarText.hooked = true
					hooksecurefunc(
						FocusFrameManaBarText,
						"Show",
						function(self, ...)
							if DUFHPHeight() >= 32 then
								self:Hide()
							end
						end
					)
				end

				FocusFrameManaBarTextLeft:ClearAllPoints()
				FocusFrameManaBarTextLeft:SetPoint("LEFT", FocusFrameManaBar, "LEFT", 2, 0)
				FocusFrameManaBarTextRight:ClearAllPoints()
				FocusFrameManaBarTextRight:SetPoint("RIGHT", FocusFrameManaBar, "RIGHT", -2, -1)
				FocusFrameManaBarText:ClearAllPoints()
				FocusFrameManaBarText:SetPoint("CENTER", FocusFrameManaBar, "CENTER", 0, 0)
				if DUFGetConfig("namemode", "Over Portrait") == "Inside Health" then
					FocusFrameManaBarTextLeft:ClearAllPoints()
					FocusFrameManaBarTextLeft:SetPoint("BOTTOMLEFT", FocusFrameManaBar, "BOTTOMLEFT", 2, 0)
					FocusFrameManaBarTextRight:ClearAllPoints()
					FocusFrameManaBarTextRight:SetPoint("BOTTOMRIGHT", FocusFrameManaBar, "BOTTOMRIGHT", -2, -1)
					FocusFrameManaBarText:ClearAllPoints()
					FocusFrameManaBarText:SetPoint("BOTTOM", FocusFrameManaBar, "BOTTOM", 0, 0)
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
						function(self, ...)
							if DUFHPHeight() >= 32 then
								self:Hide()
							end
						end
					)
				end

				if not FocusFrameTextureFrameManaBarTextRight.hooked then
					FocusFrameTextureFrameManaBarTextRight.hooked = true
					hooksecurefunc(
						FocusFrameTextureFrameManaBarTextRight,
						"Show",
						function(self, ...)
							if DUFHPHeight() >= 32 then
								self:Hide()
							end
						end
					)
				end

				if not FocusFrameTextureFrameManaBarText.hooked then
					FocusFrameTextureFrameManaBarText.hooked = true
					hooksecurefunc(
						FocusFrameTextureFrameManaBarText,
						"Show",
						function(self, ...)
							if DUFHPHeight() >= 32 then
								self:Hide()
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
			ThreatBorder = select(3, {FocusFrameNumericalThreat:GetRegions()})
		end

		function FocusFrame.Think()
			if FocusFrameTextureFrameName then
				FocusFrameTextureFrameName:ClearAllPoints()
				if FocusFrame.buffsOnTop then
					local y = -4
					if DUFGetConfig("namemode", "Over Portrait") == "Over Health" then
						FocusFrameTextureFrameName:SetPoint("TOP", FocusFrameManaBar, "BOTTOM", 0, y)
					end
				else
					local y = 6
					if DUFGetConfig("namemode", "Over Portrait") == "Over Health" then
						FocusFrameTextureFrameName:SetPoint("BOTTOM", FocusFrameHealthBar, "TOP", 0, y)
					end
				end

				if DUFGetConfig("namemode", "Over Portrait") == "Over Portrait" then
					FocusFrameTextureFrameName:SetPoint("BOTTOM", FocusFramePortrait, "TOP", 0, 12)
				end

				if DUFGetConfig("namemode", "Over Portrait") == "Inside Health" then
					FocusFrameTextureFrameName:ClearAllPoints()
					FocusFrameTextureFrameName:SetPoint("TOP", FocusFrameHealthBar, "TOP", 0, -1)
				end
			end

			if ThreatBorder and ThreatBorder:IsShown() then
				y = 24
				local r, g, b, isDefault = DUFGetBorderColor("FOCUS", ThreatBorder)
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
				function(self, text, ...)
					if self.dufsettext then return end
					self.dufsettext = true
					local fontFamily, fontSize, fontFlags = self:GetFont()
					if fontFamily ~= STANDARD_TEXT_FONT or fontSize ~= DUFGetConfig("namesize", 10) or fontFlags ~= DUnitFrames:GetFontFlags() then
						self:SetFont(STANDARD_TEXT_FONT, DUFGetConfig("namesize", 10), DUnitFrames:GetFontFlags())
						self:SetShadowOffset(1, -1)
					end

					if DUFGetConfig("namemode", "Over Portrait") == "Hide" then
						self:Hide()
					else
						self:Show()
					end

					self.dufsettext = false
				end
			)

			FocusFrameTextureFrameName:SetText(FocusFrameTextureFrameName:GetText())
		end

		if FocusFrameTextureFrameTexture then
			hooksecurefunc(
				FocusFrameTextureFrameTexture,
				"SetVertexColor",
				function(self, oR, oG, oB)
					if self.dufsetvertexcolor then return end
					self.dufsetvertexcolor = true
					local r, g, b, isDefault = DUFGetBorderColor("FOCUS", self)
					if r and g and b and not isDefault then
						self:SetVertexColor(r, g, b, 1)
					else
						self:SetVertexColor(oR, oG, oB, 1)
					end

					if self.spacer then
						self.spacer:SetVertexColor(self:GetVertexColor())
					end

					self.dufsetvertexcolor = false
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
				function(self, event, ...)
					if GetInspectSpecialization ~= nil then
						local currentSpec = GetInspectSpecialization("FOCUS")
						f:UnregisterEvent("INSPECT_READY")
						ClearInspectPlayer()
						local id, _, _, icon, _, _ = GetSpecializationInfoByID(currentSpec)
						if id ~= nil and not InCombatLockdown() and DUFGetConfig("showspecs", true) and icon then
							FocusFramePortrait:SetTexture(icon)
							FocusFramePortrait:SetTexCoord(0, 1, 0, 1)
						end
					end
				end
			)
		end
	end

	function DUFUpdateFocusFrame()
		if FocusFrame then
			FocusFrameHealthBar:SetHeight(1)
			FocusFrameManaBar:SetHeight(1)
			FocusFrameManaBar:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
		end
	end
end
