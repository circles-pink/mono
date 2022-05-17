import React, { ReactElement, SetStateAction } from 'react';
import tw, { css, styled } from 'twin.macro';
import { TrustNode } from '@circles-pink/state-machine/output/CirclesCore';
import { Theme } from '../context/theme';
import { Claim } from './text';
import ReactTooltip from 'react-tooltip';
import {
  mdiAccountArrowLeft,
  mdiAccountArrowRight,
  mdiAccountCancel,
  mdiHeart,
  mdiHeartOutline,
  mdiCashFast,
  mdiCashRemove,
  mdiAt,
} from '@mdi/js';
import Icon from '@mdi/react';
import { darken } from '../onboarding/utils/colorUtils';
import { addrToString } from '@circles-pink/state-machine/output/Wallet.PrivateKey';
import {
  JustifyAroundCenter,
  JustifyBetweenCenter,
  JustifyStartCenter,
} from './helper';
import { RemoteReport } from '@circles-pink/state-machine/output/RemoteReport';
import { LoadingCircles } from './LoadingCircles';
import { MappedTrustNodes, UserData } from '../onboarding/views/Dashboard';
import {
  TrustAddResult,
  TrustRemoveResult,
} from '@circles-pink/state-machine/output/CirclesPink.Garden.StateMachine.State.Dashboard';
import {
  DefaultView,
  ErrTrustAddConnectionResolved,
} from '@circles-pink/state-machine/output/CirclesPink.Garden.StateMachine.State.Dashboard.Views';
import { t } from 'i18next';

type Overlay = 'SEND' | 'RECEIVE';

type TrustUserListProps = {
  title?: string;
  content: MappedTrustNodes;
  theme: Theme;
  icon: any;
  actionRow?: ReactElement | ReactElement[] | string;
  toggleOverlay?: (type: Overlay) => void;
  setOverwriteTo?: React.Dispatch<SetStateAction<string>>;
  addTrust: (to: string) => void;
  removeTrust: (to: string) => void;
  trustAddResult: DefaultView['trustAddResult'];
  trustRemoveResult: DefaultView['trustRemoveResult'];
};

export const TrustUserList = (props: TrustUserListProps) => {
  const { title, content, theme, icon, actionRow } = props;

  return (
    <Frame theme={theme}>
      <Title>
        <JustifyBetween>
          <Claim color={darken(theme.lightColor, 2)}>{title}</Claim>
          <Icon path={icon} size={1.5} color={darken(theme.lightColor, 2)} />
        </JustifyBetween>
      </Title>
      {actionRow}
      <TableContainer>
        <Table>
          {content.length > 0 && (
            <TableHeader>
              <TableRow theme={theme}>
                <TableHead>User</TableHead>
                <TableHead>
                  <JustifyAround>Relation</JustifyAround>
                </TableHead>
                <TableHead>
                  <JustifyAround>Action</JustifyAround>
                </TableHead>
              </TableRow>
            </TableHeader>
          )}

          <TableBody>
            {content.map((c, index) => {
              return (
                <ContentRow
                  key={addrToString(c.safeAddress)}
                  c={c}
                  {...props}
                />
              );
            })}
          </TableBody>
        </Table>
      </TableContainer>
    </Frame>
  );
};

// -----------------------------------------------------------------------------
// UI / ContentRow
// -----------------------------------------------------------------------------

const ContentRow = (
  props: TrustUserListProps & { c: TrustNode & UserData }
): ReactElement => {
  const {
    c,
    theme,
    toggleOverlay,
    setOverwriteTo,
    addTrust,
    removeTrust,
    trustAddResult,
    trustRemoveResult,
  } = props;

  const trustAddLoading = trustAddResult[addrToString(c.safeAddress)]
    ? trustIsLoading(trustAddResult[addrToString(c.safeAddress)])
    : false;

  const trustRemoveLoading = trustRemoveResult[addrToString(c.safeAddress)]
    ? trustIsLoading(trustRemoveResult[addrToString(c.safeAddress)])
    : false;

  return (
    <TableRow theme={theme}>
      <TableData>
        <JustifyStartCenter>
          <Icon path={mdiAt} size={1.5} color={theme.baseColor} />
          <b>{c.username}</b>
        </JustifyStartCenter>
      </TableData>
      <TableData>
        <ReactTooltip />
        <JustifyBetweenCenter>
          <Icon
            path={c.isIncoming ? mdiAccountArrowLeft : mdiAccountCancel}
            size={1.6}
            color={c.isIncoming ? theme.baseColor : 'white'}
            data-tip={mapToolTipRelationReceivable(c.isIncoming, c.username)}
          />
          <Icon
            path={c.isOutgoing ? mdiAccountArrowRight : mdiAccountCancel}
            size={1.6}
            color={c.isOutgoing ? theme.baseColor : 'white'}
            data-tip={mapToolTipRelationSendable(c.isOutgoing, c.username)}
          />
        </JustifyBetweenCenter>
      </TableData>
      <TableData>
        <JustifyBetweenCenter>
          <Clickable
            clickable={c.isOutgoing}
            onClick={() => {
              if (c.isOutgoing) {
                if (toggleOverlay && setOverwriteTo) {
                  setOverwriteTo(addrToString(c.safeAddress));
                  toggleOverlay('SEND');
                }
              }
            }}
          >
            <Icon
              path={c.isOutgoing ? mdiCashFast : mdiCashRemove}
              size={1.75}
              color={c.isOutgoing ? theme.baseColor : 'white'}
              data-tip={mapToolTipSend(c.isOutgoing, c.username)}
            />
          </Clickable>

          {!trustAddLoading && !trustRemoveLoading ? (
            <Clickable
              clickable={true}
              onClick={() => {
                if (!c.isIncoming) {
                  addTrust(addrToString(c.safeAddress));
                } else {
                  removeTrust(addrToString(c.safeAddress));
                }
              }}
            >
              <Icon
                path={c.isIncoming ? mdiHeart : mdiHeartOutline}
                size={1.5}
                color={c.isIncoming ? theme.baseColor : 'white'}
                data-tip={mapToolTipTrust(c.isIncoming, c.username)}
              />
            </Clickable>
          ) : (
            <LoadingCircles count={1} width={35} color={theme.baseColor} />
          )}
        </JustifyBetweenCenter>
      </TableData>
    </TableRow>
  );
};

// -----------------------------------------------------------------------------
// Util
// -----------------------------------------------------------------------------

const trustIsLoading = (
  result: RemoteReport<ErrTrustAddConnectionResolved, string>
) => {
  switch (result.type) {
    case 'loading':
      return true;
    default:
      return false;
  }
};

// -----------------------------------------------------------------------------
// Tooltip mapping
// -----------------------------------------------------------------------------

const replaceUsername = (str: string, user: string) =>
  str.replace(/{{user}}/, user);

const mapToolTipTrust = (trusted: boolean, user: string) => {
  if (trusted) {
    return replaceUsername(t('dashboard.trustList.untrust'), user);
  }
  return replaceUsername(t('dashboard.trustList.trust'), user);
};

const mapToolTipSend = (sendable: boolean, user: string) => {
  if (sendable) {
    return replaceUsername(t('dashboard.trustList.send'), user);
  }
  return replaceUsername(t('dashboard.trustList.canNotSend'), user);
};

const mapToolTipRelationSendable = (sendable: boolean, user: string) => {
  if (sendable) {
    return replaceUsername(t('dashboard.trustList.relationSendable'), user);
  }
  return replaceUsername(t('dashboard.trustList.relationNotSendable'), user);
};

const mapToolTipRelationReceivable = (receivable: boolean, user: string) => {
  if (receivable) {
    return replaceUsername(t('dashboard.trustList.relationReceivable'), user);
  }
  return replaceUsername(t('dashboard.trustList.relationNotReceivable'), user);
};

// -----------------------------------------------------------------------------
// UI / Frame
// -----------------------------------------------------------------------------

type FameProps = {
  theme: Theme;
};

const Frame = styled.div<FameProps>(({ theme }: FameProps) => [
  tw`block lg:p-8 md:p-8 p-4 border border-gray-800 shadow-xl rounded-xl`,
  css`
    background-color: ${theme.lightColor};
  `,
]);

// -----------------------------------------------------------------------------
// UI / Table
// -----------------------------------------------------------------------------

const TableContainer = tw.div`overflow-hidden overflow-x-auto border border-gray-100 rounded`;
const Table = tw.table`min-w-full text-sm divide-y divide-gray-200`;
const TableHeader = tw.thead`lg:px-4 md:px-4 px-2 lg:text-lg md:text-lg text-left whitespace-nowrap`;
const TableHead = tw.th`lg:px-4 md:px-4 px-2 text-left whitespace-nowrap`;
const TableBody = tw.tbody`divide-y divide-gray-100`;
const TableData = tw.td`lg:px-4 md:px-4 px-2 py-2 text-lg whitespace-nowrap`;

type TableRowProps = {
  theme: Theme;
};
const TableRow = styled.tr<TableRowProps>(({ theme }: TableRowProps) => [
  css`
    color: ${theme.darkColor};
  `,
]);

// -----------------------------------------------------------------------------
// UI
// -----------------------------------------------------------------------------
type ClickableProps = {
  clickable: boolean;
};
const Clickable = styled.div<ClickableProps>(({ clickable }) => [
  clickable ? tw`cursor-pointer` : tw`cursor-not-allowed`,
]);

const Title = tw.div`mb-4`;
const JustifyBetween = tw.div`flex justify-between`;
const JustifyAround = tw.div`flex justify-around`;
