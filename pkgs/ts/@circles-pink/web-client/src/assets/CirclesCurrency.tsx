import React from 'react';

type CirclesCurrencyProps = {
  color?: string;
};

export const CirclesCurrency = ({ color }: CirclesCurrencyProps) => {
  return (
    <svg
      width="24"
      height="34"
      fill={color || 'black'}
      xmlns="http://www.w3.org/2000/svg"
      className="MuiSvgIcon-root jss41"
      focusable="false"
      viewBox="0 0 24 34"
      aria-hidden="true"
    >
      <path d="M10.86 17.85c-.287-1.614-.084-2.888.609-3.82.725-.98 1.82-1.598 3.288-1.854 1.427-.25 2.626-.054 3.598.587 1.012.634 1.665 1.778 1.959 3.431.286 1.614.067 2.91-.658 3.89-.726.979-1.782 1.59-3.17 1.832-1.427.25-2.65.038-3.668-.636-1.02-.673-1.672-1.817-1.958-3.43z"></path>
      <path d="M15.487 2.521c-2.657 0-4.936.6-6.838 1.799-1.902 1.169-3.366 2.817-4.392 4.945-.997 2.098-1.495 4.541-1.495 7.329 0 2.877.453 5.395 1.359 7.553.905 2.128 2.264 3.776 4.075 4.945 1.842 1.17 4.121 1.754 6.838 1.754 1.57 0 3.004-.12 4.302-.36 1.328-.24 2.581-.54 3.758-.9v2.249c-1.117.42-2.34.75-3.668.989-1.328.24-2.883.36-4.664.36-3.26 0-5.992-.69-8.196-2.068-2.174-1.38-3.819-3.313-4.936-5.8C.543 22.828 0 19.92 0 16.594c0-3.177.604-5.995 1.811-8.453C3.05 5.654 4.815 3.705 7.11 2.297 9.434.888 12.242.184 15.532.184c3.14 0 5.962.584 8.468 1.753L22.959 4.23c-2.325-1.14-4.816-1.709-7.472-1.709z"></path>
    </svg>
  );
};
