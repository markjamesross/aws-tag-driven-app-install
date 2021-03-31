import logging
import json
import os
import boto3
import time

logger = logging.getLogger("tag-event")
logger.setLevel(logging.DEBUG)

def handler(event, context):
    debug_print(json.dumps(event))
    changed_tag_keys = event['detail']['changed-tag-keys'][0]
    debug_print("The tags that have changed are " + changed_tag_keys)
    if changed_tag_keys  == os.environ['APP_TAG_KEY']:
        debug_print("The tag driven application install or uninstall tag has been changed")
        instance_arn = event['resources'][0]
        instance_id = instance_arn.rsplit(sep='/')[1]
        debug_print("The Instance ARN which had tags altered is " + instance_id)
        try: 
            change_tag_value = event['detail']['tags'][os.environ['APP_TAG_KEY']]
            debug_print("The value of the " + os.environ['APP_TAG_KEY'] + " tag is now " + change_tag_value)
            if change_tag_value == os.environ['APP_TAG_INSTALL_VALUE']:
                ssm_document = os.environ['SSM_DOCUMENT_INSTALL']
            else:
                ssm_document = os.environ['SSM_DOCUMENT_UNINSTALL']
            debug_print("SSM document to run is " + ssm_document)
        except Exception as e:
            debug_print("The tag " + os.environ['APP_TAG_KEY'] + " has been deleted")
            ssm_document = os.environ['SSM_DOCUMENT_UNINSTALL']
        run_ssm_command(ssm_document, instance_id)
    else:
        debug_print("The tag driven application install or uninstall tag has not been changed")
    return {}

def run_ssm_command(ssm_document, instance_id):
    ssm_client = boto3.client('ssm')
    try:
        instances = [str(instance_id)]
        debug_print("DocumentName {}".format(ssm_document))
        debug_print("InstanceIds {}".format(instances))
        response = ssm_client.send_command(DocumentName=ssm_document,
                                           InstanceIds=instances,
                                           Comment='Event Driven Action for Install or Uninstall',
                                           TimeoutSeconds=1200)
        debug_print(response)
    except Exception as e:
        debug_print(e)
        return False
    return True
    
def debug_print(message):
    logger.debug(message)