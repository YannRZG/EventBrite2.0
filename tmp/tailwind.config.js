import flattenColorPalette from 'tailwindcss/lib/util/flattenColorPalette';
import forms from '@tailwindcss/forms';

function addVariablesForColors({ addBase, theme }) {
  let allColors = flattenColorPalette(theme("colors"));
  let newVars = Object.fromEntries(
    Object.entries(allColors).map(([key, val]) => [`--${key}`, val])
  );
  addBase({ ":root": newVars });
}

export default {
  content: [
    "./index.html",
    "./src/**/*.{js,jsx,ts,tsx}",
  ],
  darkMode: "class",
  theme: {
    extend: {
      fontFamily: {
        'chakra-petch': ['"Chakra Petch"', 'sans-serif'],
      },
      colors: {
        palegreen: {
          500: '#98FB98', 
          600: '#90EE90', 
        },
        beige: {
          200: '#ffdfa7',
        },
        turquoise: '#40E0D0',
      },
    },
  },
  plugins: [
    addVariablesForColors,
    forms,
  ],
}
