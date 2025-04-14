# Real-Time Analytics Dashboard Architecture

## System Overview

The Real-Time Analytics Dashboard is a full-stack application that provides real-time monitoring of website traffic metrics. The system consists of a Flutter frontend and a Node.js backend, communicating via WebSocket for real-time updates.

## Architecture Diagram

```
┌─────────────────┐     WebSocket     ┌─────────────────┐
│                 │◄─────────────────►│                 │
│ Flutter Frontend│                   │  Node.js Backend│
│                 │                   │                 │
└─────────────────┘                   └─────────────────┘
```

## Components

### Frontend (Flutter)
- **WebSocket Service**: Manages real-time connection to the backend
- **Dashboard Components**:
  - ActiveUsers: Displays current active user count
  - PageViews: Shows page view trends in a line chart
  - SessionDuration: Visualizes average session duration

### Backend (Node.js)
- **WebSocket Server**: Handles real-time client connections
- **Mock Data Generator**: Simulates website traffic metrics
- **REST API**: Provides additional endpoints for testing

## Data Flow

1. Backend generates mock data every 3 seconds
2. Data is broadcast to all connected WebSocket clients
3. Frontend components update in real-time to reflect new data
4. UI transitions are smooth with Flutter animations

## Tech Stack

### Frontend
- Flutter: UI framework
- fl_chart: Data visualization library
- Provider: State management
- WebSocket: Real-time communication

### Backend
- Node.js: Runtime environment
- Express.js: Web framework
- ws: WebSocket implementation
- cors: Cross-origin resource sharing

## Real-Time Logic

1. **Connection Management**:
   - Frontend establishes WebSocket connection on widget initialization
   - Automatic reconnection on disconnection
   - Cleanup on widget disposal

2. **Data Updates**:
   - Backend broadcasts new data every 3 seconds
   - Frontend widgets update state with new data
   - Smooth transitions using Flutter animations

3. **Error Handling**:
   - Automatic reconnection attempts
   - Error logging
   - Graceful degradation

## Mock Data Design

The mock data generator creates realistic website metrics:
- Active Users: Random number between 50-150
- Page Views: Random number between 100-300
- Session Duration: Random number between 2-7 minutes
