import json
from myapp.logic import create_user
from myapp.errors import BadRequestError

def lambda_handler(event, context):
    try:
        # ① parse
        body = json.loads(event.get("body") or "{}")

        # ② validation（軽い）
        name = body.get("name")
        if not name:
            raise BadRequestError("name is required")

        # ③ call logic
        result = create_user(name=name)

        # ④ response
        return {
            "statusCode": 200,
            "body": json.dumps(result)
        }

    except BadRequestError as e:
        return {
            "statusCode": 400,
            "body": json.dumps({"error": str(e)})
        }

    except Exception as e:
        # ログはここで
        print(e)

        return {
            "statusCode": 500,
            "body": json.dumps({"error": "internal error"})
        }
