## 🅰️ Angular/TypeScript Debugging Setup

### Prerequisites
1. Install `js-debug-adapter` via Mason: `:Mason` → search "js-debug-adapter"
2. **Important**: Open Neovim from your Angular project root (where `angular.json` is), not from `src/`
3. Ensure your `angular.json` has sourcemaps enabled:
   ```json
   "serve": {
     "options": {
       "sourceMap": true
     }
   }
   ```

### Debugging Workflow
1. **Start Angular dev server**: `ng serve` (keep it running!)
2. **Open a TypeScript component file** (`.ts`, not `.html` templates)
3. **Set breakpoints**: `<leader>b` on the lines you want to debug
4. **Start debugger**: Press `<F8>` → select "Debug Angular App"
5. **Chrome opens** → navigate to trigger your breakpointed code
6. **Debug normally**: Use `<F10>` (step over), `<F11>` (step into), etc.

### Troubleshooting
- **Breakpoints turn red (rejected)**: Make sure you're in project root, not `src/`
- **"No stopped threads"**: Breakpoints are in wrong files or sourcemaps aren't working
- **Chrome doesn't connect**: Ensure `ng serve` is running on `localhost:4200`

### What Gets Debugged
✅ TypeScript component logic  
✅ Service methods  
✅ Lifecycle hooks (`ngOnInit`, etc.)  
❌ HTML templates (use browser DevTools for DOM debugging)
