local _, DUnitFrames = ...
local DUFFontSize = 12
function DUFTargetFrameSetup()
	if TargetFrameHealthBar then
		hooksecurefunc(
			TargetFrameHealthBar,
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

		TargetFrameHealthBar:SetStatusBarTexture("")
	end

	if TargetFrameManaBar then
		hooksecurefunc(
			TargetFrameManaBar,
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
			function(self, oR, oG, oB)
				if self.dufsetvertexcolor then return end
				self.dufsetvertexcolor = true
				local r, g, b = DUFGetBarColor("TARGET", self)
				if r and g and b then
					self:SetStatusBarColor(r, g, b)
				else
					self:SetStatusBarColor(oR, oG, oB)
				end

				self.dufsetvertexcolor = false
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
					function(self, text)
						if self.dufsettext then return end
						self.dufsettext = true
						local fontFamily, fontSize, _ = self:GetFont()
						if fontFamily ~= STANDARD_TEXT_FONT or fontSize ~= DUFFontSize then
							self:SetFont(STANDARD_TEXT_FONT, DUFFontSize, DUnitFrames:GetFontFlags())
						end

						local newText = DUFModifyText(text, UnitHealth("TARGET"), UnitHealthMax("TARGET"), "TargetFrameHealthBarTextRight")
						self:SetText(newText)
						self.dufsettext = false
					end
				)

				TargetFrameHealthBarTextRight:SetText(TargetFrameHealthBarTextRight:GetText())
				hooksecurefunc(
					TargetFrameHealthBarTextLeft,
					"SetText",
					function(self, text)
						if self.dufsettext then return end
						self.dufsettext = true
						local fontFamily, fontSize, _ = self:GetFont()
						if fontFamily ~= STANDARD_TEXT_FONT or fontSize ~= DUFFontSize then
							self:SetFont(STANDARD_TEXT_FONT, DUFFontSize, DUnitFrames:GetFontFlags())
						end

						local newText = DUFModifyText(text, UnitHealth("TARGET"), UnitHealthMax("TARGET"), "TargetFrameHealthBarTextLeft")
						self:SetText(newText)
						self.dufsettext = false
					end
				)

				TargetFrameHealthBarTextLeft:SetText(TargetFrameHealthBarTextLeft:GetText())
				hooksecurefunc(
					TargetFrameHealthBarText,
					"SetText",
					function(self, text)
						if self.dufsettext then return end
						self.dufsettext = true
						local fontFamily, fontSize, _ = self:GetFont()
						if fontFamily ~= STANDARD_TEXT_FONT or fontSize ~= DUFFontSize then
							self:SetFont(STANDARD_TEXT_FONT, DUFFontSize, DUnitFrames:GetFontFlags())
						end

						local newText = DUFModifyText(text, UnitHealth("TARGET"), UnitHealthMax("TARGET"), "TargetFrameHealthBarText")
						self:SetText(newText)
						self.dufsettext = false
					end
				)

				TargetFrameHealthBarText:SetText(TargetFrameHealthBarText:GetText())
				hooksecurefunc(
					TargetFrameManaBarTextLeft,
					"SetText",
					function(self, text)
						if self.dufsettext then return end
						self.dufsettext = true
						local fontFamily, fontSize, _ = self:GetFont()
						if fontFamily ~= STANDARD_TEXT_FONT or fontSize ~= DUFFontSize then
							self:SetFont(STANDARD_TEXT_FONT, DUFFontSize, DUnitFrames:GetFontFlags())
						end

						local newText = DUFModifyText(text, UnitPower("TARGET"), UnitPowerMax("TARGET"), "TargetFrameManaBarTextLeft")
						self:SetText(newText)
						self.dufsettext = false
					end
				)

				TargetFrameManaBarTextLeft:SetText(TargetFrameManaBarTextLeft:GetText())
				hooksecurefunc(
					TargetFrameManaBarTextRight,
					"SetText",
					function(self, text)
						if self.dufsettext then return end
						self.dufsettext = true
						local fontFamily, fontSize, _ = self:GetFont()
						if fontFamily ~= STANDARD_TEXT_FONT or fontSize ~= DUFFontSize then
							self:SetFont(STANDARD_TEXT_FONT, DUFFontSize, DUnitFrames:GetFontFlags())
						end

						local newText = DUFModifyText(text, UnitPower("TARGET"), UnitPowerMax("TARGET"), "TargetFrameManaBarTextRight")
						self:SetText(newText)
						self.dufsettext = false
					end
				)

				TargetFrameManaBarTextRight:SetText(TargetFrameManaBarTextRight:GetText())
				hooksecurefunc(
					TargetFrameManaBarText,
					"SetText",
					function(self, text)
						if self.dufsettext then return end
						self.dufsettext = true
						local fontFamily, fontSize, _ = self:GetFont()
						if fontFamily ~= STANDARD_TEXT_FONT or fontSize ~= DUFFontSize then
							self:SetFont(STANDARD_TEXT_FONT, DUFFontSize, DUnitFrames:GetFontFlags())
						end

						local newText = DUFModifyText(text, UnitPower("TARGET"), UnitPowerMax("TARGET"), "TargetFrameManaBarText")
						self:SetText(newText)
						self.dufsettext = false
					end
				)

				TargetFrameManaBarText:SetText(TargetFrameManaBarText:GetText())
			end

			if TargetFrameTextureFrameHealthBarTextLeft ~= nil and TargetFrameTextureFrameHealthBarTextLeft.hooked == nil then
				TargetFrameTextureFrameHealthBarTextLeft.hooked = true
				hooksecurefunc(
					TargetFrameTextureFrameHealthBarTextLeft,
					"SetText",
					function(self, text)
						if self.dufsettext then return end
						self.dufsettext = true
						local fontFamily, fontSize, _ = self:GetFont()
						if fontFamily ~= STANDARD_TEXT_FONT or fontSize ~= DUFFontSize then
							self:SetFont(STANDARD_TEXT_FONT, DUFFontSize, DUnitFrames:GetFontFlags())
						end

						local newText = DUFModifyText(text, UnitHealth("TARGET"), UnitHealthMax("TARGET"), "TargetFrameTextureFrameHealthBarTextLeft")
						self:SetText(newText)
						self.dufsettext = false
					end
				)

				TargetFrameTextureFrameHealthBarTextLeft:SetText(TargetFrameTextureFrameHealthBarTextLeft:GetText())
				hooksecurefunc(
					TargetFrameTextureFrameHealthBarTextRight,
					"SetText",
					function(self, text)
						if self.dufsettext then return end
						self.dufsettext = true
						local fontFamily, fontSize, _ = self:GetFont()
						if fontFamily ~= STANDARD_TEXT_FONT or fontSize ~= DUFFontSize then
							self:SetFont(STANDARD_TEXT_FONT, DUFFontSize, DUnitFrames:GetFontFlags())
						end

						local newText = DUFModifyText(text, UnitHealth("TARGET"), UnitHealthMax("TARGET"), "TargetFrameTextureFrameHealthBarTextRight")
						self:SetText(newText)
						self.dufsettext = false
					end
				)

				TargetFrameTextureFrameHealthBarTextRight:SetText(TargetFrameTextureFrameHealthBarTextRight:GetText())
				hooksecurefunc(
					TargetFrameTextureFrameHealthBarText,
					"SetText",
					function(self, text)
						if self.dufsettext then return end
						self.dufsettext = true
						local fontFamily, fontSize, _ = self:GetFont()
						if fontFamily ~= STANDARD_TEXT_FONT or fontSize ~= DUFFontSize then
							self:SetFont(STANDARD_TEXT_FONT, DUFFontSize, DUnitFrames:GetFontFlags())
						end

						local newText = DUFModifyText(text, UnitHealth("TARGET"), UnitHealthMax("TARGET"), "TargetFrameTextureFrameHealthBarText")
						self:SetText(newText)
						self.dufsettext = false
					end
				)

				TargetFrameTextureFrameHealthBarText:SetText(TargetFrameTextureFrameHealthBarText:GetText())
				hooksecurefunc(
					TargetFrameTextureFrameManaBarTextLeft,
					"SetText",
					function(self, text)
						if self.dufsettext then return end
						self.dufsettext = true
						local fontFamily, fontSize, _ = self:GetFont()
						if fontFamily ~= STANDARD_TEXT_FONT or fontSize ~= DUFFontSize then
							self:SetFont(STANDARD_TEXT_FONT, DUFFontSize, DUnitFrames:GetFontFlags())
						end

						local newText = DUFModifyText(text, UnitPower("TARGET"), UnitPowerMax("TARGET"), "TargetFrameTextureFrameManaBarTextLeft")
						self:SetText(newText)
						self.dufsettext = false
					end
				)

				TargetFrameTextureFrameManaBarTextLeft:SetText(TargetFrameTextureFrameManaBarTextLeft:GetText())
				hooksecurefunc(
					TargetFrameTextureFrameManaBarTextRight,
					"SetText",
					function(self, text)
						if self.dufsettext then return end
						self.dufsettext = true
						local fontFamily, fontSize, _ = self:GetFont()
						if fontFamily ~= STANDARD_TEXT_FONT or fontSize ~= DUFFontSize then
							self:SetFont(STANDARD_TEXT_FONT, DUFFontSize, DUnitFrames:GetFontFlags())
						end

						local newText = DUFModifyText(text, UnitPower("TARGET"), UnitPowerMax("TARGET"), "TargetFrameTextureFrameManaBarTextRight")
						self:SetText(newText)
						self.dufsettext = false
					end
				)

				TargetFrameTextureFrameManaBarTextRight:SetText(TargetFrameTextureFrameManaBarTextRight:GetText())
				hooksecurefunc(
					TargetFrameTextureFrameManaBarText,
					"SetText",
					function(self, text)
						if self.dufsettext then return end
						self.dufsettext = true
						local fontFamily, fontSize, _ = self:GetFont()
						if fontFamily ~= STANDARD_TEXT_FONT or fontSize ~= DUFFontSize then
							self:SetFont(STANDARD_TEXT_FONT, DUFFontSize, DUnitFrames:GetFontFlags())
						end

						local newText = DUFModifyText(text, UnitPower("TARGET"), UnitPowerMax("TARGET"), "TargetFrameTextureFrameManaBarText")
						self:SetText(newText)
						self.dufsettext = false
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
			function(self)
				if self.dufsetheight then return end
				self.dufsetheight = true
				self:SetHeight(DUFHPHeight())
				self.dufsetheight = false
			end
		)

		TargetFrameHealthBar:SetHeight(27)
		hooksecurefunc(
			TargetFrameHealthBar,
			"SetSize",
			function(self)
				if self.dufsetsize then return end
				self.dufsetsize = true
				self:SetHeight(DUFHPHeight())
				self.dufsetsize = false
			end
		)

		hooksecurefunc(
			TargetFrameHealthBar,
			"SetPoint",
			function(self)
				if self.dufsetpoint then return end
				self.dufsetpoint = true
				self:SetPoint("TOPLEFT", 6, -24)
				self.dufsetpoint = false
			end
		)

		TargetFrameHealthBar:SetPoint("TOPLEFT", 6, -24)
	end

	if TargetFrameManaBar then
		hooksecurefunc(
			TargetFrameManaBar,
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

		TargetFrameManaBar:SetHeight(27)
		hooksecurefunc(
			TargetFrameManaBar,
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
			TargetFrameManaBar,
			"SetPoint",
			function(self)
				if self.dufsetpoint then return end
				self.dufsetpoint = true
				self:SetPoint("TOPLEFT", 6, -23 - DUFHPHeight() - 1)
				self.dufsetpoint = false
			end
		)

		TargetFrameManaBar:SetPoint("TOPLEFT", 6, -24)
	end

	if TargetFrameBackground then
		TargetFrameBackground:SetHeight(40)
		TargetFrameBackground:ClearAllPoints()
		TargetFrameBackground:SetPoint("TOPLEFT", 6, -24)
	end

	if TargetFrameNameBackground then
		TargetFrameNameBackground:SetParent(DUFHIDDEN)
	end

	function DUFUpdateTargetTexture()
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
				function(self, r, g, b, a)
					if self.dufsetvertexcolor then return end
					self.dufsetvertexcolor = true
					self:SetVertexColor(r, g, b, a)
					self.dufsetvertexcolor = false
				end
			)

			TargetFrameTextureFrameTexture.spacer:SetVertexColor(1, 1, 1)
		end

		TargetFrameTextureFrameTexture.spacer:SetSize(128, 16)
		TargetFrameTextureFrameTexture.spacer:SetPoint("LEFT", TargetFrameTextureFrameTexture, "LEFT", 4, 21 - DUFHPHeight())
		TargetFrameTextureFrameTexture.spacer:SetTexture("Interface\\Addons\\DUnitFrames\\media\\UI-TargetingFrame" .. "_Spacer")
		if DUFHPHeight() >= 32 then
			TargetFrameTextureFrameTexture.spacer:Hide()
		else
			TargetFrameTextureFrameTexture.spacer:Show()
		end

		TargetFrameTextureFrameTexture:SetVertexColor(TargetFrameTextureFrameTexture:GetVertexColor())
		TargetFrameTextureFrameDeadText:ClearAllPoints()
		TargetFrameTextureFrameDeadText:SetPoint("CENTER", TargetFrameHealthBar, "CENTER", 0, 0)
		if DUFGetConfig("namemode", "Over Portrait") == "Inside Health" then
			TargetFrameTextureFrameDeadText:ClearAllPoints()
			TargetFrameTextureFrameDeadText:SetPoint("BOTTOM", TargetFrameHealthBar, "BOTTOM", 0, 0)
		end

		if TargetFrameHealthBarTextLeft ~= nil then
			if DUFGetConfig("namemode", "Over Portrait") == "Inside Health" then
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
					function(self, ...)
						if DUFHPHeight() >= 32 then
							self:Hide()
						end
					end
				)
			end

			if not TargetFrameManaBarTextRight.hooked then
				TargetFrameManaBarTextRight.hooked = true
				hooksecurefunc(
					TargetFrameManaBarTextRight,
					"Show",
					function(self, ...)
						if DUFHPHeight() >= 32 then
							self:Hide()
						end
					end
				)
			end

			if not TargetFrameManaBarText.hooked then
				TargetFrameManaBarText.hooked = true
				hooksecurefunc(
					TargetFrameManaBarText,
					"Show",
					function(self, ...)
						if DUFHPHeight() >= 32 then
							self:Hide()
						end
					end
				)
			end

			TargetFrameManaBarTextLeft:ClearAllPoints()
			TargetFrameManaBarTextLeft:SetPoint("LEFT", TargetFrameManaBar, "LEFT", 2, -2)
			TargetFrameManaBarTextRight:ClearAllPoints()
			TargetFrameManaBarTextRight:SetPoint("RIGHT", TargetFrameManaBar, "RIGHT", -3, -2)
			TargetFrameManaBarText:ClearAllPoints()
			TargetFrameManaBarText:SetPoint("CENTER", TargetFrameManaBar, "CENTER", 0, -2)
		elseif TargetFrameTextureFrameHealthBarTextLeft ~= nil then
			TargetFrameTextureFrameHealthBarTextLeft:ClearAllPoints()
			TargetFrameTextureFrameHealthBarTextLeft:SetPoint("LEFT", TargetFrameHealthBar, "LEFT", 2, 0)
			TargetFrameTextureFrameHealthBarTextRight:ClearAllPoints()
			TargetFrameTextureFrameHealthBarTextRight:SetPoint("RIGHT", TargetFrameHealthBar, "RIGHT", -3, 0)
			TargetFrameTextureFrameHealthBarText:ClearAllPoints()
			TargetFrameTextureFrameHealthBarText:SetPoint("CENTER", TargetFrameHealthBar, "CENTER", 0, 0)
			if DUFGetConfig("namemode", "Over Portrait") == "Inside Health" then
				TargetFrameTextureFrameHealthBarTextLeft:ClearAllPoints()
				TargetFrameTextureFrameHealthBarTextLeft:SetPoint("BOTTOMLEFT", TargetFrameHealthBar, "BOTTOMLEFT", 2, 2)
				TargetFrameTextureFrameHealthBarTextRight:ClearAllPoints()
				TargetFrameTextureFrameHealthBarTextRight:SetPoint("BOTTOMRIGHT", TargetFrameHealthBar, "BOTTOMRIGHT", -3, 2)
				TargetFrameTextureFrameHealthBarText:ClearAllPoints()
				TargetFrameTextureFrameHealthBarText:SetPoint("BOTTOM", TargetFrameHealthBar, "BOTTOM", 0, 2)
			end

			if not TargetFrameTextureFrameManaBarTextLeft.hooked then
				TargetFrameTextureFrameManaBarTextLeft.hooked = true
				hooksecurefunc(
					TargetFrameTextureFrameManaBarTextLeft,
					"Show",
					function(self, ...)
						if DUFHPHeight() >= 32 then
							self:Hide()
						end
					end
				)
			end

			if not TargetFrameTextureFrameManaBarTextRight.hooked then
				TargetFrameTextureFrameManaBarTextRight.hooked = true
				hooksecurefunc(
					TargetFrameTextureFrameManaBarTextRight,
					"Show",
					function(self, ...)
						if DUFHPHeight() >= 32 then
							self:Hide()
						end
					end
				)
			end

			if not TargetFrameTextureFrameManaBarText.hooked then
				TargetFrameTextureFrameManaBarText.hooked = true
				hooksecurefunc(
					TargetFrameTextureFrameManaBarText,
					"Show",
					function(self, ...)
						if DUFHPHeight() >= 32 then
							self:Hide()
						end
					end
				)
			end

			TargetFrameTextureFrameManaBarTextLeft:ClearAllPoints()
			TargetFrameTextureFrameManaBarTextLeft:SetPoint("LEFT", TargetFrameManaBar, "LEFT", 2, -1)
			TargetFrameTextureFrameManaBarTextRight:ClearAllPoints()
			TargetFrameTextureFrameManaBarTextRight:SetPoint("RIGHT", TargetFrameManaBar, "RIGHT", -3, -1)
			TargetFrameTextureFrameManaBarText:ClearAllPoints()
			TargetFrameTextureFrameManaBarText:SetPoint("CENTER", TargetFrameManaBar, "CENTER", 0, 0)
			if DUFGetConfig("namemode", "Over Portrait") == "Inside Health" then
				TargetFrameTextureFrameManaBarTextLeft:ClearAllPoints()
				TargetFrameTextureFrameManaBarTextLeft:SetPoint("BOTTOMLEFT", TargetFrameManaBar, "BOTTOMLEFT", 2, 2)
				TargetFrameTextureFrameManaBarTextRight:ClearAllPoints()
				TargetFrameTextureFrameManaBarTextRight:SetPoint("BOTTOMRIGHT", TargetFrameManaBar, "BOTTOMRIGHT", -3, 2)
				TargetFrameTextureFrameManaBarText:ClearAllPoints()
				TargetFrameTextureFrameManaBarText:SetPoint("BOTTOM", TargetFrameManaBar, "BOTTOM", 0, 2)
			end
		end

		if CanInspect and GetInspectSpecialization then
			InspectTargetSpec()
		end
	end

	local ThreatBorder = nil
	if TargetFrameNumericalThreat ~= nil then
		ThreatBorder = select(3, {TargetFrameNumericalThreat:GetRegions()})
	end

	function TargetFrame.Think()
		if TargetFrameTextureFrameName then
			TargetFrameTextureFrameName:ClearAllPoints()
			if TargetFrame.buffsOnTop then
				local y = -4
				if DUFGetConfig("namemode", "Over Portrait") == "Over Health" then
					TargetFrameTextureFrameName:SetPoint("TOP", TargetFrameManaBar, "BOTTOM", 0, y)
				end
			else
				local y = 6
				if DUFGetConfig("namemode", "Over Portrait") == "Over Health" then
					TargetFrameTextureFrameName:SetPoint("BOTTOM", TargetFrameHealthBar, "TOP", 0, y)
				end
			end

			if DUFGetConfig("namemode", "Over Portrait") == "Over Portrait" then
				TargetFrameTextureFrameName:SetPoint("BOTTOM", TargetFramePortrait, "TOP", 0, 12)
			end

			if DUFGetConfig("namemode", "Over Portrait") == "Inside Health" then
				TargetFrameTextureFrameName:ClearAllPoints()
				TargetFrameTextureFrameName:SetPoint("TOP", TargetFrameHealthBar, "TOP", 0, -1)
			end
		end

		if ThreatBorder and ThreatBorder:IsShown() then
			y = 24
			local r, g, b, isDefault = DUFGetBorderColor("TARGET", TargetFrame)
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
			if DUFGetConfig("namemode") == "Over Health" then
				TargetFrame.DUFThreat:SetPoint("BOTTOM", TargetFrameHealthBar, "TOP", 0, 20)
			else
				TargetFrame.DUFThreat:SetPoint("BOTTOM", TargetFrameHealthBar, "TOP", 0, 6)
			end

			if threatpct == nil then
				threatpct = 0
			end

			if threatpct > 0 and DUFGetConfig("showthreat", true) then
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

		TargetFrameTextureFrameName:SetText(TargetFrameTextureFrameName:GetText())
	end

	if TargetFrameTextureFrameTexture then
		hooksecurefunc(
			TargetFrameTextureFrameTexture,
			"SetVertexColor",
			function(self, oR, oG, oB)
				if self.dufsetvertexcolor then return end
				self.dufsetvertexcolor = true
				local r, g, b, isDefault = DUFGetBorderColor("TARGET", self)
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

		TargetFrameTextureFrameTexture:SetVertexColor(TargetFrameTextureFrameTexture:GetVertexColor())
	end

	if TargetFrameToTTextureFrameTexture then
		hooksecurefunc(
			TargetFrameToTTextureFrameTexture,
			"SetVertexColor",
			function(self, oR, oG, oB)
				if self.dufsetvertexcolor then return end
				self.dufsetvertexcolor = true
				local r, g, b, isDefault = DUFGetBorderColor("TARGETTARGET", self)
				if r and g and b and not isDefault then
					self:SetVertexColor(r, g, b, 1)
				else
					self:SetVertexColor(oR, oG, oB, 1)
				end

				self.dufsetvertexcolor = false
			end
		)

		TargetFrameToTTextureFrameTexture:SetVertexColor(1, 1, 1)
		function TargetFrameToT.Think()
			TargetFrameToTTextureFrameTexture:SetVertexColor(1, 1, 1)
			C_Timer.After(0.1, TargetFrameToT.Think)
		end

		TargetFrameToT.Think()
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
			function(self, event, ...)
				if GetInspectSpecialization ~= nil then
					local currentSpec = GetInspectSpecialization("TARGET")
					f:UnregisterEvent("INSPECT_READY")
					ClearInspectPlayer()
					local id, _, _, icon, _, _ = GetSpecializationInfoByID(currentSpec)
					if id ~= nil and not InCombatLockdown() and DUFGetConfig("showspecs", true) and icon then
						TargetFramePortrait:SetTexture(icon)
						TargetFramePortrait:SetTexCoord(0, 1, 0, 1)
					end
				end
			end
		)
	end
end

function DUFUpdateTargetFrame()
	TargetFrameManaBar:ClearAllPoints()
	TargetFrameManaBar:SetPoint("CENTER", TargetFrame, "CENTER", 0, 0)
	TargetFrameHealthBar:SetHeight(1)
	TargetFrameManaBar:SetHeight(1)
end
