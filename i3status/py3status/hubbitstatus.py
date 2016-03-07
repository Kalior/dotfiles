import urllib.request
import json
import datetime
from time import time

class Py3status:

	cache_timeout = 10
	cid=""
	cookie=''
	color_good="#00FF00"
	color_bad="#FF0000"

	def check_hubbit(self, i3s_output_list, i3s_config):
		try:
			opener = urllib.request.build_opener()
			opener.addheaders.append(('Cookie', self.cookie))

			hubbit_url = 'http://hubbit.chalmers.it/stats/%s.json' % self.cid
			response = opener.open(hubbit_url).read()
			jsonResponse = json.loads(response.decode('utf-8'))

			date = datetime.datetime.strptime(jsonResponse['last_session'][0:-10], '%Y-%m-%dT%H:%M:%S')

			last_session_duration = jsonResponse['last_session_duration']

			response = {
				'	cache_timeout':	time() + self.cache_timeout,
					'full_text':	"Hubben %dmin" % (last_session_duration/60) + " " if date > datetime.datetime.now() else "",
					'color':		self.color_good
				}
		except:
			response = {
					'cache_timeout':	time() + self.cache_timeout,
					'full_text':		""
				}


		return response


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
