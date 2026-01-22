from fastapi import FastAPI
import psycopg2
import os

app = FastAPI()

DATABASE_URL = os.getenv("DATABASE_URL")

def get_db_conn(): # the db was not using env so had to change this
                   # and make sure the backend is correctly calling right db.
    return psycopg2.connect(DATABASE_URL)

@app.get("/api/health") # have made some changes as it was conflictinf with nginx
def health():
    try:
        conn = get_db_conn()
        cur = conn.cursor()
        cur.execute("SELECT 1;")
        cur.close()
        conn.close()
        return {"status": "ok", "db": "connected"}
    except Exception as e:
        return {"status": "error", "error": str(e)}

@app.get("/api/message")
def message():
    return {"message": "Hello from Backend API"}
