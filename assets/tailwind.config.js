const colors = require("tailwindcss/colors");

module.exports = {
  content: ["./js/**/*.js", "../lib/*_web.ex", "../lib/*_web/**/*.*ex"],
  theme: {
    extend: {
      colors: {
        positive: colors.green,
        critical: colors.red,
        primary: colors.blue,
        neutral: colors.gray,
      },
    },
  },
  plugins: [require("a17t")],
};
