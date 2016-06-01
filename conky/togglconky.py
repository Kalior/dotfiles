#! /usr/bin/python
import requests
# parsing json data
import json
import time
import datetime

#successfull request: curl -v -u 1e69e5aea5216d23f062ce23f6f8b877:api_token -X GET https://www.toggl.com/api/v8/me



def toggl_running():
  values = {'entry': "-", 'project_name': ""}
  try:
    auth_fields = requests.auth.HTTPBasicAuth('key','api_token')

    url_entry = 'https://www.toggl.com/api/v8/time_entries/current'

    entry_request = requests.get(url_entry, auth=auth_fields)
    data = json.loads(entry_request.text)['data']

    if(data == None):
      values['entry'] = "-"
    else:
      epoch_time = int(time.time())
      duration = epoch_time + data['duration']
      values['entry'] = str(datetime.timedelta(seconds=duration)) + " " + data['description']
      if(data['pid']):
        url_project = 'https://www.toggl.com/api/v8/projects/' + str(data['pid'])
        project_request = requests.get(url_project, auth=auth_fields)
        project_data = json.loads(project_request.text)['data']
        if(data == None):
          values['project_name'] = "-"
        else:
          project_name = project_data['name']
          values['project_name'] = project_name

    return values
  except:
    return values
  #curl -v -u 1e69e5aea5216d23f062ce23f6f8b877:api_token \ -X GET https://www.toggl.com/api/v8/time_entries/current


if __name__ == "__main__":

  entry_data = toggl_running()
  with open('/home/kalior/.config/conky/toggl_running', 'w') as f:
      f.write(entry_data['entry'])
  with open('/home/kalior/.config/conky/toggl_project', 'w') as f:
      f.write(entry_data['project_name'])
