require("dotenv").config();
const express = require("express");
const cors = require("cors");

const app = express();

app.use(cors());
app.use(express.json());

app.use("/auth", require("./routes/auth"));
app.use("/expenses", require("./routes/expenses"));
app.use("/maintenance", require("./routes/maintenance"));

app.listen(5000, () => console.log("Server running on port 5000"));