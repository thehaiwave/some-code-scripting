#!/usr/bin/python3

import subprocess
import json
import re

url_endpoint = 1611671251717
url_indicator = 0
base_url = "https://www.inegi.org.mx/app/api/clasificadores/interna_v1/frontArbol/listaRamas/?proy=75&indica={}&_={}"
data = []
indicators_to_search = []

with open('../data/in.txt', 'r') as file:
	for line in file:
		indicators_to_search.append(line.strip('\n'))


def get_url_response(indicator, endpoint):
	args = ["curl", base_url.format(str(indicator), str(endpoint))]
	res = subprocess.run(args, capture_output=True)
	
	return json.loads(res.stdout)


def do_your_thing(url_indicators_response, x, y):
	indicator_names = []

	while y <= len(url_indicators_response) and x < len(indicators_to_search):
		match_ind = re.search('\d+', indicators_to_search[x]) 
		match_res = re.search('\d+', url_indicators_response[y]["cve_indicador"])	

		if match_ind[0] == match_res[0]:
			indicator_names.append(url_indicators_response[y]["nombre"].split('<')[0])
			x+=1
			y+=1
		elif match_res[0] in match_ind[0]:
			temp_url_response = get_url_response(match_ind[0][:-1], len(match_ind[0]) - len(match_res[0]))
			for item in temp_url_response:
				if match_ind[0] == item["cve_indicador"]:
					indicator_names.append(item["nombre"].split('<')[0])
			x+=1
		else:
			y+=1

	return indicator_names

def build_objects(attr_1, attr_2, attr_1_data, attr_2_data):
	
	for a, b in zip(attr_1_data, attr_2_data):
		newObject = {}
		newObject[attr_1] = a
		newObject[attr_2] = b
		data.append(newObject)


def main():
	res = get_url_response(url_indicator, url_endpoint)
	names = do_your_thing(res, 0, 0)
	build_objects("name", "label", names, indicators_to_search)	

	with open('../data/out.txt', 'w') as file:
		file.write(str(data))	

if __name__ == "__main__":
	main()
