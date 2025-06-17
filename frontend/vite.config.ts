import path from "node:path";
import { defineConfig } from "vite";
import react from "@vitejs/plugin-react-swc";
import tailwindcss from "@tailwindcss/vite";
import { loadEnv } from "vite";

export default defineConfig(({ mode }) => {
  const env = loadEnv(mode, path.resolve(__dirname, ".."));
  const externalHost = env.VITE_EXTERNAL_URL || "jarvis.local";

  return {
    plugins: [react(), tailwindcss()],
    base: "/",
    resolve: {
      alias: {
        "@": path.resolve(new URL(".", import.meta.url).pathname, "./src"),
      },
    },
    server: {
      host: '0.0.0.0',
      port: 5173,
      allowedHosts: [externalHost],
      proxy: {
        "/api": {
          target: `http://${externalHost}:2024`,
          changeOrigin: true,
        },
      },
    },
    define: {
      __EXTERNAL_URL__: JSON.stringify(`http://${env.VITE_EXTERNAL_URL}:5173`),
    },
  };
});