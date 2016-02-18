
# for making requests
import urllib2
import urllib

# parsing json data
import json

#---------------------------------------------
# Class containing the endpoint URLs for Toggl
#---------------------------------------------
class Endpoints():
    WORKSPACES = "https://www.toggl.com/api/v8/workspaces"
    CLIENTS = "https://www.toggl.com/api/v8/clients"
    REPORT_WEEKLY = "https://toggl.com/reports/api/v2/weekly"
    REPORT_DETAILED = "https://toggl.com/reports/api/v2/details"
    REPORT_SUMMARY = "https://toggl.com/reports/api/v2/summary"
    START_TIME = "https://www.toggl.com/api/v8/time_entries/start"
    @staticmethod
    def STOP_TIME(pid):
        return "https://www.toggl.com/api/v8/time_entries/" + str(pid) + "/stop"
    CURRENT_RUNNING_TIME = "https://www.toggl.com/api/v8/time_entries/current"

class misc: 
   def decodeJSON(self, jsonString):
        return json.JSONDecoder().decode(jsonString)

    def startTimeEntry(self, description, pid):
        '''starts a new Time Entry'''
        data = {
            "time_entry": {
            "description": description,
            "pid": pid,
            "created_with": self.user_agent
            }
        }
        response = self.postRequest(Endpoints.START_TIME, parameters=data)
        return self.decodeJSON(response)

    def currentRunningTimeEntry(self):
        '''Gets the Current Time Entry'''
        response = self.postRequest(Endpoints.CURRENT_RUNNING_TIME)
        return self.decodeJSON(response)

    def stopTimeEntry(self, entryid):
        '''Stop the time entry'''
        response = self.postRequest(Endpoints.STOP_TIME(entryid))
        return self.decodeJSON(response)


class Py3status:
   # Configuration parameters
   headers = {
      "Authorization": "",
      "Content-Type": "application/json",
      "Accept": "*/*",
      "User-Agent": "python/urllib",
   }

    # default API user agent value
    user_agent = "TogglPy3status"

   def toggl_check (self, i3s_output_list, i3s_config):
        response = {}   

 


if __name__ == "__main__":
   from time import sleep
   x = Py3status()
   config = {
        'color_good': '#00FF00',
        'color_bad': '#FF0000',
        'cid': "gujoel",
        'cookie': "chalmersItAuth=34df98c621bd1a54b8e7675bc69a6ecb83579542"
   }
   while True:
      print(x.check_hubbit([], config))
      sleep(1)