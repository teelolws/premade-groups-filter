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

if GetLocale() ~= "zhTW" then return end

L["addon.name.short"] = "過濾選項"
L["addon.name.long"] = "預組隊伍過濾"

L["error.syntax"] = "|cffff0000過濾語法錯誤|r\n\n表示過濾語法不正確，例如缺少過濾條件、變數或運算符號，或是寫成 'tanks=1' 而不是 'tanks==1'。\n\n詳細錯誤訊息：\n|cffaaaaaa%s|r"
L["error.semantic"] = "|cffff0000過濾語法的語意錯誤|r\n\n表示過濾語法正確，但是很可能變數寫錯字，例如寫成 tansk 而不是 tanks。\n\n詳細錯誤訊息：\n|cffaaaaaa%s|r"
L["error.semantic.protected"] = "|cffff0000過濾語法的語意錯誤|r\n\n不再支持關鍵字 'name'，'comment' 和 'findnumber'。 請從高級過濾器表達式中刪除它們或按重置按鈕。\n\n從戰鬥艾澤拉斯準備開始，這些價值現在受到暴雪的保護，任何插件都無法讀取。\n\n使用組列表上方的默認搜索欄過濾組名稱。\n\n詳細錯誤訊息：\n|cffaaaaaa%s|r"
L["message.noplaystylefix"] = "預組隊伍過濾: Will not apply fix for 'Interface action failed because of an AddOn' errors because you don't seem to have a fully secured account and otherwise can't create premade groups. See addon FAQ for more information and how to fix this issue."
L["message.settingsupgraded"] = "預組隊伍過濾: 設置遷移到版本 %s"

L["dialog.reset"] = "重置"
L["dialog.reset.confirm"] = "真的重置所有字段？"
L["dialog.refresh"] = "搜尋"
L["dialog.expl.simple"] = "勾選選項，輸入最大值和(或)最小值，然後按下搜尋。"
L["dialog.expl.state"] = "隊伍必須包含："
L["dialog.expl.min"] = "最小"
L["dialog.expl.max"] = "最大"
L["dialog.expl.advanced"] = "如果上方的選項不夠用，可以使用進階語法來查詢。"
L["dialog.normal"] = "普通"
L["dialog.heroic"] = "英雄"
L["dialog.mythic"] = "傳奇"
L["dialog.mythicplus"] = "傳奇+"
L["dialog.to"] = "～"
L["dialog.difficulty"] = "難度 ............................"
L["dialog.members"]    = "成員人數 ........................"
L["dialog.tanks"]      = "坦克 ............................"
L["dialog.heals"]      = "治療 ............................"
L["dialog.dps"]        = "輸出 ............................"
L["dialog.mprating"]   = "Mythic+ Rating ................."
L["dialog.pvprating"]  = "PVP Rating ....................."
L["dialog.defeated"]   = "已擊殺首領(團隊)"
L["dialog.sorting"] = "排序"
L["dialog.usepgf.tooltip"] = "啟用或停用預組隊伍過濾"
L["dialog.tooltip.title"] = "進階過濾語法"
L["dialog.tooltip.variable"] = "變數"
L["dialog.tooltip.description"] = "說明"
L["dialog.tooltip.op.logic"] = "邏輯運算符號"
L["dialog.tooltip.op.number"] = "數字運算符號"
L["dialog.tooltip.op.string"] = "文字運算符號"
L["dialog.tooltip.op.func"] = "函數"
L["dialog.tooltip.example"] = "範例"
L["dialog.tooltip.ilvl"] = "需要的裝備等級"
L["dialog.tooltip.myilvl"] = "我的物品等級"
L["dialog.tooltip.hlvl"] = "需要的榮譽等級"
L["dialog.tooltip.pvprating"] = "組長的PvP評分"
L["dialog.tooltip.mprating"] = "組長的神話加上評級"
L["dialog.tooltip.defeated"] = "已擊殺的首領數量"
L["dialog.tooltip.members"] = "成員人數"
L["dialog.tooltip.tanks"] = "坦克人數"
L["dialog.tooltip.heals"] = "治療人數"
L["dialog.tooltip.dps"] = "傷害輸出人數"
L["dialog.tooltip.partyfit"] = "我的團隊角色有一席之地"
L["dialog.tooltip.classes"] = "指定的職業人數"
L["dialog.tooltip.age"] = "幾分鐘前建立的"
L["dialog.tooltip.voice"] = "有語音"
L["dialog.tooltip.myrealm"] = "隊長和我是同一個伺服器群組"
L["dialog.tooltip.noid"] = "我還沒有進度的副本"
L["dialog.tooltip.matchingid"] = "該集團殺死了與我同樣的領導人"
L["dialog.tooltip.seewebsite"] = "詳見公司網站"
L["dialog.tooltip.difficulty"] = "難度"
L["dialog.tooltip.raids"] = "選擇指定的團隊"
L["dialog.tooltip.dungeons"] = "選擇指定的地城"
L["dialog.tooltip.timewalking"] = "選擇時間行走地牢"
L["dialog.tooltip.arena"] = "選擇指定的競技場類型"
L["dialog.tooltip.warmode"] = "warmode enabled"
L["dialog.tooltip.ex.parentheses"] = "（voice or not voice）"
L["dialog.tooltip.ex.not"] = "not myrealm"
L["dialog.tooltip.ex.and"] = "heroic and hfc"
L["dialog.tooltip.ex.or"] = "normal or heroic"
L["dialog.tooltip.ex.eq"] = "dps == 3"
L["dialog.tooltip.ex.neq"] = "members ~= 0"
L["dialog.tooltip.ex.lt"] = "hlvl >= 5"
L["dialog.tooltip.ex.find"] = "not name:find(\"wts\")"
L["dialog.tooltip.ex.match"] = "name:match(\"+(%d)\")==\"5\""
L["dialog.copy.url.keywords"] = "按 CTRL+C 將鏈接複製到關鍵字列表"

L["settings.dialogMovable.title"] = "可移動的對話框"
L["settings.dialogMovable.tooltip"] = "允許您使用鼠標移動對話框。 右鍵單擊重置位置。"
L["settings.classNamesInTooltip.title"] = "工具提示中的類名"
L["settings.classNamesInTooltip.tooltip"] = "在預製組的工具提示中按角色顯示類列表。"
L["settings.coloredGroupTexts.title"] = "彩色組名稱和活動"
L["settings.coloredGroupTexts.tooltip"] = "如果群組是新的，則以綠色顯示群組名稱，如果您之前被拒絕，則以紅色顯示。 如果您對該實例進行了鎖定，則以紅色顯示活動名稱。"
L["settings.leaderCrown.title"] = "顯示組長"
L["settings.leaderCrown.tooltip"] = "在預製地牢組列表中組長角色上方顯示一個小皇冠。"
L["settings.ratingInfo.title"] = "組長評分"
L["settings.ratingInfo.tooltip"] = "在預製組列表中顯示組長的 Mythic+ 或 PvP 等級。"
