from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
from typing import List

app = FastAPI(
    title="Amazon Delivery Service",
    description="Order delivery tracking and management service",
    version="1.0.0",
)

class DeliveryItem(BaseModel):
    delivery_id: int
    order_id: int
    status: str
    eta_minutes: int

deliveries: List[DeliveryItem] = [
    DeliveryItem(delivery_id=1, order_id=101, status="in_transit", eta_minutes=35),
    DeliveryItem(delivery_id=2, order_id=102, status="packed", eta_minutes=125),
]

@app.get("/health")
def health_check():
    return {"service": "delivery", "status": "ok"}

@app.get("/deliveries")
def list_deliveries():
    return deliveries

@app.post("/deliveries")
def create_delivery(delivery: DeliveryItem):
    deliveries.append(delivery)
    return {"message": "Delivery created", "delivery": delivery}

@app.get("/deliveries/{delivery_id}")
def get_delivery(delivery_id: int):
    for item in deliveries:
        if item.delivery_id == delivery_id:
            return item
    raise HTTPException(status_code=404, detail="Delivery not found")
