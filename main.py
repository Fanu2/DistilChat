from fastapi import FastAPI

app = FastAPI()

# Now put your endpoints below, e.g.:
@app.get("/")
def read_root():
    return {"message": "Hello world!"}
