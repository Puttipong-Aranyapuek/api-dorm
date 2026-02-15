require('dotenv').config();
const { PrismaClient } = require("@prisma/client");

try {
    const prisma = new PrismaClient({
        datasources: {
            db: {
                url: process.env.DATABASE_URL
            }
        }
    }); // try old datasources format
    console.log("Prisma initialized successfully with datasources option");
} catch (e) {
    console.error("Initialization failed:", e);
}
