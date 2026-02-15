const express = require("express");
const bcrypt = require("bcrypt");
const jwt = require("jsonwebtoken");
const prisma = require("../utils/db");
const router = express.Router();

function generateUserId() {
    const now = new Date();
    const y = now.getFullYear();
    const m = String(now.getMonth() + 1).padStart(2, "0");
    const d = String(now.getDate()).padStart(2, "0");
    const datePart = `${y}${m}${d}`;
    const chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    let rand = "";
    for (let i = 0; i < 10; i++) {
        rand += chars.charAt(Math.floor(Math.random() * chars.length));
    }
    return datePart + rand; // e.g. "20260215ABCXYZQWER"
}

router.post("/register", async (req, res) => {
    try {
        const { username, password, full_name, email } = req.body;
        const hashed = await bcrypt.hash(password, 10);
        const user = await prisma.user.create({
            data: { id: generateUserId(), username, password: hashed, full_name, email },
        });
        res.json(user);
    } catch (error) {
        if (error.code === 'P2002') {
            // Prisma unique constraint violation
            return res.status(400).json({ message: "Username already exists" });
        }
        res.status(500).json({ message: "Registration failed" });
    }
});

router.post("/login", async (req, res) => {
    const { username, password } = req.body;

    const user = await prisma.user.findUnique({ where: { username } });
    if (!user) return res.status(400).json({ message: "User not found" });

    const match = await bcrypt.compare(password, user.password);
    if (!match) return res.status(400).json({ message: "Wrong password" });

    const token = jwt.sign(
        { id: user.id, role: user.role },
        process.env.JWT_SECRET
    );

    res.json({ token });
});

module.exports = router;