from fastapi import FastAPI, HTTPException
from pydantic import BaseModel

app = FastAPI(
    title="Amazon Laptop Service",
    description="Catalog service for Laptop products",
    version="1.0.0",
)

class Laptop(BaseModel):
    id: int
    model: str
    price: float
    stock: int

laptops = [
    Laptop(id=1, model="Amazon Book 3", price=999.99, stock=65),
    Laptop(id=2, model="Surface Pro 10", price=1099.99, stock=38),
    Laptop(id=3, model="MacBook Air M3", price=1199.99, stock=42),
]

@app.get("/health")
def health_check():
    return {"service": "laptop", "status": "ok"}

@app.get("/laptops")
def list_laptops():
    return laptops

@app.get("/laptops/{laptop_id}")
def get_laptop(laptop_id: int):
    for laptop in laptops:
        if laptop.id == laptop_id:
            return laptop
    raise HTTPException(status_code=404, detail="Laptop not found")
