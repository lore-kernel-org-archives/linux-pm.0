From: Prarit Bhargava <prarit@redhat.com>
Subject: [PATCH 0/2] turbostat, support CPU0 hotplug [v2]
Date: Mon, 25 May 2015 08:34:27 -0400
Message-ID: <1432557269-10994-1-git-send-email-prarit@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: len.brown@intel.com, andrey.semin@intel.com, linux-pm@vger.kernel.org, Prarit Bhargava <prarit@redhat.com>
List-Id: linux-pm@vger.kernel.org

turbostat does not function properly on systems that support CPU0 hotplug.
When running turbostat on these systems the following error is seen.

[root@intel-chiefriver-04 ~]# turbostat ls
turbostat: no /dev/cpu/0/msr
Try "# modprobe msr": No such file or directory

This happens because base_cpu is set to 0 in the turbostat code and calls
to check_dev_msr() will fail if CPU0 has been removed.

This patchset adds functionality to set the default cpu value to the
current running cpu.  This patch moves setup_all_buffers() to the
beginning of the turbostat_init() so that set_base_cpu() can take advantage
of topo.max_cpu_num which is set in setup_all_buffers().

After this change, on a system that has CPU0 removed,

[root@prarit ~]# ./turbostat -d -d ls
turbostat version 4.5 2 Apr, 2015 - Len Brown <lenb@kernel.org>
num_cpus 7 max_cpu_num 7
cpu0 NOT PRESENT
cpu 1 pkg 0 core 0
cpu 2 pkg 0 core 1
cpu 3 pkg 0 core 1
cpu 4 pkg 0 core 2
cpu 5 pkg 0 core 2
cpu 6 pkg 0 core 3
cpu 7 pkg 0 core 3
<snip>
anaconda-ks.cfg  README  turbostat
    Core     CPU Avg_MHz   %Busy Bzy_MHz TSC_MHz     SMI  CPU%c1  CPU%c3  CPU%c6  CPU%c7 CoreTmp  PkgTmp Pkg%pc2 Pkg%pc3 Pkg%pc6 Pkg%pc7 PkgWatt CorWatt GFXWatt
       -       -     492   14.20    3462    2634       0   18.90    0.00    0.00   68.63      27      27    0.00    0.00    0.00    0.00   17.65   12.69    0.00
       0       1     353    9.95    3552    2645       0    9.68    0.00    0.00   80.37      27      27    0.00    0.00    0.00    0.00   17.65   12.69    0.00
       1       2     217    7.70    2814    2614       0   64.63    0.00    0.00   27.68      26
       1       3    2006   57.20    3507    2660       0   15.61
       2       4     120    3.37    3570    2649       0   10.95    0.00    0.00   85.69      25
       2       5     155    4.22    3679    2631       0    9.48
       3       6     296    8.38    3530    2620       0   11.07    0.00    0.00   80.55      17
       3       7     296    8.15    3630    2617       0   11.22
0.001160 sec

I have additionally tested various other hotplug configurations to make sure
that turbostat behaves correctly in those situations as well.

[v2]: use sched_getcpu() to get current cpu

Signed-off-by: Prarit Bhargava <prarit@redhat.com>

Prarit Bhargava (2):
  turbostat, add base_cpu
  turbostat, add set_base_cpu()

 tools/power/x86/turbostat/turbostat.c |   44 ++++++++++++++++++++++-----------
 1 file changed, 30 insertions(+), 14 deletions(-)

-- 
1.7.9.3
