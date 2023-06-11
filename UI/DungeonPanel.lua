-------------------------------------------------------------------------------
-- Premade Groups Filter
-------------------------------------------------------------------------------
-- Copyright (C) 2022 Elotheon-Arthas-EU
--
-- This program is free software; you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation; either version 2 of the License, or
-- (at your option) any later version.
--
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
--
-- You should have received a copy of the GNU General Public License along
-- with this program; if not, write to the Free Software Foundation, Inc.,
-- 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-------------------------------------------------------------------------------

local PGF = select(2, ...)
local L = PGF.L
local C = PGF.C

local DIFFICULTY_TEXT = {
    [1] = { key = C.NORMAL,     title = L["dialog.normal"] },
    [2] = { key = C.HEROIC,     title = L["dialog.heroic"] },
    [3] = { key = C.MYTHIC,     title = L["dialog.mythic"] },
    [4] = { key = C.MYTHICPLUS, title = L["dialog.mythicplus"] },
}

local SEASON_DUNGEONS = {
    [1] = { activityId = 1164, keyword = "bh" },   -- Brackenhide Hollow
    [2] = { activityId = 1168, keyword = "hoi" },  -- Halls of Infusion
    [3] = { activityId = 1172, keyword = "nelt" }, -- Neltharus
    [4] = { activityId = 1188, keyword = "uld" },  -- Uldaman: Legacy of Tyr
    [5] = { activityId = 518,  keyword = "fh" },   -- Freehold
    [6] = { activityId = 462,  keyword = "nl" },   -- Neltharion's Lair
    [7] = { activityId = 507,  keyword = "undr" }, -- The Underrot
    [8] = { activityId = 1195, keyword = "vp" },   -- Vortex Pinnacle
    -- note that there are currently one 8 checkboxes available in the xml file
}

local DungeonPanel = CreateFrame("Frame", "PremadeGroupsFilterDungeonPanel", PGF.Dialog, "PremadeGroupsFilterDungeonPanelTemplate")

function DungeonPanel:OnLoad()
    PGF.Logger:Debug("DungeonPanel:OnLoad")
    self.name = "dungeon"

    -- Group
    self.Group.Title:SetText(L["dialog.filters.group"])
    PGF.UI_SetupDropDown(self, self.Group.Difficulty, "DungeonDifficultyMenu", L["dialog.difficulty"], DIFFICULTY_TEXT)
    PGF.UI_SetupMinMaxField(self, self.Group.MPRating, "mprating")
    PGF.UI_SetupCheckBox(self, self.Group.Partyfit, "partyfit", true)
    PGF.UI_SetupCheckBox(self, self.Group.NotDeclined, "notdeclined", true)
    PGF.UI_SetupCheckBox(self, self.Group.BLFit, "blfit", true)
    PGF.UI_SetupCheckBox(self, self.Group.BRFit, "brfit", true)
    PGF.UI_SetupAdvancedExpression(self)

    -- Dungeons
    self.Dungeons.Title:SetText(L["dialog.filters.dungeons"])
    self.Dungeons.Alert.Icon:SetTexture("Interface\\DialogFrame\\UI-Dialog-Icon-AlertNew")
    self.Dungeons.Alert:SetScript("OnEnter", function (self)
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:SetText(L["dialog.dungeon.alert.single.title"], nil, nil, nil, nil, true)
        GameTooltip:AddLine(L["dialog.dungeon.alert.single.info"], 1, 1, 1, 1, true)
        GameTooltip:Show()
    end)
    self.Dungeons.Alert:SetScript("OnLeave", function(self)
        GameTooltip:Hide()
    end)
    for i = 1, #SEASON_DUNGEONS do
        local dungeonName = C_LFGList.GetActivityInfoTable(SEASON_DUNGEONS[i].activityId).fullName
        self.Dungeons["Dungeon"..i]:SetWidth(290/2)
        self.Dungeons["Dungeon"..i].Title:SetText(dungeonName)
        self.Dungeons["Dungeon"..i].Title:SetWidth(100)
        self.Dungeons["Dungeon"..i].Act:SetScript("OnClick", function(element)
            self.state["dungeon" .. i] = element:GetChecked()
            self:ToogleDungeonAlert()
            self:TriggerFilterExpressionChange()
        end)
    end
end

function DungeonPanel:Init(state)
    PGF.Logger:Debug("Dungeonpanel:Init")
    self.state = state
    self.state.difficulty = self.state.difficulty or {}
    self.state.mprating = self.state.mprating or {}
    self.state.expression = self.state.expression or ""

    self.Group.Difficulty.Act:SetChecked(self.state.difficulty.act or false)
    self.Group.Difficulty.DropDown:SetKey(self.state.difficulty.val)
    self.Group.MPRating.Act:SetChecked(self.state.mprating.act or false)
    self.Group.MPRating.Min:SetText(self.state.mprating.min or "")
    self.Group.MPRating.Max:SetText(self.state.mprating.max or "")

    self.Group.Partyfit.Act:SetChecked(self.state.partyfit or false)
    self.Group.NotDeclined.Act:SetChecked(self.state.notdeclined or false)
    self.Group.BLFit.Act:SetChecked(self.state.blfit or false)
    self.Group.BRFit.Act:SetChecked(self.state.brfit or false)

    for i = 1, #SEASON_DUNGEONS do
        self.Dungeons["Dungeon"..i].Act:SetChecked(self.state["dungeon"..i] or false)
    end
    self.Advanced.Expression.EditBox:SetText(self.state.expression or "")
    self:ToogleDungeonAlert()
end

function DungeonPanel:OnShow()
    PGF.Logger:Debug("DungeonPanel:OnShow")
end

function DungeonPanel:OnHide()
    PGF.Logger:Debug("DungeonPanel:OnHide")
end

function DungeonPanel:OnReset()
    PGF.Logger:Debug("DungeonPanel:OnReset")
    self.state.difficulty.act = false
    self.state.mprating.act = false
    self.state.mprating.min = ""
    self.state.mprating.max = ""
    self.state.partyfit = false
    self.state.notdeclined = false
    self.state.blfit = false
    self.state.brfit = false
    for i = 1, #SEASON_DUNGEONS do
        self.state["dungeon"..i] = false
    end
    self.state.expression = ""
    self:TriggerFilterExpressionChange()
    self:Init(self.state)
end

function DungeonPanel:OnUpdateExpression(expression, sorting)
    PGF.Logger:Debug("DungeonPanel:OnUpdateExpression")
    self.state.expression = expression
    self:Init(self.state)
end

function DungeonPanel:TriggerFilterExpressionChange()
    PGF.Logger:Debug("DungeonPanel:TriggerFilterExpressionChange")
    local expression = self:GetFilterExpression()
    local hint = expression == "true" and "" or expression
    self.Advanced.Expression.EditBox.Instructions:SetText(hint)
    PGF.Dialog:OnFilterExpressionChanged()
end

function DungeonPanel:GetFilterExpression()
    PGF.Logger:Debug("DungeonPanel:GetFilterExpression")
    local expression = "true" -- start with neutral element of logical and
    if self.state.difficulty.act then expression = expression .. " and " .. C.DIFFICULTY_KEYWORD[self.state.difficulty.val] end
    if self.state.mprating.act then
        if PGF.NotEmpty(self.state.mprating.min) then expression = expression .. " and mprating >= " .. self.state.mprating.min end
        if PGF.NotEmpty(self.state.mprating.max) then expression = expression .. " and mprating <= " .. self.state.mprating.max end
    end
    if self.state.partyfit    then expression = expression .. " and partyfit"     end
    if self.state.blfit       then expression = expression .. " and blfit"        end
    if self.state.brfit       then expression = expression .. " and brfit"        end
    if self.state.notdeclined then expression = expression .. " and not declined" end

    if self:GetNumDungeonsSelected() > 0 then
        expression = expression .. " and ( false" -- start with neutral element of logical or
        for i = 1, #SEASON_DUNGEONS do
            if self.state["dungeon"..i] then expression = expression .. " or " .. SEASON_DUNGEONS[i].keyword end
        end
        expression = expression .. " )"
        expression = expression:gsub("false or ", "")
    end

    if PGF.NotEmpty(self.state.expression) then
        local userExp = PGF.RemoveCommentLines(self.state.expression)
        expression = expression .. " and ( " .. userExp .. " )"
    end
    expression = expression:gsub("^true and ", "")
    return expression
end

function DungeonPanel:GetSortingExpression()
    return nil
end

function DungeonPanel:GetNumDungeonsSelected()
    local numDungeonsSelected = 0
    for i = 1, #SEASON_DUNGEONS do
        if self.state["dungeon"..i] then
            numDungeonsSelected = numDungeonsSelected + 1
        end
    end
    return numDungeonsSelected
end

function DungeonPanel:ToogleDungeonAlert()
    PGF.Logger:Debug("DungeonPanel:ToogleDungeonAlert")
    if self:GetNumDungeonsSelected() == 1 then
        self.Dungeons.Alert:Show()
    else
        self.Dungeons.Alert:Hide()
    end
end

DungeonPanel:OnLoad()
PGF.Dialog:RegisterPanel("c2f4", DungeonPanel)