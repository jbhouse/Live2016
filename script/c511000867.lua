--Wave Wall
function c511000867.initial_effect(c)
	--negate
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(511000867,0))
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EVENT_ATTACK_ANNOUNCE)
	e2:SetLabel(0)
	e2:SetCondition(c511000867.condition)
	e2:SetOperation(c511000867.activate)
	c:RegisterEffect(e2)
	--reset
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e3:SetCode(EVENT_PHASE+PHASE_BATTLE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1)
	e3:SetCondition(c511000867.rescon)
	e3:SetOperation(c511000867.resop)
	e3:SetLabelObject(e2)
	c:RegisterEffect(e3)
end
function c511000867.filter(c)
	return c:IsFaceup() and c:IsType(TYPE_SYNCHRO)
end
function c511000867.condition(e,tp,eg,ep,ev,re,r,rp)
	local ct=Duel.GetMatchingGroupCount(c511000867.filter,tp,LOCATION_MZONE,0,nil)
	return not e:GetHandler():IsStatus(STATUS_CHAINING) and tp~=Duel.GetTurnPlayer() and ct>0 and e:GetLabel()<ct
end
function c511000867.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateAttack()
	local ct=e:GetLabel()
	ct=ct+1
	e:SetLabel(ct)
end
function c511000867.rescon(e)
	return e:GetLabelObject():GetLabel()>0
end
function c511000867.resop(e,tp,eg,ep,ev,re,r,rp)
	e:GetLabelObject():SetLabel(0)
end
