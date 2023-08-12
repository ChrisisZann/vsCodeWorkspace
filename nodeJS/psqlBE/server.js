const http = require('http');
const url = require('url');
const querystring = require('querystring');
const { Pool } = require('pg');

const port = 3339;

// PostgreSQL configuration
const pool = new Pool({
  user: 'postgres',
  host: '192.168.0.8',
  database: 'chrisisdb',
  password: 'WKn6dgHD*5RxXPTivsbJ',
  port: 5432,
});

const server = http.createServer((req, res) => {
  if (req.method === 'POST' && req.url === '/insert-data') {
    let requestBody = '';

    req.on('data', chunk => {
      requestBody += chunk;
    });


    req.on('end', async () => {
      try {
        const postData = querystring.parse(requestBody);
        const { sensor_id, t_value, sensor_location } = postData;

        // Insert data into PostgreSQL
        const query = `
          INSERT INTO esp32.temperature (sensor_id, t_value, sensor_location)
          VALUES ($1, $2, $3)`;
        await pool.query(query, [sensor_id, t_value, sensor_location]);

        res.writeHead(200, { 'Content-Type': 'text/plain' });
        res.end('Data inserted successfully');
      } catch (error) {
        console.error('Error inserting data:', error);
        res.writeHead(500, { 'Content-Type': 'text/plain' });
        res.end('Internal server error');
      }
    });
  } else {
    res.writeHead(404, { 'Content-Type': 'text/plain' });
    res.end('Not Found');
  }
});

server.listen(port, () => {
  console.log(`API listening at http://localhost:${port}`);
});
