import json

def ok(value)->object:
    return _response(
        status=200,
        body=value,
        errors=[]
    )

def badRequest(value, errors: list)->object:    
    return _response(
        status=400,
        body=value,
        errors=errors
    )

def _response(status:int, body:any, errors:list) -> object:
    return {
        'statusCode': status,
        'body': json.dumps({
            'statusCode': status,
            'data': body,
            'errors': errors
        })
    }

def _formatResponse(value):
    return json.dumps(value)
    # if type(value) == object or type(value) == list or type(value) == range or type(value) == tuple:
    #     return json.dumps(value)
    # else:
    #     return value