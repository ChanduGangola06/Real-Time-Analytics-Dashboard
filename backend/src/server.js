const express = require('express');
const WebSocket = require('ws');
const cors = require('cors');
require('dotenv').config();

const app = express();
const port = process.env.PORT || 3001;

app.use(cors());
app.use(express.json());

// Create HTTP server
const server = app.listen(port, () => {
  console.log(`Server running on port ${port}`);
});

// Create WebSocket server
const wss = new WebSocket.Server({ server });

// Store connected clients
const clients = new Set();

// Function to generate mock data
function generateMockData() {
  return {
    timestamp: new Date().toISOString(),
    active_users: Math.floor(Math.random() * 100) + 50, // Random between 50-150
    page_views: Math.floor(Math.random() * 200) + 100,  // Random between 100-300
    avg_session_duration: (Math.random() * 5 + 2).toFixed(1) // Random between 2-7 minutes
  };
}

// Handle WebSocket connections
wss.on('connection', (ws) => {
  console.log('New client connected');
  clients.add(ws);

  // Send initial data
  ws.send(JSON.stringify(generateMockData()));

  // Handle client disconnection
  ws.on('close', () => {
    console.log('Client disconnected');
    clients.delete(ws);
  });
});

// Broadcast data to all connected clients every 3 seconds
setInterval(() => {
  const data = generateMockData();
  const message = JSON.stringify(data);
  
  clients.forEach(client => {
    if (client.readyState === WebSocket.OPEN) {
      client.send(message);
    }
  });
}, 3000);

// REST endpoint for testing
app.get('/api/metrics', (req, res) => {
  res.json(generateMockData());
}); 