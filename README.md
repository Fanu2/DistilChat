fastapi\_chatbot/
├── app/
│   ├── **init**.py
│   ├── main.py
│   ├── model\_loader.py
├── requirements.txt
├── run.sh

# ==================== app/main.py ====================

from fastapi import FastAPI
from pydantic import BaseModel
from .model\_loader import get\_model, tokenizer

app = FastAPI()

class ChatRequest(BaseModel):
prompt: str
persona: str = "default"

@app.post("/chat")
def chat\_endpoint(req: ChatRequest):
model = get\_model()
inputs = tokenizer.encode(req.prompt, return\_tensors="pt")
outputs = model.generate(inputs, max\_length=100, do\_sample=True)
text = tokenizer.decode(outputs\[0], skip\_special\_tokens=True)
return {"response": text}

# ==================== app/model\_loader.py ====================

from transformers import AutoTokenizer, AutoModelForCausalLM

tokenizer = AutoTokenizer.from\_pretrained("distilgpt2")
\_model = None

def get\_model():
global \_model
if \_model is None:
\_model = AutoModelForCausalLM.from\_pretrained("distilgpt2")
return \_model

# ==================== requirements.txt ====================

fastapi
uvicorn
transformers
torch

# ==================== run.sh ====================

\#!/bin/bash
uvicorn app.main\:app --reload

# ==================== README.md ====================

# DistilChat

A lightweight local chatbot using FastAPI + distilgpt2

## Features

* Local LLM (distilgpt2) via transformers
* REST API endpoint `/chat`
* Streamlit frontend client

## Run API Server

```bash
pip install -r requirements.txt
bash run.sh
```

## Run Streamlit Client

```bash
streamlit run streamlit_client.py
```

## Structure

```
app/
  main.py
  model_loader.py
streamlit_client.py
requirements.txt
run.sh
```

## API Usage

POST [http://localhost:8000/chat](http://localhost:8000/chat)
Body: { "prompt": "Hello", "persona": "default" }
