--Hero Soul
function c511000317.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)	
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
	e1:SetCondition(c511000317.condition)
	e1:SetOperation(c511000317.activate)
	c:RegisterEffect(e1)
end
function c511000317.condition(e,tp,eg,ep,ev,re,r,rp)
	local p=e:GetHandler():GetControler()
	local at=Duel.GetAttackTarget()
	local a=Duel.GetAttacker()
	return Duel.GetBattleDamage(p)>=Duel.GetLP(p) and ((at and at:IsSetCard(0x8) and at:IsControler(p)) or (a and a:IsSetCard(0x8) and a:IsControler(p))) 
end
function c511000317.activate(e,tp,eg,ep,ev,re,r,rp)
	local p=e:GetHandler():GetControler()
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PRE_BATTLE_DAMAGE)
	e1:SetOperation(c511000317.damop)
	e1:SetReset(RESET_PHASE+PHASE_DAMAGE)
	Duel.RegisterEffect(e1,p)
	Duel.SetLP(p,100,REASON_EFFECT)
end
function c511000317.damop(e,tp,eg,ep,ev,re,r,rp)
	Duel.ChangeBattleDamage(tp,0)
end
