AnalyticMain = {}
local AnalyticMain_mt = { __index = AnalyticMain }

function AnalyticMain.new(mission, i3dFilename)
    local self = setmetatable({}, AnalyticMain_mt)
    print("--- [Analytic Farming Pack] Inicializace objektu ---")
    return self
end

function AnalyticMain:loadMap(name)
    print("--- [Analytic Farming Pack] START ANALYZY ---")
    
    -- Diagnostika
    if g_gui and g_gui.languageHelp then
        print(string.format("Verze hry: %s", tostring(g_gui.languageHelp.gameVersion)))
    end

    -- Analyza poli
    if g_fieldManager and g_farmlandManager and g_currentMission then
        local fields = g_fieldManager.fields
        if fields ~= nil then
            for _, field in ipairs(fields) do
                local farmlandId = g_farmlandManager:getFarmlandIdAtWorldPosition(field.posX, field.posZ)
                local ownerId = g_farmlandManager:getFarmlandOwner(farmlandId)
                
                if ownerId == g_currentMission.playerFarmId then
                    print(string.format("-> Vlastnis pole c. %s (Rozloha: %.2f ha)", tostring(field.fieldId), field.fieldAreaInHa))
                end
            end
        end
    end
    print("--- [Analytic Farming Pack] HOTOVO ---")
end

-- Registrace modu bezpecnejsi cestou
addModEventListener(AnalyticMain)