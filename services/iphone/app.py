from fastapi import FastAPI, HTTPException
from pydantic import BaseModel

app = FastAPI(
    title="Amazon iPhone Service",
    description="Catalog service for iPhone products",
    version="1.0.0",
)

class Phone(BaseModel):
    id: int
    model: str
    price: float
    stock: int

phones = [
    Phone(id=1, model="iPhone 15", price=999.99, stock=72),
    Phone(id=2, model="iPhone 15 Pro", price=1199.99, stock=48),
    Phone(id=3, model="iPhone SE", price=429.99, stock=120),
]

@app.get("/health")
def health_check():
    return {"service": "iphone", "status": "ok"}

@app.get("/phones")
def list_phones():
    return phones

@app.get("/phones/{phone_id}")
def get_phone(phone_id: int):
    for phone in phones:
        if phone.id == phone_id:
            return phone
    raise HTTPException(status_code=404, detail="Phone not found")
