#!/usr/bin/env python3
#coding=utf-8

from aliyunsdkcore.client import AcsClient
from aliyunsdkcore.request import CommonRequest
import json
import os
from log import logger

#client = AcsClient('<accessKeyId>', '<accessSecret>', 'cn-hangzhou')
ali_secret_id  = os.environ.get('ALI_SECRET_ID')
ali_secret_key = os.environ.get('ALI_SECRET_KEY')
client = AcsClient(ali_secret_id, ali_secret_key, 'cn-hangzhou')

request = CommonRequest()
request.set_accept_format('json')
request.set_domain('alidns.aliyuncs.com')
request.set_method('POST')
request.set_version('2015-01-09')

def get_rr_records(domain, rr):
    request.set_action_name('DescribeDomainRecords')
    request.add_query_param('DomainName', domain)
    request.add_query_param('RRKeyWord', rr)
    
    response = client.do_action(request)
    #print(str(response, encoding = 'utf-8'))
    return response

def update_rr_record(rr, record_id, dnstype, record_value):
    request.set_action_name('UpdateDomainRecord')

    request.add_query_param('RecordId', record_id)
    request.add_query_param('RR', rr)
    request.add_query_param('Type', dnstype)
    request.add_query_param('Value', record_value)

    response = client.do_action(request)
    # python2:  print(response) 
    return str(response, encoding = 'utf-8')

if __name__ == "__main__":
    #subdomin = 'hub'
    #domain = 'digi-sky.com'
    #record_value = 'test'

    subdomin = os.environ.get('SubDOMAIN')
    domain = os.environ.get('DOMAIN')
    record_value = os.environ.get('RECORD_VALUE')

    rr = '_acme-challenge.' + subdomin
    rr_record = get_rr_records(domain, rr)
    records = json.loads(rr_record)

    for record in records['DomainRecords']['Record']:
        if record['Status'] == 'ENABLE':
            logger.info("update dns record for %s.%s, RecordId %s, old value: %s, new value: %s" % (rr, domain, record['RecordId'], record['Value'], record_value))

            result = update_rr_record(rr, record['RecordId'], record['Type'], record_value)
            logger.info(result)
