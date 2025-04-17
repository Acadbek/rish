#!/bin/bash

# 1. Create Vite app with React + JS + SWC
npm create vite@latest . -- --template react-swc


# 3. Install TailwindCSS and plugin
npm install -D tailwindcss @tailwindcss/vite

# 4. Replace src/index.css
echo '@import "tailwindcss";' > src/index.css

# 5. Create jsconfig.json
cat <<EOL > jsconfig.json
{
  "compilerOptions": {
    "baseUrl": ".",
    "paths": {
      "@/*": ["./src/*"]
    }
  }
}
EOL

# 6. Overwrite vite.config.js completely
cat <<EOL > vite.config.js
import path from "path";
import tailwindcss from "@tailwindcss/vite";
import react from "@vitejs/plugin-react-swc";
import { defineConfig } from "vite";

// https://vite.dev/config/
export default defineConfig({
  plugins: [react(), tailwindcss()],
  resolve: {
    alias: {
      "@": path.resolve(__dirname, "./src"),
    },
  },
});
EOL

# 7. Init shadcn/ui (choose Zinc as default in prompt)
npx shadcn@latest init

# 8. Add a base UI component to verify setup
npx shadcn@latest add button

npm install react-router-dom

# Create router folder and index.jsx
mkdir -p src/router

cat <<EOL > src/router/index.jsx
import { Routes, Route } from "react-router-dom";

export default function AppRoutes() {
  return (
    <Routes>
      <Route path="/" element={<div className="text-2xl p-4">Home Page</div>} />
      <Route path="*" element={<div className="text-2xl p-4 text-red-500">404 - Page Not Found</div>} />
    </Routes>
  );
}
EOL

# Replace App.jsx to use router
cat <<EOL > src/App.jsx
import { BrowserRouter } from "react-router-dom";
import AppRoutes from "@/router";

function App() {
  return (
    <BrowserRouter>
      <AppRoutes />
    </BrowserRouter>
  );
}

export default App;
EOL

# 10. Delete app.css and remove assets logo
rm src/App.css
rm src/assets/react.svg
rm public/vite.svg


# 9. Open in VS Code
code .

echo "✅ Project setup done with shadcn/ui!"
