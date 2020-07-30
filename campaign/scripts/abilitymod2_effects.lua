-- 
--	Please see the LICENSE.md file included with this distribution for attribution and copyright information.
--

function onInit()
	local node = getDatabaseNode()
	local nodeCharCT = getNodeCharCT(node)

	DB.addHandler(DB.getPath(nodeCharCT, 'effects.*.label'), 'onUpdate', updateEffectBonuses)
	DB.addHandler(DB.getPath(nodeCharCT, 'effects.*.isactive'), 'onUpdate', updateEffectBonuses)
	DB.addHandler(DB.getPath(nodeCharCT, 'effects'), 'onChildDeleted', updateEffectBonuses)
	DB.addHandler(DB.getPath(node, 'saves.*.ability2'), 'onUpdate', updateEffectBonuses)

	prepPaladin()
end

function onClose()
	local node = getDatabaseNode()
	local nodeCharCT = getNodeCharCT(node)

	DB.removeHandler(DB.getPath(nodeCharCT, 'effects.*.label'), 'onUpdate', updateEffectBonuses)
	DB.removeHandler(DB.getPath(nodeCharCT, 'effects.*.isactive'), 'onUpdate', updateEffectBonuses)
	DB.removeHandler(DB.getPath(nodeCharCT, 'effects'), 'onChildDeleted', updateEffectBonuses)
	DB.removeHandler(DB.getPath(node, 'saves.*.ability2'), 'onUpdate', updateEffectBonuses)
end

---	Locate the effects node within the relevant player character's node within combattracker
--	@param node the databasenode passed along when this file is initialized
--	@return nodeCharCT path to this PC's databasenode "effects" in the combat tracker
function getNodeCharCT(node)
	local rActor
	local nodeCharCT
	if node.getChild('.....').getName() == 'charsheet' then
		rActor = ActorManager.getActor('pc', node.getChild('....'))
		nodeCharCT = DB.findNode(rActor['sCTNode'])
	end

	return nodeCharCT
end

function updateEffectBonuses()
	local rActor = ActorManager.getActor('pc', window.getDatabaseNode())

	local sFort2Stat = string.upper(window.fortitudestat2.getValue())
	local nFort2EB = math.floor(EffectManagerEStS.getEffectsBonus(rActor, sFort2Stat, true) / 2)
	local sRef2Stat = string.upper(window.reflexstat2.getValue())
	local nRef2EB = math.floor(EffectManagerEStS.getEffectsBonus(rActor, sRef2Stat, true) / 2)
	local sWill2Stat = string.upper(window.willstat2.getValue())
	local nWill2EB = math.floor(EffectManagerEStS.getEffectsBonus(rActor, sWill2Stat, true) / 2)

	window.fortitudestatmod2effects.setValue(nFort2EB)
	window.reflexstatmod2effects.setValue(nRef2EB)
	window.willstatmod2effects.setValue(nWill2EB)

	window.fortitudemisc.secondSave()
	window.reflexmisc.secondSave()
	window.willmisc.secondSave()
end

function prepPaladin()
	local nodeChar = getDatabaseNode().getChild('....')
	local nPalLvl = DB.getValue(CharManager.getClassNode(nodeChar, 'Paladin'), "level")
	if nPalLvl and nPalLvl >= 2 then
		
	end
end
