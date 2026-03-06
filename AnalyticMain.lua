AnalyticMain = {}

function AnalyticMain:loadMap(name)
    -- --- ČÁST 1: DIAGNOSTIKA ---
    local gameVersion = g_gui.languageHelp.gameVersion
    
    print("--- [Analytic Farming Pack] DIAGNOSTIKA ---")
    print(string.format("Verze hry: %s", tostring(gameVersion)))
    
    if g_modManager ~= nil then
        print(string.format("Hra očekává descVersion kolem: %s", tostring(g_modManager.defaultDescVersion)))
    end
    print("-------------------------------------------")

    -- --- ČÁST 2: ANALÝZA POLÍ ---
    print("--- [Analytic Farming Pack] STARTUJI ANALYZU POLI ---")
    
    local fieldManager = g_fieldManager
    local farmlandManager = g_farmlandManager
    
    if fieldManager ~= nil and farmlandManager ~= nil then
        local fields = fieldManager.fields
        print(string.format("Nalezeno celkem poli na mape: %d", #fields))
        
        for _, field in ipairs(fields) do
            -- Zjištění majitele pozemku
            local farmlandId = farmlandManager:getFarmlandIdAtWorldPosition(field.posX, field.posZ)
            local ownerId = farmlandManager:getFarmlandOwner(farmlandId)
            
            -- g_currentMission.playerFarmId je ID tvé farmy
            if ownerId == g_currentMission.playerFarmId then
                local area = field.fieldAreaInHa
                print(string.format("-> Pole c. %d ti patri! Rozloha: %.2f ha", field.fieldId, area))
            end
        end
    end
    print("--- [Analytic Farming Pack] ANALYZA DOKONCENA ---")
end

addModEventListener(AnalyticMain)