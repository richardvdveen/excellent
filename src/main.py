from fastapi import FastAPI
from fastapi.responses import FileResponse

app = FastAPI()


@app.get("/")
def read_root():
    return FileResponse("src/mock.xlsx")

@app.get("/login")
def login():
    return {"message": "logged_in"}
