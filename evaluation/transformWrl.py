import os
from tqdm import tqdm
wrl_dir = './data/scans/'

def run():
	files = os.listdir(wrl_dir)
	files = [file for file in files if file.endswith('wrl')]
	for name in tqdm(files):
		file = open(os.path.join(wrl_dir + name, 'r')
		file_out = open(wrl_dir + name[:-3] + 'txt', 'w')
		writing_mode = False
		for line in file:
			if(line.strip().endswith('point [')):
				writing_mode = True
				continue
			if(not writing_mode):
				continue
			if(writing_mode and line.strip().endswith(']')):
				break
			line = line.strip()
			coords = [float(''.join(c for c in num if c != ',')) for num in line.split()]
			file_out.write('%.2f %.2f %.2f\n' % (coords[0], coords[1], coords[2]))
		file_out.close()
		file.close()

if __name__ == '__main__':
	run()
	
