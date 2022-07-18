#!/bin/bash

my_id=$(az ad signed-in-user show --query "id")

jq -n --arg my_id "$my_id" '{"my_id":'$my_id'}'
