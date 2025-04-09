-- By D4KiR
local _, DUnitFrames = ...
DUFHIDDEN = CreateFrame("FRAME", "DUFHIDDEN", UIParent)
DUFHIDDEN:Hide()
function DUnitFrames:HPHeight()
	local height = DUnitFrames:GetConfig("hpheight", 27)
	if height >= 28 then
		height = 38
	end

	return height
end

function DUnitFrames:DottedNumber(num)
	local revnum = tostring(num):reverse()
	local ret = ""
	for i = 0, strlen(revnum), 4 do
		local first = string.sub(revnum, i, i + 3)
		if first ~= nil then
			if i ~= 0 then
				ret = ret .. "."
			end

			ret = ret .. first
		end
	end

	return ret:reverse()
end

function DUnitFrames:GetDisplayMode()
	return GetCVar("statusTextDisplay")
end

hooksecurefunc(
	"UnitFramePortrait_Update",
	function(self, ...)
		if self.unit == nil or self.portrait == nil then return end
		if DUnitFrames:GetName(self) == "TargetFrameToT" then return end -- IMPORTANT
		if self.dufsetportrai then return end
		self.dufsetportrai = true
		--self.portrait:SetMask( nil )
		if self.mask == nil then
			self.mask = self:CreateMaskTexture()
			self.mask:SetAllPoints(self.portrait)
			self.mask:SetTexture("Interface/CHARACTERFRAME/TempPortraitAlphaMask", "CLAMPTOBLACKADDITIVE", "CLAMPTOBLACKADDITIVE")
			self.portrait:AddMaskTexture(self.mask)
		end

		if UnitIsPlayer(self.unit) then
			local t = CLASS_ICON_TCOORDS[select(2, UnitClass(self.unit))]
			if t then
				if self.unit == "player" then
					if DUnitFrames:GetConfig("portraitmodeself") ~= "Default" then
						if DUnitFrames:GetConfig("portraitmodeself") ~= "Old" then
							self.portrait:SetTexture("Interface\\Addons\\DUnitFrames\\media\\UI-CLASSES-CIRCLES-" .. DUnitFrames:GetConfig("portraitmodeself", "New"))
							self.portrait:SetTexCoord(unpack(t))
						elseif DUnitFrames:GetConfig("portraitmodeself") == "Old" then
							self.portrait:SetTexture("Interface\\Addons\\DUnitFrames\\media\\UI-CLASSES-CIRCLES-OLD")
							self.portrait:SetTexCoord(unpack(t))
						else
							self.portrait:SetTexCoord(0, 1, 0, 1)
						end
					else
						self.portrait:SetTexCoord(0, 1, 0, 1)
					end
				else
					if DUnitFrames:GetConfig("portraitmode") ~= "Default" then
						if DUnitFrames:GetConfig("portraitmode") ~= "Old" then
							self.portrait:SetTexture("Interface\\Addons\\DUnitFrames\\media\\UI-CLASSES-CIRCLES-" .. DUnitFrames:GetConfig("portraitmode", "New"))
							self.portrait:SetTexCoord(unpack(t))
						elseif DUnitFrames:GetConfig("portraitmode") == "Old" then
							self.portrait:SetTexture("Interface\\Addons\\DUnitFrames\\media\\UI-CLASSES-CIRCLES-OLD")
							self.portrait:SetTexCoord(unpack(t))
						else
							self.portrait:SetTexCoord(0, 1, 0, 1)
						end
					else
						self.portrait:SetTexCoord(0, 1, 0, 1)
					end
				end
			else
				self.portrait:SetTexCoord(0, 1, 0, 1)
			end
		else
			self.portrait:SetTexCoord(0, 1, 0, 1)
		end

		if self.unit == "player" and ComboPointPlayerFrame and DUnitFrames:GetConfig("hidecombopoints", false) then
			ComboPointPlayerFrame:SetParent(DUFHIDDEN)
		end

		self.dufsetportrai = false
	end
)

function DUnitFrames:Clamp(va, mi, ma)
	if va < mi then
		va = mi
	elseif va > ma then
		va = ma
	end

	return va
end

local f = CreateFrame("Frame")
PlayerFrame.a = 0
function f.Think()
	if DUnitFrames:GetConfig("hidewhenfull", false) then
		local powernotfull = false
		local manacur = UnitPower("PLAYER", Enum.PowerType.Mana)
		local manamax = UnitPowerMax("PLAYER", Enum.PowerType.Mana)
		if manacur and manacur < manamax then
			powernotfull = true
		end

		local energiecur = UnitPower("PLAYER", Enum.PowerType.Energy)
		local energiemax = UnitPowerMax("PLAYER", Enum.PowerType.Energy)
		if energiecur and energiecur < energiemax then
			powernotfull = true
		end

		if not powernotfull and UnitHealth("PLAYER") >= UnitHealthMax("PLAYER") and not UnitExists("TARGET") and not MouseIsOver(PlayerFrame) then
			PlayerFrame.duf_alpha = PlayerFrame.duf_alpha - 0.05
		else
			PlayerFrame.duf_alpha = PlayerFrame.duf_alpha + 0.05
		end

		PlayerFrame.duf_alpha = DUnitFrames:Clamp(PlayerFrame.duf_alpha, 0, 1)
		PlayerFrame.duf_alpha = DUnitFrames:Clamp(PlayerFrame.duf_alpha, 0, 1)
		PlayerFrame:SetAlpha(PlayerFrame.duf_alpha)
	else
		if PlayerFrame.duf_alpha ~= 1 then
			PlayerFrame.duf_alpha = 1
			PlayerFrame:SetAlpha(1)
		end
	end

	C_Timer.After(0.01, f.Think)
end

f.Think()
