const request = require('supertest')
const app = require('../src/server')

describe("Test the health path", () => {
  it("Should responds with a 200", () => {
    return request(app)
      .get("/health")
      .then(response => {
        expect(response.statusCode).toBe(200);
      });
  });
});
