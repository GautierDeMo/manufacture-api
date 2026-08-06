const app = require("./server")
require('dotenv').config()

if (require.main === module) {
  const port = process.env.PORT
  app.listen(port);
  console.log(`Server is running on port: ${port}`)
}
