--超銀河眼の光波龍
--Neo Galaxy-Eyes Cipher Dragon
--Scripted by Eerie Code
--Credits to sahim for the cost section
function c7549.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,9,3)
	c:EnableReviveLimit()
	--control
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_CONTROL)
	e1:SetDescription(aux.Stringid(7549,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetCountLimit(1)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c7549.condition)
    	e1:SetCost(c7549.cost)
    	e1:SetTarget(c7549.target)
	e1:SetOperation(c7549.operation)
	c:RegisterEffect(e1)
end

function c7549.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetOverlayGroup():IsExists(Card.IsSetCard,1,nil,0xe5)
end
function c7549.fil(c)
	return c:IsFaceup() and c:IsControlerCanBeChanged()
end
function c7549.cost(e,tp,eg,ep,ev,re,r,rp,chk)
    local c=e:GetHandler()
    local max1=Duel.GetMatchingGroupCount(c7549.filter,tp,0,LOCATION_MZONE,nil)
    local max2=Duel.GetLocationCount(tp,LOCATION_MZONE)
    local max3=math.min(max1,max2,3)    
    if chk==0 then return c:CheckRemoveOverlayCard(tp,1,REASON_COST) and max3>0 end
    local before=c:GetOverlayCount()
    c:RemoveOverlayCard(tp,1,max3,REASON_COST)
    e:SetLabel(before-c:GetOverlayCount())
end
function c7549.target(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return true end
    Duel.SetOperationInfo(0,CATEGORY_CONTROL,nil,e:GetLabel(),0,0)
end
function c7549.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local lbl=e:GetLabel()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_DIRECT_ATTACK)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetTarget(c7549.atktg)
	e1:SetLabel(e:GetHandler():GetFieldID())
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
	local lc=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if lc<lbl then return end
	local tg=Duel.SelectMatchingCard(tp,c7549.fil,tp,0,LOCATION_MZONE,lbl,lbl,nil)
	local tc=tg:GetFirst()
	while tc do
		Duel.GetControl(tc,tp,PHASE_END,1)
		Duel.NegateRelatedChain(tc,RESET_TURN_SET)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_DISABLE)
		e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e2)
		local e3=Effect.CreateEffect(c)
		e3:SetType(EFFECT_TYPE_SINGLE)
		e3:SetCode(EFFECT_DISABLE_EFFECT)
		e3:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e3)
		local e4=Effect.CreateEffect(c)
		e4:SetType(EFFECT_TYPE_SINGLE)
		e4:SetCode(EFFECT_SET_ATTACK_FINAL)
		e4:SetValue(4500)
		e4:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e4)
		local e5=Effect.CreateEffect(c)
		e5:SetType(EFFECT_TYPE_SINGLE)
		e5:SetCode(EFFECT_CHANGE_CODE)
		e5:SetValue(7549)
		e5:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e5)
		tc=tg:GetNext()
	end
end
function c7549.atktg(e,c)
	return e:GetLabel()~=c:GetFieldID()
end
