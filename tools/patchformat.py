import argparse
from ghapi.core import GhApi
import os
import time

username = os.environ['GH_USERNAME']
# When creating github personal access token, be sure to check all permissions under the repo scope to access private repos
github_token = os.environ['GH_TOKEN']

api = GhApi(owner='kubernetes-security', repo='kubernetes',token=github_token)

parser = argparse.ArgumentParser(description='Format patch files')
required = parser.add_argument_group('required arguments')
required.add_argument('--pr', help='Pull Request Number in kubernetes-security/kubernetes with the fix (e.g. 63)', required=True)
required.add_argument('--cve', help='CVE for the vulnerability', required=True)
required.add_argument('-r', '--release', help='Kubernetes release branch (e.g. 1.30)', required=True)
parser.add_argument('-v', '--version', help='Patch version, if a correction is being sent')
args = parser.parse_args()

pull = api.pulls.get(args.pr)
patch = api(pull.url, headers={'Accept': 'application/vnd.github.patch'})

patch_split = patch.splitlines()
patch_list = []

local_time = time.localtime()

patch_list.append('From: distributors-announce <distributors-announce@kubernetes.io>')
patch_list.append('Date: ' + time.strftime('%a, %d %b %Y %H:%M:%S %z', local_time))
patch_list.append('Subject: Fix ' + args.cve)
patch_list.append('')

started = False
for line in patch_split:
    if line != '---' and not started:
        pass
    else:
        started = True
        patch_list.append(line)

if args.version:
    filename = args.cve.split('-')[2] + '_v' + args.release + '_v' + args.version + '.patch'
else:
    filename = args.cve.split('-')[2] + '_v' + args.release + '.patch'

f = open(filename, 'w')
f.write('\n'.join(patch_list))
f.write('\n')
f.close()
