import express from "express";
import { me, updateProfilePicture } from "../controllers/userController.js";

const router = express.Router();

router.post("/me", me);
router.post("/update-profile-picture", updateProfilePicture);

export default router;
