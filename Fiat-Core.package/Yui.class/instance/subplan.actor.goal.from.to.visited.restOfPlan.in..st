subplanning
subplan: aPlan actor: anActor goal: aGoal from: startS to: endS visited: visitedStates restOfPlan: restOfPlan in: aWorld
	"do we need to check that were not done befor econtinuing to plan?"

	<todo>
	| done acting addressee speak |
	addressee := SKVar tag: #addressee.
	done := startS === endS & (aPlan === restOfPlan).
	speak := (self speaker: anActor addressee: addressee) & (self
		speechAct: aPlan
		speaker: anActor
		addressee: addressee
		from: startS
		to: endS
		restOfPlan: restOfPlan
		visited: visitedStates
		in: aWorld).
	acting := aPlan
		carCdrIn: [ :step :plan | 
			step
				carCdrIn: [ :act :st | 
					act
						car: anActor
						cdrIn: [ :a | 
							(self
								subplan: plan
								actor: anActor
								goal: aGoal
								from: st
								to: endS
								visited: (visitedStates add: st)
								restOfPlan: restOfPlan
								in: aWorld) & (visitedStates nembero: st) & (self planStep: a from: startS to: st in: aWorld) ] ] ].
	^ done | acting | speak