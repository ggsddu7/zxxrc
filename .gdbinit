#focus cmd
#set print pretty on
#set print object on
#set print union on
set breakpoint pending on
set overload-resolution off

python
import sys
sys.path.insert(0, '/home/zhangjiguo/.vim/gcc/libstdc++-v3/python')
from libstdcxx.v6.printers import register_libstdcxx_printers
register_libstdcxx_printers (None)
end
