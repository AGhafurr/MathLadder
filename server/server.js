import http from "http";
import express from "express";
import cors from "cors";
import { Server } from "socket.io";
import { supabase } from "./src/databases/supabase.js";
import authRoutes from "./src/routes/authRoutes.js";
import userRoutes from "./src/routes/userRoutes.js";
import pointRoutes from "./src/routes/pointRoutes.js";

const app = express();
const server = http.createServer(app);
const io = new Server(server, cors({ origin: "*" }));

app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(cors());

io.on("connection", (socket) => {
    console.log("a user connected");

    const supabaseSubscription = supabase.auth.onAuthStateChange((event, session) => {
        console.log(event, session);

        if (event === "INITIAL_SESSION") {
            socket.emit("INITIAL_SESSION", { session });
        } else if (event === "SIGNED_IN") {
            socket.emit("SIGNED_IN", { session });
        } else if (event === "SIGNED_OUT") {
            socket.emit("SIGNED_OUT", { session });
        }
    });

    socket.on("disconnect", () => {
        console.log("user disconnected");

        supabaseSubscription.data.subscription.unsubscribe();
    });
});

app.use("/api/auth", authRoutes);
app.use("/api/user", userRoutes);
app.use("/api/point", pointRoutes);

server.listen(3000, () => {
    console.log("Server running on -> http://localhost:3000");
});
