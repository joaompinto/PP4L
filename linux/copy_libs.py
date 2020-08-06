#
import sys
from subprocess import run, PIPE
result = run(['ldd', sys.executable], stdout=PIPE)
print(result.stdout)