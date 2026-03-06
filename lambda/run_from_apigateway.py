from lambda_function import handler

# # GET /users?name=taro&age=20
# event = {
#   "resource": "/users",
#   "path": "/users",
#   "httpMethod": "GET",
#   "queryStringParameters": {
#     "name": "taro",
#     "age": "20"
#   },
#   "pathParameters": None,
#   "body": None
# }


# # GET /users/{user_id}
# event = {
#   "resource": "/users/{user_id}",
#   "path": "/users/123",
#   "httpMethod": "GET",
#   "pathParameters": {
#     "user_id": "123"
#   },
#   "queryStringParameters": None,
#   "body": None
# }


# POST /users
event = {
  "resource": "/users",
  "path": "/users",
  "httpMethod": "POST",
  "body": "{\"name\":\"taro\",\"age\":20}",
  "isBase64Encoded": False
}

context = None

response = handler(event, context)

print(response)
