-- Fake Item Links by Vildiesel EU-Well of Eternity

local tsort, lower, tinsert = table.sort, string.lower, table.insert

local addonName, addonTable = ...

local L = addonTable.L
local ng

local empty_text = "|cff00ffff"..EMPTY.."|r"
local mf, edt, resultLink, left_tooltip, right_tooltip
local C, DD, DB -- constants, dropdowns and utils
local ilvl_buttons_backdrop = { bgFile = "" }
local theme = {
               -- textures and colors
			   l0_texture     = "spells\\Nex_EnvMap03",
               l0_color       = "000420ff",
			   l0_border      = "00126688",
			   l1_texture     = "Interface\\Buttons\\WHITE8X8",
			   l1_color       = "000000FF",
			   l1_border      = "1A1A1AFF",
			   l2_texture     = "spells\\ICE3B_B",
			   l2_color       = "0D263aff",
			   l2_border      = "161242ff",
			   l3_texture     = "spells\\WING_WHITE_01",
			   l3_texture     = "spells\\MAGNETWAVE",
			   l3_color       = "0D4F8Bff",
			   l3_border      = "162282ff",
			   highlight      = "00ffff33",
			  -- fonts
			   f_label_name   = "Fonts\\FRIZQT__.ttf",
			   f_label_h      = 10,
			   f_label_flags  = "",
			   f_label_color  = "FFFFFFFF",
			   f_button_name  = "Fonts\\FRIZQT__.ttf",
			   f_button_h     = 12,
			   f_button_flags = "",
			   f_button_color = "FFFFFFFF",
			  }

local function init_constants()
 DD = {
  [L["Quality"]] = {},
  [L["Properties"]] = {},
  [L["Itemlevel"]] = {},
  [L["Stats"]] = {},
  [L["Dungeon"]] = {},
  [L["Affixes"]] = {},
 }
 
 C = {}
 
 C[L["Quality"]] = {
  [ITEM_QUALITY3_DESC] = 171, -- Rare
  [ITEM_QUALITY4_DESC] = 657, -- Epic
 }

 C[L["Properties"]] = {
  ["Pristine / Craft"]       = 2,
  ["Cooking Ingr."]          = 498,
  ["Raid Finder"]            = 451,
  ["Heroic"]                 = 524,
  ["Mythic"]                 = 569,
  ["Warforged"]              = 1822,
  ["Empowered"]              = 648,
  ["TWarped (660)"]          = 615,
  ["TWarped WF (675)"]       = 645,
  ["Timewalker (600)"]       = 602,
  ["Baleful"]                = 653,
  ["Stage 1/6"]              = 525,
  ["Stage 2/6"]              = 526,
  ["Stage 3/6"]              = 527,
  ["Stage 4/6"]              = 593,
  ["Stage 5/6"]              = 617,
  ["Stage 6/6"]              = 618,
  ["Tier 1 - Holy"]          = 585,
  ["Tier 1 - Corrupted"]     = 587,
  ["Tier 1 - Fire"]          = 589,
  ["Tier 0"]                 = 584,
  ["Tier 2 - Holy"]          = 586,
  ["Tier 2 - Corrupted"]     = 588,
  ["Tier 2 - Fire"]          = 590,
  ["Trading Post M. (689)"]  = 1732,
  ["Rank 1"]                 = 1673,
  --["Stage 1/9"]              = 1816,
  --["Stage 3/9"]              = 1817,
  --["Stage 4/9"]              = 1819,
  --["Stage 5/9"]              = 1818,
  --["Stage 6/9"]              = 1820,
  ["Stage 7/9"]              = 3332,
  ["Stage 8/9"]              = 3333,
  ["Stage 9/9"]              = 3334,
  ["Titanforged (superior)"] = 3338,
  ["Titanforged (epic)"]     = 3337,
  ["<name> Elite"]           = 580,
  ["<name> Mythic"]          = 581,
  ["Obliterum 0/10"]         = 669,
  ["Obliterum 1/10"]         = 670,
  ["Obliterum 2/10"]         = 671,
  ["Obliterum 3/10"]         = 672,
  ["Obliterum 4/10"]         = 673,
  ["Obliterum 5/10"]         = 674,
  ["Obliterum 6/10"]         = 675,
  ["Obliterum 7/10"]         = 676,
  ["Obliterum 8/10"]         = 677,
  ["Obliterum 9/10"]         = 678,
  ["Obliterum 10/10"]        = 679,

  ["Primal Obliterum: 0/10"] = 3598,
  ["Primal Obliterum: 1/10"] = 3599,
  ["Primal Obliterum: 2/10"] = 3600,
  ["Primal Obliterum: 3/10"] = 3601,
  ["Primal Obliterum: 4/10"] = 3602,
  ["Primal Obliterum: 5/10"] = 3603,
  ["Primal Obliterum: 6/10"] = 3604,
  ["Primal Obliterum: 7/10"] = 3605,
  ["Primal Obliterum: 8/10"] = 3606,
  ["Primal Obliterum: 9/10"] = 3607,
  ["Primal Obliterum: 10/10"]= 3608,
  
  ["Mythic 2"]               = 3410,
  ["Mythic 3"]               = 3411,
  ["Mythic 4"]               = 3412,
  ["Mythic 5"]               = 3413,
  ["Mythic 6"]               = 3414,
  ["Mythic 7"]               = 3415,
  ["Mythic 8"]               = 3416,
  ["Mythic 9"]               = 3417,
  ["Mythic 10"]              = 3418,
  ["Mythic 11"]              = 3509,
  ["Mythic 12"]              = 3510,
  ["Mythic 13"]              = 3534,
  ["Mythic 14"]              = 3535,
  ["Mythic 15"]              = 3536,
  ["Sunwell"]                = 3532,
["This Color Hurts My Eyes"] = 3533,
["Champion Equipment (685)"] = 3472,
  ["Relinquished"]           = 3573,
  ["Dauntless"]              = 3574,
  ["Confiscated"]            = 3620,
  ["Unsullied"]              = 3629,
 }
 
 DB = {}
 DB.bonus_ilvl_modifiers = {
  [451]  = -12,
  [171]  = 10,
  [648]  = 45,
  [526]  = 15,
  [527]  = 30,
  [593]  = 45,
  [617]  = 60,
  [618]  = 75,
  [3332] = 30,
  [3333] = 35,
  [3334] = 40,

  -- obliterum
  [669]  = 15,
  [670]  = 20,
  [671]  = 25,
  [672]  = 30,
  [673]  = 35,
  [674]  = 40,
  [675]  = 45,
  [676]  = 50,
  [677]  = 55,
  [678]  = 60,
  [679]  = 65,
  
  -- primal obliterum
  [3599] = 5,
  [3600] = 10,
  [3601] = 15,
  [3602] = 20,
  [3603] = 25,
  [3604] = 30,
  [3605] = 35,
  [3606] = 40,
  [3607] = 45,
  [3608] = 50,
 }
 
 C[L["Stats"]] = {
  [" Avoidance"] = 40,
  [" Leech"] = 41,
  [" Speed"] = 42,
  [" Indestructible"] = 43,
  [" Prismatic Socket"] = 608,

  ["of the Savage"] = 461,
  ["of the Quickblade"] = 87,
  ["of the Feverflare"] = 108,
  ["of the Deft"] = 466,
  ["of the Aurora"] = 150,
  ["of the Merciless"] = 470,
  ["of the Harmonious"] = 196,
  ["of the Strategist"] = 473,
  ["of the Guileful"] = 463,
  ["of the Windshaper"] = 468,
  ["of the Noble"] = 472,
  ["of the Stormbreaker"] = 477,
  ["of the Stalwart"] = 475,
  ["of the Fanatic"] = 462,
  ["of the Zealot"] = 467,
  ["of the Diviner"] = 471,
  ["of the Herald"] = 476,
  ["of the Augur"] = 474,
  ["of the Decimator"] = 486,
  ["of the Impatient"] = 487,
  ["of the Savant"] = 488,
  ["of the Relentless"] = 482,
  ["of the Adaptable"] = 490,
  ["of the Unbreakable"] = 484,
  ["of the Pious"] = 483,
  ["of Power"] = 3,
  ["of the Fireflash"] = 459,
  ["of the Peerless"] = 460,
 }
 
-- negative ilvl modifiers
DB.nt = {
  [518] = 100,
  [519] = 80,
  [520] = 60,
  [521] = 30,
  [522] = 15,
  }

-- positive ilvl modifiers
DB.pt = {
  [622] = 3,
  [623] = 6,
  [624] = 9,
  [625] = 12,
  [626] = 15,
  [627] = 18,
  [591] = 20,
  [628] = 21,
  [629] = 24,
  [630] = 27,
  [631] = 30,
  [632] = 33,
  [553] = 35,
  [633] = 36,
  [634] = 39,
  [609] = 40,
  [635] = 42,
  [636] = 45,
  [637] = 48,
  [638] = 51,
  [639] = 54,
  [640] = 57,
  [641] = 60,
  [556] = 65,
  [557] = 70,
}

DB.adjust_t =
{
 [-2] = {519, 609, 635},
 [-1] = {519, 632, 637},
 [1]  = {520, 634, 591},
 [2]  = {520, 609, 627},
 [3]  = {522, 625},
 [4]  = {521, 591, 623},
 [5]  = {520, 553, 591},
 [6]  = {522, 624},
 [7]  = {521, 591, 622},
 [8]  = {520, 609, 625},
 [9]  = {522, 623},
 [10] = {521, 591},
 [11] = {520, 609, 624},
 [12] = {522, 622},
 [13] = {520, 591, 630},
 [14] = {520, 609, 623},
}

 -- keystones
 C[L["Dungeon"]] = {
  ["Temple of the Jade Serpent"] = 2,
  ["Stormstout Brewery"]         = 56,
  ["Gate of the Setting Sun"]    = 57,
  ["Shado-Pan Monastery"]        = 58,
  ["Siege of Niuzao Temple"]     = 59,
  ["Mogu'shan Palace"]           = 60,
  ["Scholomance"]                = 76,
  ["Scarlet Halls"]              = 77,
  ["Scarlet Monastery"]          = 78,
  ["Skyreach"]                   = 161,
  ["Bloodmaul Slag Mines"]       = 163,
  ["Auchindoun"]                 = 164,
  ["Shadowmoon Burial Grounds"]  = 165,
  ["Grimrail Depot"]             = 166,
  ["Upper Blackrock Spire"]      = 167,
  ["The Everbloom"]              = 168,
  ["Iron Docks"]                 = 169,
  ["Eye of Azshara"]             = 197,
  ["Darkheart Thicket"]          = 198,
  ["Black Rook Hold"]            = 199,
  ["Halls of Valor"]             = 200,
  ["Neltharion's Lair"]          = 206,
  ["Vault of the Wardens"]       = 207,
  ["Maw of Souls"]               = 208,
  ["The Arcway"]                 = 209,
  ["Court of Stars"]             = 210,
  ["Return to Karazhan: Lower"]  = 227,
  ["Cathedral of Eternal Night"] = 233,
  ["Return to Karazhan: Upper"]  = 234,
  ["Seat of the Triumvirate"]    = 239,
 }
 
 C[L["Affixes"]] = {
  ["Overflowing"] = 1,
  ["Skittish"]    = 2,
  ["Volcanic"]    = 3,
  ["Necrotic"]    = 4,
  ["Teeming"]     = 5,
  ["Raging"]      = 6,
  ["Bolstering"]  = 7,
  ["Sanguine"]    = 8,
  ["Tyrannical"]  = 9,
  ["Fortified"]   = 10,
  ["Bursting"]    = 11,
  ["Grievous"]    = 12,
  ["Explosive"]   = 13,
  ["Quaking"]     = 14,
  ["Relentless"]  = 15,
 }
end

local function updateLeftTooltip()
 local itemID = tonumber(edt:GetText())
 
 if not itemID then return end
 
 local _, link = GetItemInfo(edt:GetText())
 
 if not link then 
  left_tooltip:Hide()
  right_tooltip:Hide()
  return
 end

 left_tooltip:SetOwner(mf, "ANCHOR_NONE")
 left_tooltip:SetPoint("RIGHT", mf, "LEFT")
 left_tooltip:ClearLines()
 left_tooltip:SetHyperlink(link)
 left_tooltip:Show()
end

local function updateRightTooltip()
 if not resultLink then 
  right_tooltip:Hide()
  return
 end
 
 right_tooltip:SetOwner(mf, "ANCHOR_NONE")
 right_tooltip:SetPoint("LEFT", mf, "RIGHT")
 right_tooltip:ClearLines()
 right_tooltip:SetHyperlink(resultLink)
 right_tooltip:Show()
end

local function generateLink()

 -- keystone 
 if addonTable.mode == "keystone" then
 
  local function get(dungeon, ...)
   local s = C[L["Dungeon"]][dungeon.value] or "2"
   s = s..":"..FakeItemLinksIlvlSlider.value
     for i = 1, 3 do
    s = s..(C[L["Affixes"]][select(i, ...).value] and (":"..C[L["Affixes"]][select(i, ...).value]) or ":0")
   end
   return s
  end

  resultLink = "|cffa335ee|Hkeystone:"..get(DD[L["Dungeon"]][1], DD[L["Affixes"]][1], DD[L["Affixes"]][2], DD[L["Affixes"]][3]).."|h[Keystone: "..(DD[L["Dungeon"]][1].value or "").."]|h|r"
  updateRightTooltip()
  return true
 end
 
 local itemID = tonumber(edt:GetText())
 
 if not itemID then return end
 
 local name, link, quality, _, _, _, _, _, equipSlot, texture = GetItemInfo(itemID)
 
 if not link then return end -- the item doesn't exist
 
 --local _, _, _, col = GetItemQualityColor(quality or 0)

 local numBonus = 0
 local s_bonus = ""
 local ilvl_modifier = 0
  
 local function addBonus(dd)
  --local text = UIDropDownMenu_GetText(dd)
  local text = dd.value or ""
  local bonuses = C[dd.group]
  if bonuses[text] then
   numBonus = numBonus + 1
   local bonus = bonuses[text]
   s_bonus = s_bonus..":"..bonus
   if DB.bonus_ilvl_modifiers[bonus] then
    ilvl_modifier = ilvl_modifier + DB.bonus_ilvl_modifiers[bonus]
   end
  end
 end
 for _,v in pairs(DD) do
  for _,dropdown in pairs(v) do
   addBonus(dropdown)
  end
 end
 
 local _, _, _, baseILvl = GetItemInfo(itemID)
 local old_result = resultLink
 
 --local bonuses, numBonuses = addonTable:setItemlevel(baseILvl + ilvl_modifier, -FakeItemLinksIlvlSlider.value + ilvl_modifier, numBonus)
 local bonuses, numBonuses = addonTable:setItemlevel(baseILvl, FakeItemLinksIlvlSlider.value - ilvl_modifier, numBonus)
 numBonus = numBonus + numBonuses
 --resultLink = "|c"..col.."|Hitem:"..itemID..":0:0:0:0:0:0:0:100:268:0:3:"..numBonus..s_bonus..(bonuses or "").."|h["..(name or "").."]|h|r"
 resultLink = "|Hitem:"..itemID.."::::::::100:268::3:"..numBonus..s_bonus..(bonuses or "")
 
 local ILvl
 name, _, quality, ILvl = GetItemInfo(resultLink)

 if ILvl < 1 then -- this should never happen
  --print(addonName.." - Itemlevel cannot be a negative number")
  resultLink = old_result
  return
 end
 
 local _, _, _, col = GetItemQualityColor(quality or 0)
 resultLink = "|c"..col..resultLink.."|h["..(name or "").."]|h|r"
 updateRightTooltip()
 return true
end

local function sort(a, b)
 return lower(a) < lower(b)
end

local function initDropDowns()

 local p = mf.grp_item

 local w
 local base_text
 local disable

 local function dd_OnValueChanged(self)
  if not resultLink then return end
  
  self.value = self.list[self.index]
  
  if not generateLink() then
   self.value = nil
   self.index = 0
   self:SetText(empty_text)
  end
 end
 
 local function dd_update_pre(self)
  local data = C[self:GetParent().group]
  
  wipe(self.list)
 
  for k,v in pairs(data) do
   self.list[#self.list + 1] = k
  end
  
  tsort(self.list, sort)
  
  tinsert(self.list, 1, empty_text)
 end
 
 local function dd_update_button(self, list, index)
  self.left_text:SetText(list[index])
 end

 local function createDropDown(i, t, ...)
  local f = ng:New(addonName, "Dropdown", "FakeItemLinkDD"..i, p)
  f.list = {}
  f.update_pre = dd_update_pre
  f.update_button = dd_update_button
  f.OnValueChanged = dd_OnValueChanged

  local tab = DD[t]
  if #tab > 0 then
   f:SetPoint("TOP", tab[#tab], "BOTTOM", 0, -3)
  else
   mf["lbl_"..t] = ng:New(addonName, "Label", nil, p)
   local txt = mf["lbl_"..t]
   txt:SetPoint("BOTTOMLEFT", f, "TOPLEFT", 10, 3)
   txt:SetText(t)
   f:SetPoint(...)
  end
  tab[#tab + 1] = f
  f.group = t
  f.disable = disable
  f:SetWidth(w)
  f:SetText(base_text)
 end

 base_text = empty_text
 w = 150
 disable = true

 createDropDown(1, L["Quality"], "TOPLEFT", mf, "TOPLEFT", 15, -100)
 
 for i = 2,5 do
  createDropDown(i, L["Properties"], "TOP", DD[L["Quality"]][1], "BOTTOM", 0, -20)
 end

 for i = 6,9 do
  createDropDown(i, L["Stats"], "TOP", DD[L["Properties"]][4], "BOTTOM", 0, -20)
 end

-- itemlevel slider
 mf.lblItemlevel = p:CreateFontString()
 mf.lblItemlevel:SetFont("Fonts\\ARIALN.ttf", 14, "")
 mf.lblItemlevel:SetText(L["Itemlevel"])
 mf.lblItemlevel:SetPoint("TOPRIGHT", mf, "TOPRIGHT", -75, -100)
 
 local f = ng:New(addonName, "SliderV", "FakeItemLinksIlvlSlider", mf)
 f:SetPoint("TOPRIGHT", mf.lblItemlevel, "BOTTOMRIGHT", 0, -15)
 f:SetSize(15,210)
 f.thumbTexture:SetSize(30, 30)
 f.thumbTexture:SetTexture("Interface\\Challenges\\ChallengeMode_Medal_Gold")
 f:SetMinMaxValues(-1000, -1)

 f.text:ClearAllPoints()
 f.text:SetPoint("TOPLEFT", f, "TOPRIGHT", 10, -5)
 f.text:SetText("1000")
 local hightext = ng:New(addonName, "Label", nil, f)
 hightext:ClearAllPoints()
 hightext:SetPoint("BOTTOMLEFT", f, "BOTTOMRIGHT", 10, 5)
 hightext:SetText("1")

 f.text_value:ClearAllPoints()
 f.text_value:SetPoint("RIGHT", f.thumbTexture, "LEFT", -5, 0)
 
 f:SetValueStep(1)
 f:SetScript("OnValueChanged", function(self, value)
                                local v = -floor(value)
                                self.value = v
                                self.text_value:SetText(v)
                                self.edt:SetText(v)
                                generateLink()
                               end)
  
 local e = ng:New(addonName, "Editbox", nil, mf)
 e:SetPoint("LEFT", mf.lblItemlevel, "RIGHT", 2, 0)
 e:SetWidth(55)
 e:SetHeight(20)
 e:SetAutoFocus(false)
 e.func = function(self)
   self:ClearFocus()
   local v = tonumber(self:GetText())
   
   if not v then return end
   
   v = math.max(0, math.min(1000, v))
   FakeItemLinksIlvlSlider:SetValue(-v)

   updateLeftTooltip()
   generateLink()
  end
 e.cancelfunc = e.func
 e:ClearFocus()
 
 f.edt = e
 f:SetValue(1)

 local function btn_ilvl_onenter(f)
  GameTooltip:ClearLines()
  GameTooltip:SetOwner(f, "ANCHOR_LEFT")
  GameTooltip:AddLine(f.tooltip)
  GameTooltip:Show()
 end
 
 local function btn_ilvl_onleave(f)
  GameTooltip:Hide()
 end
 
 local function btn_ilvl_onclick(f)
  FakeItemLinksIlvlSlider:SetValue(-f.tag)
  generateLink()
 end
 
 local function create_ilvl_button(ilvl, tt, y)
  local btn = ng:New(addonName, "Button", nil, p, false)
  btn:SetPoint("LEFT", f, "RIGHT", 25, y)
  btn:SetSize(25, 25)
  btn.tag = ilvl
  btn.tooltip = tt
  btn:SetScript("OnClick", btn_ilvl_onclick)
  btn:HookScript("OnEnter", btn_ilvl_onenter)
  btn:HookScript("OnLeave", btn_ilvl_onleave)
  
  btn:SetBackdrop(ilvl_buttons_backdrop)
 end
 
 ilvl_buttons_backdrop.bgFile = "interface\\icons\\ExpansionIcon_MistsofPandaria"
 create_ilvl_button(450, EXPANSION_NAME4, 45)
 ilvl_buttons_backdrop.bgFile = "interface\\icons\\Achievement_Zone_Cataclysm"
 create_ilvl_button(333, EXPANSION_NAME3, 15)
 ilvl_buttons_backdrop.bgFile = "interface\\icons\\expansionicon_wrathofthelichking"
 create_ilvl_button(160, EXPANSION_NAME2, -15)
 ilvl_buttons_backdrop.bgFile = "interface\\icons\\Achievement_Dungeon_Outland_DungeonMaster"
 create_ilvl_button(95 , EXPANSION_NAME1, -45)
 
 -- keystone group
 p = mf.grp_keystone

 createDropDown(1, L["Dungeon"], "TOPLEFT", mf, "TOPLEFT", 15, -100)
 
 for i = 2,4 do
  createDropDown(i, L["Affixes"], "TOP", DD[L["Dungeon"]][1], "BOTTOM", 0, -20)
 end
end

local function resetItemlevel()
 
 if addonTable.mode == "keystone" then
  FakeItemLinksIlvlSlider:SetValue(-1)
  return
 end

 local itemID = tonumber(edt:GetText())
  
 if not itemID then return end
 
 local _, link, _, ilvl = GetItemInfo(itemID)
 
 if not link then return end -- the item doesn't exist
 
 FakeItemLinksIlvlSlider:SetValue(-ilvl)
end

local function resetDropDowns()
 local base_text = empty_text
 
 for _,v in pairs(DD[L["Quality"]]) do
  v:SetText(base_text)
  v.value = nil
 end
 
 for _,v in pairs(DD[L["Properties"]]) do
  v:SetText(base_text)
  v.value = nil
 end
 
 for _,v in pairs(DD[L["Stats"]]) do
  v:SetText(base_text)
  v.value = nil
 end
 
 for _,v in pairs(DD[L["Dungeon"]]) do
  v:SetText(base_text)
  v.value = nil
 end
 
 for _,v in pairs(DD[L["Affixes"]]) do
  v:SetText(base_text)
  v.value = nil
 end
 
 resetItemlevel()
 
 generateLink()
end

local function setupInterface()
 -- setup UI for item or keystone mode
 if addonTable.mode == "keystone" then
  --FakeItemLinksIlvlSlider:SetMinMaxValues(-500, -1)
  mf.grp_item:Hide()
 else -- item
  --FakeItemLinksIlvlSlider:SetMinMaxValues(-1000, -1)
  mf.grp_keystone:Hide()
 end

 FakeItemLinksIlvlSlider:SetValue(-1)
 mf["grp_"..addonTable.mode]:Show()
end

local function initialize()
 if not mf then
  ng = NyxGUI("1.0")

  init_constants()

  ng:Initialize(addonName, nil, nil, theme)
  
  mf = ng:New(addonName, "Frame", "FakeItemLinksMainframe", UIParent)
  mf:SetMovable(true)
  mf:EnableMouse(true)
  mf:RegisterForDrag("LeftButton")
  mf:SetScript("OnDragStart", function(self) self:StartMoving() end)
  mf:SetScript("OnDragStop",  function(self) self:StopMovingOrSizing() end)
  mf:SetPoint("CENTER")
  mf:SetSize(350,400)
  
  mf.grp_item = CreateFrame("Frame", nil, mf)
  mf.grp_item:SetPoint("TOPLEFT")
  
  mf.grp_keystone = CreateFrame("Frame", nil, mf)
  mf.grp_keystone:SetPoint("TOPLEFT")
  mf.grp_keystone:Hide()
  
  mf.title = mf:CreateFontString()
  mf.title:SetFont("Fonts\\MORPHEUS.ttf", 20, "OUTLINE")
  mf.title:SetPoint("TOP", mf, "TOP", 0, -10)
  mf.title:SetText("|cff0099ffFake ItemLinks|r")

  left_tooltip = CreateFrame("GameTooltip", "FakeItemLinksLeftTooltip", mf, "GameTooltipTemplate")
  left_tooltip:SetFrameStrata("MEDIUM")
  left_tooltip:SetOwner(mf, "ANCHOR_NONE")
  left_tooltip:SetPoint("RIGHT", mf, "LEFT")

  right_tooltip = CreateFrame("GameTooltip", "FakeItemLinksRightTooltip", mf, "GameTooltipTemplate")
  right_tooltip:SetFrameStrata("MEDIUM")
  right_tooltip:SetOwner(mf, "ANCHOR_NONE")
  right_tooltip:SetPoint("LEFT", mf, "RIGHT")

  addonTable.mode = "item"
  
  mf.mode_switch = ng:New(addonName, "Button", nil, mf)
  mf.mode_switch:SetPoint("TOPRIGHT", mf, "TOPRIGHT", -10, -10)
  mf.mode_switch:SetSize(75, 25)
  mf.mode_switch:SetText(ENCOUNTER_JOURNAL_ITEM)
  mf.mode_switch:SetScript("OnClick", function(self)
    if addonTable.mode == "item" then
     addonTable.mode = "keystone"
     generateLink()
     left_tooltip:Hide()
     self:SetText(L["Keystone"])
    else
     addonTable.mode = "item"
     resultLink = nil
     resetDropDowns()
     edt:SetText("")
     right_tooltip:Hide()
     self:SetText(ENCOUNTER_JOURNAL_ITEM)
    end
    setupInterface()
   end)
  
  edt = ng:New(addonName, "Editbox", "FLEditbox", mf.grp_item)
  edt:SetPoint("TOPLEFT", mf, "TOPLEFT", 15, -45)
  edt:SetTitle(ENCOUNTER_JOURNAL_ITEM)
  edt:SetWidth(100)
  edt:SetHeight(25)
  edt.func = function(self)
   self:ClearFocus()
   updateLeftTooltip()
   --resetItemlevel()
   generateLink()
  end
  edt.cancelfunc = edt.func
  edt:ClearFocus()

  f = function(self) 
   local t, itemID = GetCursorInfo()
   if t == "item" then
    self:SetText(itemID)
	self:ClearFocus()
	updateLeftTooltip()
	--resetItemlevel()
	generateLink()
   end
  end

  edt:SetScript("OnMouseUp", f)
  edt:SetScript("OnReceiveDrag", f)
  
  edt.desc = ng:New(addonName, "Label", nil, edt)
  edt.desc:SetPoint("LEFT", edt, "RIGHT", 10, 0)
  edt.desc:SetText("<-- "..L["Type an ItemID, link an Item"].."\n"..L["or drag an Item here"])
  
  initDropDowns()
  
  local btn = ng:New(addonName, "Button", nil, mf)
  btn:SetPoint("BOTTOMRIGHT", mf, "BOTTOMRIGHT", -15, 15)
  btn:SetWidth(100)
  btn:SetText(CLOSE)
  btn:SetScript("OnClick", function() mf:Hide() end)
  
  btn = ng:New(addonName, "Button", nil, mf)
  btn:SetPoint("BOTTOMLEFT", mf, "BOTTOMLEFT", 15, 15)
  btn:SetWidth(100)
  btn:SetText(L["Chat Link"])
  btn:SetScript("OnClick", function() 
   if resultLink then
    --print(addonName.." - "..resultLink)
	DEFAULT_CHAT_FRAME:AddMessage(addonName.." - "..resultLink)
   end
  end)

  btn = ng:New(addonName, "Button", nil, mf)
  btn:SetPoint("BOTTOM", mf, "BOTTOM", 0, 15)
  btn:SetWidth(100)
  btn:SetText(RESET)
  btn:SetScript("OnClick", resetDropDowns)
  
  mf.eventhandler = CreateFrame("Frame")
  mf.eventhandler:RegisterEvent("GET_ITEM_INFO_RECEIVED")
  mf.eventhandler:SetScript("OnEvent", function(self, event, ...)
   updateLeftTooltip()
   generateLink()
  end)

  local function setItemID(link)
   if mf:IsVisible() and edt:HasFocus() and IsShiftKeyDown() then
    local _, itemID = strsplit(":", link)
    edt:SetText(itemID or "")
	updateLeftTooltip()
	generateLink()
	edt:ClearFocus()
   end
  end
  
  hooksecurefunc("HandleModifiedItemClick", setItemID)
  hooksecurefunc("SetItemRef", setItemID)
  
  mf:Show()
 else
  if not mf:IsVisible() then 
   updateLeftTooltip()
   generateLink()
   mf.eventhandler:RegisterEvent("GET_ITEM_INFO_RECEIVED")
   mf:Show()
  else
   mf.eventhandler:UnregisterEvent("GET_ITEM_INFO_RECEIVED")
   mf:Hide()
  end
 end
end

local counter = 0
local function adjustResult(s, diff, maxBonuses)
 if DB.adjust_t[diff] then
  for k,v in pairs(DB.adjust_t[diff]) do
   if counter < maxBonuses then
    s = s..":"..v
    counter = counter + 1
   end
  end
 end
 
 return s
end

local function getNear(a, b, t, maxBonuses)
 local s = ""

 if (a - b < 15 and a - b > -3) then
  s = adjustResult(s, a - b, maxBonuses)
 else 
  local remaining = -math.abs(a - b)
  while counter < maxBonuses do
   local index
   local last_diff = -10000

   for k,v in pairs(t) do
    local diff = remaining + v
    if diff <= 0 and diff > last_diff then
     index = k
     last_diff = diff
    end
   end

   if index then
    remaining = remaining + t[index]
    s = s..":"..index
   else
    break
   end

   local real_diff = t == DB.pt and last_diff or -last_diff
   if real_diff < 15 and real_diff > -3 then
    s = adjustResult(s, real_diff, maxBonuses)
    break
   end
  
   counter = counter + 1
  end
 end

 return s
end

function addonTable:setItemlevel(a, b, current_bonuses)
 local s
 counter = 1
 
 if a > b then
  s = getNear(a, b, DB.nt, 15 - current_bonuses)
 elseif a < b then
  s = getNear(a, b, DB.pt, 15 - current_bonuses)
 end

 if not s then counter = 0 end
 
 return s, counter
end

-- slash command
SLASH_FAKEITEMLINKS1 = "/fakeitemlinks"
SLASH_FAKEITEMLINKS2 = "/fil"
SlashCmdList["FAKEITEMLINKS"] = initialize