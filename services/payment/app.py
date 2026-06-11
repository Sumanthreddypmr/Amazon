from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
from typing import Optional

app = FastAPI(
    title="Amazon Payment Service",
    description="Payment processing and transaction management service",
    version="1.0.0",
)

class PaymentRequest(BaseModel):
    order_id: int
    amount: float
    currency: str = "USD"
    method: str

class PaymentResponse(BaseModel):
    payment_id: int
    order_id: int
    status: str
    amount: float
    currency: str

payments = []

@app.get("/health")
def health_check():
    return {"service": "payment", "status": "ok"}

@app.post("/payments")
def create_payment(request: PaymentRequest):
    payment_id = len(payments) + 1
    response = PaymentResponse(
        payment_id=payment_id,
        order_id=request.order_id,
        status="processed",
        amount=request.amount,
        currency=request.currency,
    )
    payments.append(response)
    return response

@app.get("/payments/{payment_id}")
def get_payment(payment_id: int):
    for payment in payments:
        if payment.payment_id == payment_id:
            return payment
    raise HTTPException(status_code=404, detail="Payment not found")
