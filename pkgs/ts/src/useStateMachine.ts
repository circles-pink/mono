import React, { useState } from 'react';
import { Unit } from '../../../generated/output/Data.Unit';
import { Aff } from '../../../generated/output/Effect.Aff';
import { Effect } from '../../../output/Effect';

export type StateMachine<S, M> = (setState: (st: S) => Aff<Unit>) => (msg: M) => (s: S) => Effect<Unit>

export const useStateMachine = <S, M>(initState: S, stateMachine: StateMachine<S, M>): [S, (m: M) => void] => {
    const [state, setState] = useState(initState);

    return [state, 1 as any]
}
