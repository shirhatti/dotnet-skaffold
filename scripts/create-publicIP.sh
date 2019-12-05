az network public-ip create \
--resource-group shirhattik8sgroup \
--name shirhattipubilcipbasic \
--sku Basic \
--allocation-method static \
--query publicIp.ipAddress \
-o tsv