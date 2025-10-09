#!/bin/bash

set -e  # Exit on error

echo "================================================================"
echo "Vite 5 + React 19 + Tailwind 4 + Shadcn/ui + React Router Dom 7"
echo "================================================================"
echo ""
echo "tsx yoki jsx?"
echo "1) TypeScript (.tsx)"
echo "2) JavaScript (.jsx)"
echo ""
read -p "Raqamni kiriting (1 yoki 2): " CHOICE

if [ "$CHOICE" = "2" ]; then
    LANG="js"
    TEMPLATE="react-swc"
    CONFIG_FILE="jsconfig.json"
    VITE_CONFIG="vite.config.js"
    ROUTER_FILE="src/router/index.jsx"
    APP_FILE="src/App.jsx"
    echo "✅ JavaScript tanlandi"
elif [ "$CHOICE" = "1" ]; then
    LANG="ts"
    TEMPLATE="react-swc-ts"
    CONFIG_FILE="tsconfig.json"
    VITE_CONFIG="vite.config.ts"
    ROUTER_FILE="src/router/index.tsx"
    APP_FILE="src/App.tsx"
    echo "✅ TypeScript tanlandi"
else
    echo "❌ Noto'g'ri tanlov. 1 yoki 2 ni kiriting."
    exit 1
fi

echo ""
echo -n "🚀 Vite loyihasini yaratish..."
npm create vite@5 . -- --template $TEMPLATE > /dev/null 2>&1
echo " ✅"

echo -n "📦 Asosiy packagelarni o'rnatish..."
npm install > /dev/null 2>&1
echo " ✅"

echo -n "📦 TailwindCSS'ni o'rnatish..."
npm install -D tailwindcss @tailwindcss/vite > /dev/null 2>&1
echo " ✅"

echo -n "✏️  src/index.css'ni yangilash..."
echo '@import "tailwindcss";' > src/index.css
echo " ✅"

if [ "$LANG" = "js" ]; then
    echo -n "📝 jsconfig.json yaratish..."
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
    echo " ✅"
else
    echo -n "📝 tsconfig.json va tsconfig.app.json'ni yangilash..."
    
    # tsconfig.json yangilash
    cat <<EOL > tsconfig.json
{
  "files": [],
  "references": [
    { "path": "./tsconfig.app.json" },
    { "path": "./tsconfig.node.json" }
  ],
  "compilerOptions": {
    "baseUrl": ".",
    "paths": {
      "@/*": ["./src/*"]
    }
  }
}
EOL

    # tsconfig.app.json yangilash (asosiy config)
    if [ -f tsconfig.app.json ]; then
        # Yangi tsconfig.app.json yaratish
        cat <<EOL > tsconfig.app.json
{
  "compilerOptions": {
    "target": "ES2020",
    "useDefineForClassFields": true,
    "lib": ["ES2020", "DOM", "DOM.Iterable"],
    "module": "ESNext",
    "skipLibCheck": true,
    "baseUrl": ".",
    "paths": {
      "@/*": ["./src/*"]
    },
    "moduleResolution": "bundler",
    "allowImportingTsExtensions": true,
    "isolatedModules": true,
    "moduleDetection": "force",
    "noEmit": true,
    "jsx": "react-jsx",
    "strict": true,
    "noUnusedLocals": true,
    "noUnusedParameters": true,
    "noFallthroughCasesInSwitch": true,
    "noUncheckedSideEffectImports": true
  },
  "include": ["src"]
}
EOL
    fi
    echo " ✅"
fi

echo -n "⚙️  vite.config'ni yangilash..."
if [ "$LANG" = "js" ]; then
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
else
    cat <<EOL > vite.config.ts
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
fi
echo " ✅"

echo -n "🎨 shadcn/ui'ni o'rnatish..."
npx shadcn@latest init -y
echo " ✅"

echo -n "🔘 Button componentini qo'shish..."
npx shadcn@latest add button -y > /dev/null 2>&1
echo " ✅"

echo -n "🛣️  React Router DOM'ni o'rnatish..."
npm install react-router-dom > /dev/null 2>&1
echo " ✅"

echo -n "📁 Routelarni config qilish..."
mkdir -p src/router

if [ "$LANG" = "js" ]; then
    cat <<'EOL' > src/router/index.jsx
import { Routes, Route } from "react-router-dom";
import { Button } from "@/components/ui/button";

export default function AppRoutes() {
  return (
    <Routes>
      <Route path="/" element={<Button>Home page</Button>} />
      <Route path="*" element={<div className="text-2xl p-4 text-red-500">404 - Page Not Found</div>} />
    </Routes>
  );
}
EOL

    cat <<'EOL' > src/App.jsx
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
else
    cat <<'EOL' > src/router/index.tsx
import { Routes, Route } from "react-router-dom";
import { Button } from "@/components/ui/button";

export default function AppRoutes() {
  return (
    <Routes>
      <Route path="/" element={<Button>Home page</Button>} />
      <Route path="*" element={<div className="text-2xl p-4 text-red-500">404 - Page Not Found</div>} />
    </Routes>
  );
}
EOL

    cat <<'EOL' > src/App.tsx
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
fi
echo " ✅"

echo -n "🧹 Keraksiz fayllarni o'chirish..."
rm -f src/App.css
rm -f src/assets/react.svg
rm -f public/vite.svg
echo " ✅"

echo ""
echo "✅ Loyiha muvaffaqiyatli sozlandi!"
echo ""

echo "🚀 VS Code ochilmoqda..."

# .vscode papkasini yaratish
mkdir -p .vscode

# tasks.json yaratish - npm run dev uchun
cat <<'EOL' > .vscode/tasks.json
{
  "version": "2.0.0",
  "tasks": [
    {
      "label": "npm: dev",
      "type": "npm",
      "script": "dev",
      "problemMatcher": [],
      "isBackground": true,
      "presentation": {
        "reveal": "always",
        "panel": "new"
      },
      "runOptions": {
        "runOn": "folderOpen"
      }
    }
  ]
}
EOL

code .
