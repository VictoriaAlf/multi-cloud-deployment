import json

def handle_request(event, context=None):
    method = event.get('httpMethod', 'GET') if 'httpMethod' in event else event.method

    if method == 'GET':
        return create_response(200, 'GET method - Fetching data')
    elif method == 'POST':
        return create_response(200, 'POST method - Creating data')
    elif method == 'PUT':
        return create_response(200, 'PUT method - Updating data')
    elif method == 'DELETE':
        return create_response(200, 'DELETE method - Deleting data')
    else:
        return create_response(400, 'Unsupported method')

def create_response(status_code, message):
    return {
        'statusCode': status_code,
        'body': json.dumps({'message': message})
    }

# AWS Lambda handler
def lambda_handler(event, context):
    return handle_request(event, context)

# Azure Function handler
def main(req):
    return handle_request(req)

# Google Cloud Function handler
def entry_point(request):
    return handle_request(request)
