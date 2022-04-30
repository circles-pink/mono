import * as A from 'generated/output/CirclesPink.Garden.StateMachine.Action';
import { unit } from 'generated/output/Data.Unit';
import React, { ReactElement, useContext, useState } from 'react';
import { Button, Input } from '../../components/forms';
import { Claim, SubClaim, Text } from '../../components/text';
import { DialogCard } from '../../components/DialogCard';
import { FadeIn } from 'anima-react';
import { Orientation } from 'anima-react/dist/components/FadeIn';
import { LoginState } from 'generated/output/CirclesPink.Garden.StateMachine.State';
import { getIncrementor } from '../utils/getCounter';
import { t } from 'i18next';
import { ThemeContext } from '../../context/theme';
import { RemoteData } from 'generated/output/RemoteData';
import { ButtonState } from '../../components/forms/Button';

type LoginProps = {
  state: LoginState;
  act: (ac: A.CirclesAction) => void;
};

const mapResult = <E, A>(remoteData: RemoteData<E, A>): ButtonState => {
  switch (remoteData.type) {
    case 'failure':
      return 'enabled';
    case 'success':
      return 'enabled';
    case 'loading':
      return 'loading';
    case 'notAsked':
      return 'enabled';
  }
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
            type="text"
            value={state.magicWords}
            placeholder={t('login.magicWordsPlaceholder')}
            onChange={e => act(A._login(A._setMagicWords(e.target.value)))}
            onKeyPress={e => e.key === 'Enter' && act(A._login(A._login(unit)))}
          />
        </FadeIn>
      }
      control={
        <FadeIn orientation={orientation} delay={getDelay()}>
          <>
            <Button
              prio={'high'}
              color={theme.baseColor}
              state={mapResult(state.loginResult)}
              onClick={() => act(A._login(A._login(unit)))}
            >
              {t('signInButton')}
            </Button>
            <Button
              prio={'medium'}
              color={theme.baseColor}
              onClick={() => act(A._login(A._signUp(unit)))}
            >
              {t('signUpInsteadButton')}
            </Button>
          </>
        </FadeIn>
      }
    />
  );
};