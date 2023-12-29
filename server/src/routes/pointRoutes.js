import express from "express";
import { leaderBoard, updatePoint } from "../controllers/pointController.js";

const router = express.Router();

router.get("/leader-board", leaderBoard);
router.post("/update-point", updatePoint);

export default router;
