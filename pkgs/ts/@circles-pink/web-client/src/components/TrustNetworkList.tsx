import React from 'react';
import tw, { css, styled } from 'twin.macro';
import { TrustNode } from 'generated/output/CirclesCore';
import { Theme } from '../context/theme';
import { Claim } from './text';
import {
  mdiAccountArrowLeft,
  mdiAccountArrowRight,
  mdiAccountCancel,
  mdiLan,
} from '@mdi/js';
import Icon from '@mdi/react';

type TrustNetworkListProps = {
  title?: string;
  content: TrustNode[];
  theme: Theme;
};

export const TrustNetworkList = ({
  title,
  content,
  theme,
}: TrustNetworkListProps) => {
  return (
    <Frame theme={theme}>
      <JustifyBetween>
        <Claim color={'white'}>{title}</Claim>
        <Icon path={mdiLan} size={1.5} color={'white'} />
      </JustifyBetween>
      <TableContainer>
        <Table>
          <TableHeader>
            <TableRow theme={theme}>
              <TableHead>User</TableHead>
              <TableHead>Safe Address</TableHead>
              <TableHead>
                <JustifyAround>You Can Receive</JustifyAround>
              </TableHead>
              <TableHead>
                <JustifyAround>You Can Send</JustifyAround>
              </TableHead>
              <TableHead>
                <JustifyAround>Transferable</JustifyAround>
              </TableHead>
            </TableRow>
          </TableHeader>

          <TableBody>
            {content.map((c, index) => {
              return (
                <TableRow theme={theme} key={index}>
                  <TableData>x</TableData>
                  <TableData>{c.safeAddress}</TableData>
                  <TableData>
                    <JustifyAround>
                      <Icon
                        path={
                          c.isIncoming ? mdiAccountArrowLeft : mdiAccountCancel
                        }
                        size={1.5}
                        color={c.isIncoming ? theme.baseColor : 'white'}
                      />
                    </JustifyAround>
                  </TableData>
                  <TableData>
                    <JustifyAround>
                      <Icon
                        path={
                          c.isOutgoing ? mdiAccountArrowRight : mdiAccountCancel
                        }
                        size={1.5}
                        color={c.isOutgoing ? theme.baseColor : 'white'}
                      />
                    </JustifyAround>
                  </TableData>
                  <TableData>
                    <JustifyAround>y €</JustifyAround>
                  </TableData>
                </TableRow>
              );
            })}
          </TableBody>
        </Table>
      </TableContainer>
    </Frame>
  );
};

// -----------------------------------------------------------------------------
// UI / Frame
// -----------------------------------------------------------------------------

type FameProps = {
  theme: Theme;
};

const Frame = styled.div<FameProps>(({ theme }: FameProps) => [
  tw`block p-8 border border-gray-800 shadow-xl rounded-xl text-white m-2`,
  css`
    background-color: ${theme.lightColor};
  `,
]);

// -----------------------------------------------------------------------------
// UI / Table
// -----------------------------------------------------------------------------

const TableContainer = tw.div`overflow-hidden overflow-x-auto border border-gray-100 rounded`;
const Table = tw.table`min-w-full text-sm divide-y divide-gray-200`;
const TableHeader = tw.thead`px-4 py-2 font-medium text-left whitespace-nowrap`;
const TableHead = tw.th`px-4 py-2 font-medium text-left whitespace-nowrap`;
const TableBody = tw.tbody`divide-y divide-gray-100`;
const TableData = tw.td`px-4 py-2 whitespace-nowrap`;

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

const JustifyBetween = tw.div`flex justify-between`;
const JustifyAround = tw.div`flex justify-around`;