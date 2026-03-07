AnalyticMain = {}

-- Tato funkce vytvoří "tělo" tvého modu, které hra vyžaduje
function AnalyticMain.new()
    local self = {}
    setmetatable(self, { __index = AnalyticMain })
    return self
end

-- loadMap se spustí, když se načítá mapa
function AnalyticMain:loadMap(name)
    print("--- [Analytic Farming Pack] START ANALYZY ---")
    
    -- Diagnostika: Verze hry
    if g_gui ~= nil and g_gui.languageHelp ~= nil then
        print(string.format("Verze hry: %s", tostring(g_gui.languageHelp.gameVersion)))
    end

    -- Analýza polí: Musíme počkat, až je g_currentMission připravena
    if g_currentMission ~= nil and g_fieldManager ~= nil then
        local fields = g_fieldManager.fields
        if fields ~= nil then
            print(string.format("Nalezeno poli na mape: %d", #fields))
            -- Zde můžeme později přidat další výpočty
        end
    end
    
    print("--- [Analytic Farming Pack] HOTOVO ---")
end

-- Registrace: Vytvoříme instanci a přidáme ji do systému
local myModInstance = AnalyticMain.new()
addModEventListener(myModInstance)