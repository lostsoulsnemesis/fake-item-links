-- Fake Item Links by Vildiesel EU-Well of Eternity

local _, addonTable = ...

local locale = GetLocale()
addonTable.L = setmetatable({}, { __index = function(_, k)
                                             return k
                                            end})
local L = addonTable.L


if locale == "esES" then 
--@localization(locale="esES", format="lua_additive_table", handle-unlocalized="english")@
elseif locale == "esMX" then 
--@localization(locale="esMX", format="lua_additive_table", handle-unlocalized="english")@
elseif locale == "itIT" then 
--@localization(locale="itIT", format="lua_additive_table", handle-unlocalized="english")@
elseif locale == "ptBR" then 
--@localization(locale="ptBR", format="lua_additive_table", handle-unlocalized="english")@
elseif locale == "frFR" then
--@localization(locale="frFR", format="lua_additive_table", handle-unlocalized="english")@
elseif locale == "deDE" then 
--@localization(locale="deDE", format="lua_additive_table", handle-unlocalized="english")@
elseif locale == "ruRU" then 
--@localization(locale="ruRU", format="lua_additive_table", handle-unlocalized="english")@
elseif locale == "zhCN" then 
--@localization(locale="zhCN", format="lua_additive_table", handle-unlocalized="english")@
elseif locale == "zhTW" then 
--@localization(locale="zhTW", format="lua_additive_table", handle-unlocalized="english")@
elseif locale == "koKR" then
--@localization(locale="koKR", format="lua_additive_table", handle-unlocalized="english")@
end