import * as A from '@circles-pink/state-machine/output/CirclesPink.Garden.StateMachine.Action';
import { unit } from '@circles-pink/state-machine/output/Data.Unit';
import React, { ReactElement, useContext, useState } from 'react';
import { Button, Input } from '../../components/forms';
import { Claim, SubClaim, Text } from '../../components/text';
import { DialogCard } from '../../components/DialogCard';
import { FadeIn } from 'anima-react';
import { Orientation } from 'anima-react/dist/components/FadeIn';
import { LoginState } from '@circles-pink/state-machine/output/CirclesPink.Garden.StateMachine.State.Login';
import { getIncrementor } from '../utils/getCounter';
import { t } from 'i18next';
import { ThemeContext } from '../../context/theme';
import { RemoteData } from '@circles-pink/state-machine/output/RemoteData';
import { ButtonState } from '../../components/forms/Button';
import { mapResult } from '../utils/mapResult';
import { TwoButtonRow } from '../../components/helper';
import tw from 'twin.macro';
import { StateMachineDebugger } from '../../components/StateMachineDebugger';

type LoginProps = {
  state: LoginState;
  act: (ac: A.CirclesAction) => void;
};

export const Login = ({ state, act }: LoginProps): ReactElement => {
  const [theme] = useContext(ThemeContext);
  const orientation: Orientation = 'up';
  const getDelay = getIncrementor(0, 0.05);

  return (
    <DialogCard
      text={
        <Text>
          <FadeIn orientation={orientation} delay={getDelay()}>
            <Claim color={theme.baseColor}>{t('login.claim')}</Claim>
          </FadeIn>

          <FadeIn orientation={orientation} delay={getDelay()}>
            <SubClaim>{t('login.subClaim')}</SubClaim>
          </FadeIn>
        </Text>
      }
      interaction={
        <FadeIn orientation={orientation} delay={getDelay()}>
          <Input
            autoFocus
            // indicatorColor={mapIndicatorColors(state.usernameApiResult)}
            type="password"
            value={state.magicWords}
            placeholder={t('login.magicWordsPlaceholder')}
            onChange={e => act(A._login(A._setMagicWords(e.target.value)))}
            onKeyPress={e => e.key === 'Enter' && act(A._login(A._login(unit)))}
          />
        </FadeIn>
      }
      control={
        <FadeIn orientation={orientation} delay={getDelay()}>
          <TwoButtonRow>
            <Button
              prio={'high'}
              theme={theme}
              state={mapResult(state.loginResult)}
              onClick={() => act(A._login(A._login(unit)))}
            >
              {t('signInSubmitButton')}
            </Button>
            <Button
              prio={'medium'}
              theme={theme}
              onClick={() => act(A._login(A._signUp(unit)))}
            >
              {t('signUpInsteadButton')}
            </Button>
          </TwoButtonRow>
        </FadeIn>
      }
      debug={<StateMachineDebugger state={state} />}
    />
  );
};
