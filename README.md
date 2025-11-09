# Rish - React Starter Template

A blazing fast React + TailwindCSS + React Router Dom + Shadcn UI starter template — ready in 10 seconds!

## 🚀 Features

- **Vite 5** - Lightning-fast build tool
- **React 19** - Latest React version with SWC compiler
- **Tailwind CSS 4** - Modern utility-first CSS framework
- **Shadcn/ui** - Beautiful and accessible component library
- **React Router DOM 7** - Client-side routing
- **TypeScript or JavaScript** - Choose your preferred language
- **Path Aliases** - Clean imports with `@/` prefix
- **VS Code Integration** - Auto-configured dev server on folder open
- **Clean Setup** - Removes unnecessary default files

## 📋 Prerequisites

- **Node.js** 18+ installed
- **npm** package manager
- **VS Code** (optional, for automatic dev server)

## ⚡ Quick Start

Just run:

```bash
npx rish
```

That's it! Your React project will be ready in seconds.

## 🎯 Usage

### One-Line Setup

```bash
npx rish
```

The CLI will guide you through:
1. **Project name** - Enter name or `.` for current directory
2. **Language** - Choose TypeScript or JavaScript

## 💡 Interactive Setup

When you run the script, it will ask you two questions:

### 1. Project Name

```
📁 Project name: 
```

**Options:**
- Enter a project name (e.g., `my-awesome-app`) - Creates a new folder
- Enter `.` (dot) - Installs in the current folder
- If the folder exists - Installs inside it

**Examples:**

```bash
# Create new project
$ npx rish
📁 Project name: my-react-app

# Use current directory
$ npx rish
📁 Project name: .

# Install in existing folder
$ mkdir my-project && npx rish
📁 Project name: my-project
```

## 🗂️ Project Structure

```
.
├── public/
├── src/
│   ├── components/
│   │   └── ui/
│   │       └── button.tsx        # Pre-installed Shadcn component
│   ├── router/
│   │   └── index.tsx              # 🎯 Routing lives here
│   ├── App.tsx                    # Main app component
│   ├── index.css                  # 🎨 Preloaded with Tailwind
│   └── main.tsx                   # Entry point
├── .vscode/
│   └── tasks.json                 # Auto-start dev server
├── tsconfig.json / jsconfig.json  # 🔧 With @ alias
├── vite.config.ts                 # ⚡ Alias + plugins setup
├── components.json                # Shadcn/ui config
└── package.json
```

### ✨ What's Different?

- ✅ **Cleaned** - Removed unused `App.css`
- ✅ **Deleted** - Default `react.svg` and `vite.svg`
- ✅ **Configured** - `@` alias points to `./src`
- ✅ **Router Ready** - Default route `/` and 404 page pre-added

## ⚙️ Configuration Details

### Path Aliases

Import components using the `@/` prefix:

```tsx
// ✅ Clean imports
import { Button } from "@/components/ui/button";
import AppRoutes from "@/router";

// ❌ Instead of
import { Button } from "../../components/ui/button";
```

### Tailwind CSS

Configured with the latest Tailwind CSS 4 syntax:

```css
/* src/index.css */
@import "tailwindcss";
```

### React Router

Pre-configured with basic routing:

```tsx
<Routes>
  <Route path="/" element={<HomePage/>} />
  <Route path="*" element={<div>404 - Page Not Found</div>} />
</Routes>
```

### VS Code Auto-Start

The script creates `.vscode/tasks.json` to automatically run `npm run dev` when you open the project in VS Code.

## 🎨 Adding More Shadcn/ui Components

After setup, you can add more components:

```bash
# Add specific components
npx shadcn@latest add card
npx shadcn@latest add input
npx shadcn@latest add dialog

# See all available components
npx shadcn@latest add
```

## 🛠️ Development

Start the development server:

```bash
npm run dev
```

Build for production:

```bash
npm run build
```

Preview production build:

```bash
npm run preview
```

## 📝 Script Workflow

1. **Project Setup**
   - Asks for project name
   - Creates/navigates to folder
   
2. **Language Selection**
   - TypeScript or JavaScript
   
3. **Vite Installation**
   - Creates Vite project with React template
   
4. **Package Installation**
   - Installs all core dependencies
   
5. **Tailwind Configuration**
   - Installs and configures Tailwind CSS 4
   
6. **TypeScript Configuration** (if selected)
   - Sets up path aliases
   - Configures strict type checking
   
7. **Vite Configuration**
   - Adds path alias support
   - Configures Tailwind plugin
   
8. **Shadcn/ui Setup**
   - Initializes Shadcn/ui
   - Adds Button component
   
9. **Router Configuration**
   - Installs React Router DOM
   - Creates route structure
   - Configures basic routes
   
10. **Cleanup**
    - Removes unnecessary default files
    
11. **VS Code Integration**
    - Creates tasks.json for auto-start
    - Opens project in VS Code

## 🔧 Customization

### Modify Default Route

Edit `src/router/index.tsx`:

```tsx
export default function AppRoutes() {
  return (
    <Routes>
      <Route path="/" element={<HomePage />} />
      <Route path="/about" element={<AboutPage />} />
      <Route path="*" element={<NotFound />} />
    </Routes>
  );
}
```

### Add More Tailwind Plugins

Edit `vite.config.ts`:

```ts
export default defineConfig({
  plugins: [
    react(), 
    tailwindcss()
    // Add more plugins here
  ],
});
```

### Disable Auto-Start in VS Code

Delete or modify `.vscode/tasks.json`:

```json
{
  "runOptions": {
    "runOn": "folderOpen"  // Remove this line
  }
}
```

## 🐛 Troubleshooting

### "npm: command not found"

Install Node.js from [nodejs.org](https://nodejs.org/)

### "Permission denied"

This shouldn't happen with `npx`, but if it does:

```bash
npx clear-npx-cache
npx rish
```

### "Port already in use"

Vite uses port 5173 by default. Change it in `package.json`:

```json
{
  "scripts": {
    "dev": "vite --port 3000"
  }
}
```

### Path aliases not working in VS Code

Make sure VS Code is using the workspace TypeScript version:
1. Open any `.ts/.tsx` file
2. Click TypeScript version in bottom right
3. Select "Use Workspace Version"

## 🔗 Links

- **NPM Package**: [npmjs.com/package/rish](https://www.npmjs.com/package/rish)
- **GitHub Repository**: [github.com/acadbek/rish](https://github.com/acadbek/rish)
- **Issues**: [github.com/acadbek/rish/issues](https://github.com/acadbek/rish/issues)
- **Pull Requests**: [github.com/acadbek/rish/pulls](https://github.com/acadbek/rish/pulls)

## 📄 License

MIT License - Feel free to use this for any project!

## 🤝 Contributing

Contributions are welcome! Feel free to:
- Report bugs via [Issues](https://github.com/acadbek/rish/issues)
- Suggest new features
- Submit [Pull Requests](https://github.com/acadbek/rish/pulls)

## 💖 Support

If you find this tool helpful, please consider:
- ⭐ Starring the [GitHub repository](https://github.com/acadbek/rish)
- 🐦 Sharing it with other developers
- 🤝 Contributing to make it better

---

**Made with ❤️ by [Acadbek](https://github.com/acadbek)**
