from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
import io

import os 
import logging

app = FastAPI()




class ChatRequest(BaseModel):
    message: str

class ChatResponse(BaseModel):
    response: str

@app.get("/hello")
def hello_world():
    return {"response": "Hello, world!"}




def format_jobs(jobs):
    formatted = "Here are some job listings:\n"
    for job in jobs:
        formatted += f"{job['title']} at {job['company']}\n"
    return formatted

if __name__ == '__main__':
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)
