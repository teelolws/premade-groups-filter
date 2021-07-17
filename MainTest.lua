time = function () return 1 end
hooksecurefunc = function () end
StaticPopupDialogs = {}
StaticPopup_Show = function () end
CreateFrame = function () return {
    RegisterEvent = function () end,
    SetScript = function () end,
} end
PVEFrame = {}
LFGListFrame = { SearchPanel = {}, CategorySelection = {} }
GetAverageItemLevel = function () return 410 end
GetNumGroupMembers = function () return 3 end
UnitGroupRolesAssigned = function (unit)
    if unit == "player" then return "TANK" end
    if unit == "party0" then return "HEALER" end
    return "DAMAGER"
end
C_LFGList = {
    GetSearchResultInfo = function (resultID) return {
        activitInfo = 123,
        age = 120,
        numMembers = 1*resultID,
        numBNetFriends = 0,
        numCharFriends = 0,
        numGuildMates = 1,
        voiceChat = true,
        requiredItemLevel = 400,
    } end,
    GetSearchResultMemberInfo = function (resultID, i)
        if i == 0 then return "DAMAGER", "MAGE" end
        return "DAMAGER", "HUNTER"
    end,
    GetSearchResultMemberCounts = function (resultID) return {
        TANK = 0,
        HEALER = 0,
        DAMAGER = 2,
        NOROLE = 0,
        TANK_REMAINING = 1,
        HEALER_REMAINING = 1,
        DAMAGER_REMAINING = 1
    } end,
    GetActivityInfo = function (activityID) return "", "", 1, 2, 3, nil, 4, 5, nil, 6, false, true end,
    GetSearchResultEncounterInfo = function (resultID) return nil end,
}

local PGF = {}
loadfile("Init.lua")("PGF", PGF)
loadfile("Modules/Expression.lua")("PGF", PGF)
loadfile("Main.lua")("PGF", PGF)
PGF.GetModel = function () return { enabled = true } end
PGF.GetLockoutInfo = function () return 1, 2, 7, 1, 3, 4 end
PGF.GetDifficulty = function () return 1 end


local testName = "Should filter by member count"
local results = { 1, 2, 3 }
PGF.GetExpressionFromModel = function () return "members==2" end
res = PGF.DoFilterSearchResults(results)
if not res then
    print("ERROR "..testName)
    print("-> Expected filtering result to be true, but was false")
elseif #results ~= 1 then
    print("ERROR "..testName)
    print("-> Expected #results to be 1, but was "..#results)
else
    print("OK    "..testName)
end

