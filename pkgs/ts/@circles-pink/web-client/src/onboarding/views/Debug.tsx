import * as A from '@circles-pink/state-machine/output/CirclesPink.Garden.StateMachine.Action';
import { unit } from '@circles-pink/state-machine/output/Data.Unit';
import React, { ReactElement, useContext, useState } from 'react';
import { Button, Input } from '../../components/forms';
import { Claim, SubClaim, Text } from '../../components/text';
import { DialogCard } from '../../components/DialogCard';
import { FadeIn } from 'anima-react';
import { Orientation } from 'anima-react/dist/components/FadeIn';
import { DebugState } from '@circles-pink/state-machine/output/CirclesPink.Garden.StateMachine.State';
import { getIncrementor } from '../utils/getCounter';
import { t } from 'i18next';
import { ThemeContext } from '../../context/theme';
import { TwoButtonRow } from '../../components/helper';

type DebugProps = {
  state: DebugState;
  act: (ac: A.CirclesAction) => void;
};

export const Debug = ({ state, act }: DebugProps): ReactElement => {
  const [theme] = useContext(ThemeContext);
  const orientation: Orientation = 'up';
  const getDelay = getIncrementor(0, 0.05);

  return (
    <DialogCard
      text={
        <Text>
          <FadeIn orientation={orientation} delay={getDelay()}>
            <Claim color={theme.baseColor}>{t('debug.claim')}</Claim>
          </FadeIn>

          <FadeIn orientation={orientation} delay={getDelay()}>
            <SubClaim>{t('debug.subClaim')}</SubClaim>
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
            placeholder={t('debug.magicWordsPlaceholder')}
            onChange={e => act(A._debug(A._setMagicWords(e.target.value)))}
            onKeyPress={e =>
              e.key === 'Enter' && act(A._debug(A._coreToWindow(unit)))
            }
          />
        </FadeIn>
      }
      control={
        <FadeIn orientation={orientation} delay={getDelay()}>
          <TwoButtonRow>
            <Button
              color={theme.baseColor}
              onClick={() => act(A._debug(A._coreToWindow(unit)))}
            >
              {t('debugButton')}
            </Button>
          </TwoButtonRow>
        </FadeIn>
      }
      debug={<pre>{JSON.stringify(state, null, 2)}</pre>}
    />
  );
};
