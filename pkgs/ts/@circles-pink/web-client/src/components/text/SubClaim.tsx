import tw, { css, styled } from 'twin.macro';

export const SubClaim = styled.p(() => [
  css`
    font-size: 1.15rem;
    font-weight: 600;
    padding: 0;
    margin: 1rem 0;
  `,
  tw`block text-gray-800`,
]);
