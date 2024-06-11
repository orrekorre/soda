---@param entity Entity
---@param identifier string | nil
---@return any
function _SODA_BOY:GetData(entity, identifier)
    local data = TSIL.Entities.GetEntityData(
        _SODA_BOY,
        entity,
        identifier or ""
    )

    if not data then
        data = {}
        TSIL.Entities.SetEntityData(
            _SODA_BOY,
            entity,
            identifier or "",
            data
        )
    end

    return data
end

---@return ItemPoolType
function _SODA_BOY:GetCurrentItemPool()
    local room = _SODA_BOY.Game:GetRoom()
    local pool = _SODA_BOY.Game:GetItemPool()

    return math.max(pool:GetPoolForRoom(room:GetType(), room:GetAwardSeed()), ItemPoolType.POOL_TREASURE)
end

---@param from number
---@param to number
---@return number
function _SODA_BOY:ShortAngleDis(from, to)
	local maxAngle = 360
	local disAngle = (to - from) % maxAngle

	return ((2 * disAngle) % maxAngle) - disAngle
end

---@param from number
---@param to number
---@param fraction number
---@return number
function _SODA_BOY:LerpAngle(from, to, fraction)
	return from + _SODA_BOY:ShortAngleDis(from, to) * fraction
end