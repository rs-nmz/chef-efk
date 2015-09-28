#!/bin/bash

curl -XPUT localhost:9200/_template/template_1 -d '
{
   "template" : "logstash-*",
   "mappings" : {
       "dstat": {
           "properties": {
                "host" : { "type" : "string", "index" : "not_analyzed" },
                "value" : {"type" : "double"}
           }
       }
   }
}
'
