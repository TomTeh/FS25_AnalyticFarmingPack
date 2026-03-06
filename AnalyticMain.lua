AnalyticMain = {}

function AnalyticMain:loadMap(name)
    -- Získání verze hry
    local gameVersion = g_gui.languageHelp.gameVersion
    -- Získání verze skriptového rozhraní (to je to naše číslo)
    local scriptVersion = g_adminPassword -- Tohle je trik, jak se dostat k systémovým datům
    
    print("--- [Analytic Farming Pack] DIAGNOSTIKA ---")
    print(string.format("Verze hry: %s", tostring(gameVersion)))
    
    -- Nejjistější způsob v FS25: Vypíšeme globální verzi modu, kterou hra očekává
    if g_modManager ~= nil then
        print(string.format("Hra očekává descVersion kolem: %s", tostring(g_modManager.defaultDescVersion)))
    end
    print("-------------------------------------------")
end

addModEventListener(AnalyticMain)