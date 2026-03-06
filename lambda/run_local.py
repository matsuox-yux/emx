from lambda_function import handler

event = {
    "name": "taro"
}

context = None

response = handler(event, context)

print(response)
