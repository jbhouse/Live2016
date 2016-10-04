--Earthbound God Chacu Challhua
function c511000262.initial_effect(c)
	c:SetUniqueOnField(1,1,10000000)
	--Can Attack Directly
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_DIRECT_ATTACK)
	e3:SetCondition(c511000262.havefieldcon)
	c:RegisterEffect(e3)
	--Unaffected by Spell and Trap Cards
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCode(EFFECT_IMMUNE_EFFECT)
	e4:SetCondition(c511000262.havefieldcon)
	e4:SetValue(c511000262.unaffectedval)
	c:RegisterEffect(e4)
	--Cannot be Battle Target
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetCode(EFFECT_CANNOT_BE_BATTLE_TARGET)
	e5:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e5:SetRange(LOCATION_MZONE)
	e5:SetValue(1)
	e5:SetCondition(c511000262.havefieldcon)
	c:RegisterEffect(e5)
	--Opponent Cannot Conduct his/her Battle Phase
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_FIELD)
	e6:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e6:SetCode(EFFECT_CANNOT_BP)
	e6:SetRange(LOCATION_MZONE)
	e6:SetTargetRange(0,1)
	e6:SetCondition(c511000262.nobattlephasecon)
	c:RegisterEffect(e6)
	--Damage Equal to the DEF
	local e7=Effect.CreateEffect(c)
	e7:SetDescription(aux.Stringid(511000262,0))
	e7:SetCategory(CATEGORY_DAMAGE)
	e7:SetType(EFFECT_TYPE_IGNITION)
	e7:SetRange(LOCATION_MZONE)
	e7:SetCountLimit(1)
	e7:SetCondition(c511000262.havefieldcon)
	e7:SetCost(c511000262.dmgcost)
	e7:SetTarget(c511000262.dmgtg)
	e7:SetOperation(c511000262.dmgop)
	c:RegisterEffect(e7)
	--Self Destroy During the End Phase
	local e8=Effect.CreateEffect(c)
	e8:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e8:SetProperty(CATEGORY_DESTROY)
	e8:SetRange(LOCATION_MZONE)
	e8:SetCountLimit(1)
	e8:SetCode(EVENT_PHASE+PHASE_END)
	e8:SetCondition(c511000262.nofieldcon)
	e8:SetOperation(c511000262.nofieldop)
	c:RegisterEffect(e8)
	--direct attack
	local e10=Effect.CreateEffect(c)
	e10:SetType(EFFECT_TYPE_FIELD)
	e10:SetCode(EFFECT_DIRECT_ATTACK)
	e10:SetRange(LOCATION_MZONE)
	e10:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e10:SetCondition(c511000262.havefieldcon)
	e10:SetTarget(c511000262.dirtg)
	c:RegisterEffect(e10)
end
function c511000262.dirfilter(c,card)
	return card~=c
end
function c511000262.dirtg(e,c)
	return not Duel.IsExistingMatchingCard(c511000262.dirfilter,c:GetControler(),0,LOCATION_MZONE,1,nil,e:GetHandler())
end
function c511000262.havefieldfilter(c)
	return c:IsFaceup() and c:IsType(TYPE_FIELD)
end
function c511000262.havefieldcon(e)
	return Duel.IsExistingMatchingCard(c511000262.havefieldfilter,0,LOCATION_SZONE,LOCATION_SZONE,1,e:GetHandler())
end
function c511000262.unaffectedval(e,te)
	return (te:IsActiveType(TYPE_SPELL) or te:IsActiveType(TYPE_TRAP)) and te:GetOwnerPlayer()~=e:GetHandlerPlayer()
end
function c511000262.nobattlephasecon(e)
	return e:GetHandler():IsPosition(POS_FACEUP_DEFENSE) and Duel.IsExistingMatchingCard(c511000262.havefieldfilter,0,LOCATION_SZONE,LOCATION_SZONE,1,e:GetHandler())
end
function c511000262.dmgcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():GetAttackAnnouncedCount()==0 end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CANNOT_ATTACK)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_OATH)
	e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
	e:GetHandler():RegisterEffect(e1)
end
function c511000262.dmgtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local Dmg=e:GetHandler():GetDefense()
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(Dmg/2)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,Dmg)
end
function c511000262.dmgop(e,tp,eg,ep,ev,re,r,rp)
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	Duel.Damage(p,e:GetHandler():GetDefense()/2,REASON_EFFECT)
end
function c511000262.nofieldcon(e)
	local f1=Duel.GetFieldCard(0,LOCATION_SZONE,5)
	local f2=Duel.GetFieldCard(1,LOCATION_SZONE,5)
	return (f1==nil or not f1:IsFaceup()) and (f2==nil or not f2:IsFaceup())
end
function c511000262.nofieldop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Destroy(e:GetHandler(),REASON_EFFECT)
end
