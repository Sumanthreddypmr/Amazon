from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
from typing import List

app = FastAPI(
    title="Amazon Cart Service",
    description="Shopping cart management service",
    version="1.0.0",
)

class CartItem(BaseModel):
    id: int
    product: str
    quantity: int
    price: float

cart: List[CartItem] = []

@app.get("/health")
def health_check():
    return {"service": "cart", "status": "ok"}

@app.get("/cart")
def get_cart():
    return cart

@app.post("/cart/items")
def add_item(item: CartItem):
    cart.append(item)
    return {"message": "Item added", "item": item}

@app.delete("/cart/items/{item_id}")
def remove_item(item_id: int):
    global cart
    updated_cart = [item for item in cart if item.id != item_id]
    if len(updated_cart) == len(cart):
        raise HTTPException(status_code=404, detail="Item not found")
    cart[:] = updated_cart
    return {"message": "Item removed", "remaining_cart": cart}
