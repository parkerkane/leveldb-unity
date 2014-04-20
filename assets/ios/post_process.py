import sys
from mod_pbxproj import XcodeProject

prj_path = sys.argv[1]

def fix_source():

	file_name = '%s/Libraries/RegisterMonoModules.cpp' % prj_path

	lines = []
	hold = []

	for line in file(file_name):

		if '&leveldb_property_value_native' in line:
			line = line.replace('&leveldb_property_value_native', '&leveldb_property_value')
		elif 'leveldb_property_value_native()' in line:
			line = line.replace('leveldb_property_value_native()', 'leveldb_property_value()')

		if 'mono_dl_register_symbol (const char* name, void *addr)' in line:
			hold.append(line)

		elif 'leveldb' in line and 'mono_dl_register_symbol' in line:
			hold.append(line)

		elif '#endif' in line:
			if len(hold) == 0:
				## already fixed
				return

			lines.append(line)
			lines += hold
			hold = []
		else:
			lines.append(line)

	print >>file(file_name, 'w'), ''.join(lines)

def fix_project():
	project = XcodeProject.Load(prj_path +'/Unity-iPhone.xcodeproj/project.pbxproj')

	project.add_file_if_doesnt_exist('usr/lib/libc++.dylib', tree='SDKROOT')

	if project.modified:
		project.backup()
		project.save()

fix_source()
fix_project()