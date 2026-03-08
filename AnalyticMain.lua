AnalyticMain = {}
AnalyticMain.name = "AnalyticFarmingPack"

AnalyticMain.data = {
    initialized = false,
    myFarmId = 0,
    ownedFarmlands = {},
    lastFarmlandId = -1,
    moneyLastFrame = -1
}

function AnalyticMain:update(dt)
    -- 1. POJISTKA: Musí existovat mise, mapa a statistiky
    if g_currentMission == nil or g_currentMission.missionInfo == nil or g_localPlayer == nil then
        return 
    end

    -- 2. ZÍSKÁNÍ FARM ID
    local currentFarmId = g_localPlayer:getFarmId()
    if currentFarmId == 0 then return end -- Hráč ještě není přiřazen k farmě

    -- 3. INICIALIZACE (Proběhne jednou)
    if not self.data.initialized then
        self.data.myFarmId = currentFarmId
        -- Bezpečné získání peněz přes farmu
        local farm = g_farmManager:getFarmById(currentFarmId)
        if farm ~= nil then
            self.data.moneyLastFrame = farm.money
            print(string.format("--- [%s] SYSTEM AKTIVOVAN (Farma: %s, Peníze: %.0f) ---", self.name, farm.name, farm.money))
            self:updateInventory()
            self.data.initialized = true
        end
        return
    end

    -- 4. DETEKCE VOZIDLA
    if g_currentMission.controlledVehicle ~= nil then
        local v = g_currentMission.controlledVehicle
        if v.rootNode ~= nil then
            local x, _, z = getWorldTranslation(v.rootNode)
            local fId = g_farmlandManager:getFarmlandIdAtWorldPosition(x, z)
            
            if fId ~= nil and fId ~= self.data.lastFarmlandId then
                local isMine = self.data.ownedFarmlands[fId] ~= nil
                local ownerText = isMine and "TVUJ POZEMEK" or "CIZI/CESTA"
                print(string.format("--- [%s] LOKALIZACE: Pole %d (%s)", self.name, fId, ownerText))
                self.data.lastFarmlandId = fId
            end
        end
    end

    -- 5. SLEDOVÁNÍ PENĚZ (Přímo přes farmu, ne přes mission stats)
    local farm = g_farmManager:getFarmById(self.data.myFarmId)
    if farm ~= nil then
        local currentMoney = farm.money
        if self.data.moneyLastFrame ~= -1 and currentMoney < self.data.moneyLastFrame then
            local spent = self.data.moneyLastFrame - currentMoney
            print(string.format("--- [%s] HOLDING VYDAJ: -%.0f € (Zůstatek: %.0f €)", self.name, spent, currentMoney))
        end
        self.data.moneyLastFrame = currentMoney
    end
end

function AnalyticMain:updateInventory()
    local farmlands = g_farmlandManager:getFarmlands()
    self.data.ownedFarmlands = {}
    local count = 0
    
    print(string.format("--- [%s] AKTUALIZACE HOLDINGU ---", self.name))

    for _, farmland in ipairs(farmlands) do
        if farmland.ownerFarmId == self.data.myFarmId then
            self.data.ownedFarmlands[farmland.id] = true
            count = count + 1
            
            -- Rozlišení typu pozemku pro tvůj přehled
            if farmland.id == 69 then
                print(string.format("--- [%s] MAJETEK: ID %d (OVCI FARMA / DVUR)", self.name, farmland.id))
            elseif farmland.id == 67 then
                print(string.format("--- [%s] MAJETEK: ID %d (LOUKA C. 3)", self.name, farmland.id))
            else
                print(string.format("--- [%s] MAJETEK: ID %d (Ostatni parcela)", self.name, farmland.id))
            end
        end
    end
    print(string.format("--- [%s] CELKEM V HOLDINGU: %d objektu.", self.name, count))
end

addModEventListener(AnalyticMain)
print("--- [" .. AnalyticMain.name .. "] SKRIPT OPRAVEN A NACTEN ---")