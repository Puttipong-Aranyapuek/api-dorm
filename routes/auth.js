const express = require("express");
const bcrypt = require("bcrypt");
const jwt = require("jsonwebtoken");
const prisma = require("../utils/db");
const router = express.Router();

router.post("/register", async (req, res) => {
    const { username, password, full_name, phone } = req.body;

    const hashed = await bcrypt.hash(password, 10);

    const user = await prisma.user.create({
        data: { username, password: hashed, full_name, phone },
    });

    res.json(user);
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