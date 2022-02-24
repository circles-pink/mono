import React, { ReactElement } from 'react';
import tw from 'twin.macro';

type DemoCardProps = {
  text: ReactElement;
  interaction?: ReactElement;
  control: ReactElement;
  debug?: ReactElement;
};

const Frame = tw.div`bg-gray-50 border-2 border-pink-500`;
const Card = tw.div`max-w-7xl mx-auto py-12 px-4 sm:px-6 lg:py-16 lg:px-8 lg:flex lg:items-center lg:justify-between`;
const Content = tw.div``;
const Control = tw.div`mt-8 flex lg:mt-0 lg:flex-shrink-0`;
const Debug = tw.div`p-8`;

export const DialogCard = ({
  text,
  interaction,
  control,
  debug,
}: DemoCardProps): ReactElement => {
  return (
    <>
      <Frame>
        <Card>
          <Content>
            {text}
            {interaction}
          </Content>
          <Control>{control}</Control>
        </Card>
      </Frame>
      <Debug>{debug}</Debug>
    </>
  );
};
