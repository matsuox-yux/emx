import json

def handler(event, context):

#     params = event.get("queryStringParameters") or {}
#     name = params.get("name")
#     age =  params.get("age")
#
#     return {
#         "statusCode": 200,
#         "body": json.dumps({
#             "message": f"hello {name}, age {age}"
#         })
#     }


#      params = event.get("pathParameters") or {}
#      user_id = params.get("user_id")
#
#      return {
#          "statusCode": 200,
#          "body": json.dumps({
#              "message": f"user_id {user_id}"
#          })
#      }

    body = json.loads(event["body"])
    name = body["name"]
    age = body["age"]

    return {
        "statusCode": 200,
        "body": json.dumps({
            "message": f"{name} {age}"
        })
    }
