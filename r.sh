#!/bin/bash

set -e  # Exit on error

echo "================================================================"
echo "Vite 5 + React 19 + Tailwind 4 + Shadcn/ui + React Router Dom 7"
echo "================================================================"
echo ""

# Ask for project name
read -p "📁 Project name: " PROJECT_NAME

# If not dot and not empty
if [ "$PROJECT_NAME" != "." ] && [ -n "$PROJECT_NAME" ]; then
    # If folder doesn't exist - create it
    if [ ! -d "$PROJECT_NAME" ]; then
        echo "📂 Creating '$PROJECT_NAME' folder..."
        mkdir -p "$PROJECT_NAME"
    else
        echo "📂 Folder '$PROJECT_NAME' exists, installing inside..."
    fi
    cd "$PROJECT_NAME"
    echo "✅ Moved to '$PROJECT_NAME'"
elif [ "$PROJECT_NAME" = "." ]; then
    echo "✅ Using current folder"
else
    echo "❌ Project name cannot be empty"
    exit 1
fi

echo ""
echo "tsx or jsx?"
echo "1) TypeScript (.tsx)"
echo "2) JavaScript (.jsx)"
echo ""
read -p "Enter 1 or 2: " CHOICE

if [ "$CHOICE" = "2" ]; then
    LANG="js"
    TEMPLATE="react-swc"
    CONFIG_FILE="jsconfig.json"
    VITE_CONFIG="vite.config.js"
    ROUTER_FILE="src/router/index.jsx"
    APP_FILE="src/App.jsx"
    echo "✅ JavaScript selected"
elif [ "$CHOICE" = "1" ]; then
    LANG="ts"
    TEMPLATE="react-swc-ts"
    CONFIG_FILE="tsconfig.json"
    VITE_CONFIG="vite.config.ts"
    ROUTER_FILE="src/router/index.tsx"
    APP_FILE="src/App.tsx"
    echo "✅ TypeScript selected"
else
    echo "❌ Invalid choice. Enter 1 or 2."
    exit 1
fi

echo ""
echo -n "🚀 Creating Vite project..."
npm create vite@5 . -- --template $TEMPLATE > /dev/null 2>&1
echo " ✅"

echo -n "📦 Installing packages..."
npm install > /dev/null 2>&1
echo " ✅"

echo -n "📦 Installing TailwindCSS..."
npm install -D tailwindcss @tailwindcss/vite > /dev/null 2>&1
echo " ✅"

echo -n "✏️  Updating src/index.css..."
echo '@import "tailwindcss";' > src/index.css
echo " ✅"

if [ "$LANG" = "js" ]; then
    echo -n "📝 Creating jsconfig.json..."
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
    echo -n "📝 Updating tsconfig files..."
    
    # Update tsconfig.json
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

    # Update tsconfig.app.json
    if [ -f tsconfig.app.json ]; then
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

echo -n "⚙️  Updating vite.config..."
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

echo -n "🎨 Installing shadcn/ui..."
npx shadcn@latest init -y
echo " ✅"

echo -n "🔘 Adding Button component..."
npx shadcn@latest add button -y > /dev/null 2>&1
echo " ✅"

echo -n "🛣️  Installing React Router..."
npm install react-router-dom > /dev/null 2>&1
echo " ✅"

echo -n "📁 Setting up routes..."
mkdir -p src/router
mkdir -p src/pages/home

if [ "$LANG" = "js" ]; then
    # HomePage component
    cat <<'EOL' > src/pages/home/index.jsx
import { Button } from "@/components/ui/button";

export default function HomePage() {
  return (
    <div className="min-h-screen flex items-center justify-center">
      <Button>Click</Button>
    </div>
  );
}
EOL

    cat <<'EOL' > src/router/index.jsx
import { Routes, Route } from "react-router-dom";
import HomePage from "@/pages/home";

export default function AppRoutes() {
  return (
    <Routes>
      <Route path="/" element={<HomePage />} />
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
    # HomePage component (TypeScript)
    cat <<'EOL' > src/pages/home/index.tsx
import { Button } from "@/components/ui/button";

export default function HomePage() {
  return (
    <div className="min-h-screen flex items-center justify-center">
      <Button>Click</Button>
    </div>
  );
}
EOL

    cat <<'EOL' > src/router/index.tsx
import { Routes, Route } from "react-router-dom";
import HomePage from "@/pages/home";

export default function AppRoutes() {
  return (
    <Routes>
      <Route path="/" element={<HomePage />} />
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

echo -n "🧹 Cleaning up..."
rm -f src/App.css
rm -f src/assets/react.svg
rm -f public/vite.svg
echo " ✅"

echo ""
echo "✅ Project setup complete!"
echo ""

echo "🚀 Opening VS Code..."

# Create .vscode folder
mkdir -p .vscode

# Create tasks.json for auto dev server
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
