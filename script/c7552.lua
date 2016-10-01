--十二獣タイグリス
--Juunishishi Tigress
--Scripted by Eerie Code
function c7552.initial_effect(c)
	c:EnableReviveLimit()
	aux.AddXyzProcedure(c,nil,4,3,c7552.ovfilter,aux.Stringid(7552,0),3,c7552.xyzop)
	--
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetValue(c7552.atkval)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_UPDATE_DEFENSE)
	e2:SetValue(c7552.defval)
	c:RegisterEffect(e2)
	--
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(7552,1))
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetCost(c7552.matcost)
	e3:SetTarget(c7552.mattg)
	e3:SetOperation(c7552.matop)
	c:RegisterEffect(e3)
end

function c7552.ovfilter(c)
	return c:IsFaceup() and c:IsSetCard(0xf2) and not c:IsCode(7552)
end
function c7552.xyzop(e,tp,chk)
  if chk==0 then return Duel.GetFlagEffect(tp,7552)==0 end
  Duel.RegisterFlagEffect(tp,7552,RESET_PHASE+PHASE_END,0,1)
end

function c7552.adfil(c)
	return c:IsSetCard(0xf2) and c:IsType(TYPE_MONSTER)
end
function c7552.atkval(e,c)
	return c:GetOverlayGroup():Filter(c7552.adfil,nil):Filter(Card.IsAttackAbove,nil,1):GetSum(Card.GetAttack)
end
function c7552.defval(e,c)
	return c:GetOverlayGroup():Filter(c7552.adfil,nil):Filter(Card.IsDefenseAbove,nil,1):GetSum(Card.GetDefense)
end

function c7552.matcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c7552.tgfilter(c)
	return c:IsFaceup() and c:IsType(TYPE_XYZ)
end
function c7552.mfilter(c)
	return c:IsSetCard(0xf2) and c:IsType(TYPE_MONSTER)
end
function c7552.mattg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return Duel.IsExistingTarget(c7552.tgfilter,tp,LOCATION_MZONE,0,1,nil)
		and Duel.IsExistingTarget(c7552.mfilter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g1=Duel.SelectTarget(tp,c7552.tgfilter,tp,LOCATION_MZONE,0,1,1,nil)
	e:SetLabelObject(g1:GetFirst())
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_XMATERIAL)
	local g2=Duel.SelectTarget(tp,c7552.mfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_LEAVE_GRAVE,g2,1,0,0)
end
function c7552.matop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local tc=e:GetLabelObject()
	if tc:IsFacedown() or not tc:IsRelateToEffect(e) or tc:IsImmuneToEffect(e) then return end
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,tc,e)
	if g:GetCount()>0 then
		Duel.Overlay(tc,g)
	end
end