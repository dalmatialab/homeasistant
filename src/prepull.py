import os
import json

images = []

for addon in os.listdir("/usr/share/hassio/addons/data"):
    if 'core' in addon:
        config = open('/usr/share/hassio/addons/core/' + addon.split('_')[1] + '/config.json')
        config_json = json.load(config)
        images.append(config_json['image'].replace('{arch}','amd64') + ':' + config_json['version'])
        config.close()
    else:
        config = open('/usr/share/hassio/addons/git/' + addon.split('_')[0] + '/' + addon.split('_')[1] + '/config.json')
        config_json = json.load(config)
        images.append(config_json['image'].replace('{arch}','amd64') + ':' + config_json['version'])
        config.close()
        
        
for image in images:
    command = 'docker pull ' + image
    os.system(command)
    
