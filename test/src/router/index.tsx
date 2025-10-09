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
