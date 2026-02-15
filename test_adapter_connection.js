const prisma = require('./utils/db');

async function main() {
    try {
        console.log("Attempting to connect to database...");
        // Just try to connect or run a simple query
        await prisma.$connect();
        console.log("Successfully connected to database with adapter!");

        // Optional: Run a simple query if the table exists (User table)
        const userCount = await prisma.user.count();
        console.log(`Found ${userCount} users.`);

        await prisma.$disconnect();
    } catch (e) {
        console.error("Connection failed:", e);
        process.exit(1);
    }
}

main();
