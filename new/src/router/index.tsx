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
