From: kbuild test robot <fengguang.wu@intel.com>
Subject: [acpi:release 1/6] arch/x86/kernel/cpu/aperfmperf.c:35:2: note: in
 expansion of macro 'if'
Date: Thu, 12 Nov 2015 16:25:46 +0800
Message-ID: <201511121644.05MBTtaC%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="YZ5djTAD1cGYuMQK"
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
To: Len Brown <len.brown@intel.com>
Cc: kbuild-all@01.org, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git release
head:   15b36a4938815f8dbb940b212ecc7c7085a89ca0
commit: 7b56b064b8a95b3ef7a2b0c88f0d8baded2c4cd6 [1/6] x86: use APERF/MPERF for cpuinfo and scaling_cur_freq MHz
config: x86_64-randconfig-s3-11121604 (attached as .config)
reproduce:
        git checkout 7b56b064b8a95b3ef7a2b0c88f0d8baded2c4cd6
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All warnings (new ones prefixed by >>):

   In file included from include/asm-generic/percpu.h:6:0,
                    from arch/x86/include/asm/percpu.h:551,
                    from arch/x86/include/asm/current.h:5,
                    from arch/x86/include/asm/processor.h:15,
                    from arch/x86/include/asm/atomic.h:6,
                    from include/linux/atomic.h:4,
                    from include/linux/llist.h:58,
                    from include/linux/smp.h:14,
                    from arch/x86/kernel/cpu/aperfmperf.c:11:
   arch/x86/kernel/cpu/aperfmperf.c: In function 'aperfmperf_snapshot_khz':
   include/linux/percpu-defs.h:264:2: error: implicit declaration of function 'preempt_disable' [-Werror=implicit-function-declaration]
     preempt_disable();      \
     ^
   arch/x86/kernel/cpu/aperfmperf.c:32:33: note: in expansion of macro 'get_cpu_var'
     struct aperfmperf_sample *s = &get_cpu_var(samples);
                                    ^
   In file included from include/uapi/linux/stddef.h:1:0,
                    from include/linux/stddef.h:4,
                    from include/uapi/linux/posix_types.h:4,
                    from include/uapi/linux/types.h:13,
                    from include/linux/types.h:5,
                    from include/linux/smp.h:10,
                    from arch/x86/kernel/cpu/aperfmperf.c:11:
   arch/x86/kernel/cpu/aperfmperf.c:35:6: error: implicit declaration of function 'time_before' [-Werror=implicit-function-declaration]
     if (time_before(jiffies, s->jiffies + HZ/10))
         ^
   include/linux/compiler.h:147:28: note: in definition of macro '__trace_if'
     if (__builtin_constant_p((cond)) ? !!(cond) :   \
                               ^
>> arch/x86/kernel/cpu/aperfmperf.c:35:2: note: in expansion of macro 'if'
     if (time_before(jiffies, s->jiffies + HZ/10))
     ^
   arch/x86/kernel/cpu/aperfmperf.c:35:18: error: 'jiffies' undeclared (first use in this function)
     if (time_before(jiffies, s->jiffies + HZ/10))
                     ^
   include/linux/compiler.h:147:28: note: in definition of macro '__trace_if'
     if (__builtin_constant_p((cond)) ? !!(cond) :   \
                               ^
>> arch/x86/kernel/cpu/aperfmperf.c:35:2: note: in expansion of macro 'if'
     if (time_before(jiffies, s->jiffies + HZ/10))
     ^
   arch/x86/kernel/cpu/aperfmperf.c:35:18: note: each undeclared identifier is reported only once for each function it appears in
     if (time_before(jiffies, s->jiffies + HZ/10))
                     ^
   include/linux/compiler.h:147:28: note: in definition of macro '__trace_if'
     if (__builtin_constant_p((cond)) ? !!(cond) :   \
                               ^
>> arch/x86/kernel/cpu/aperfmperf.c:35:2: note: in expansion of macro 'if'
     if (time_before(jiffies, s->jiffies + HZ/10))
     ^
   arch/x86/kernel/cpu/aperfmperf.c:35:40: error: 'HZ' undeclared (first use in this function)
     if (time_before(jiffies, s->jiffies + HZ/10))
                                           ^
   include/linux/compiler.h:147:28: note: in definition of macro '__trace_if'
     if (__builtin_constant_p((cond)) ? !!(cond) :   \
                               ^
>> arch/x86/kernel/cpu/aperfmperf.c:35:2: note: in expansion of macro 'if'
     if (time_before(jiffies, s->jiffies + HZ/10))
     ^
   arch/x86/kernel/cpu/aperfmperf.c:51:27: error: 'cpu_khz' undeclared (first use in this function)
     s->khz = (unsigned int) (cpu_khz * aperf_delta / mperf_delta);
                              ^
   In file included from include/asm-generic/percpu.h:6:0,
                    from arch/x86/include/asm/percpu.h:551,
                    from arch/x86/include/asm/current.h:5,
                    from arch/x86/include/asm/processor.h:15,
                    from arch/x86/include/asm/atomic.h:6,
                    from include/linux/atomic.h:4,
                    from include/linux/llist.h:58,
                    from include/linux/smp.h:14,
                    from arch/x86/kernel/cpu/aperfmperf.c:11:
   include/linux/percpu-defs.h:275:2: error: implicit declaration of function 'preempt_enable' [-Werror=implicit-function-declaration]
     preempt_enable();      \
     ^
   arch/x86/kernel/cpu/aperfmperf.c:57:2: note: in expansion of macro 'put_cpu_var'
     put_cpu_var(samples);
     ^
   In file included from include/uapi/linux/stddef.h:1:0,
                    from include/linux/stddef.h:4,
                    from include/uapi/linux/posix_types.h:4,
                    from include/uapi/linux/types.h:13,
                    from include/linux/types.h:5,
                    from include/linux/smp.h:10,
                    from arch/x86/kernel/cpu/aperfmperf.c:11:
   arch/x86/kernel/cpu/aperfmperf.c: In function 'aperfmperf_khz_on_cpu':
   arch/x86/kernel/cpu/aperfmperf.c:62:7: error: 'cpu_khz' undeclared (first use in this function)
     if (!cpu_khz)
          ^
   include/linux/compiler.h:147:28: note: in definition of macro '__trace_if'
     if (__builtin_constant_p((cond)) ? !!(cond) :   \
                               ^
   arch/x86/kernel/cpu/aperfmperf.c:62:2: note: in expansion of macro 'if'
     if (!cpu_khz)
     ^
   cc1: some warnings being treated as errors

vim +/if +35 arch/x86/kernel/cpu/aperfmperf.c

     5	 * Copyright (C) 2015 Intel Corp.
     6	 * Author: Len Brown <len.brown@intel.com>
     7	 *
     8	 * This file is licensed under GPLv2.
     9	 */
    10	
  > 11	#include <linux/smp.h>
    12	
    13	struct aperfmperf_sample {
    14		unsigned int khz;
    15		unsigned long jiffies;
    16		unsigned long long aperf;
    17		unsigned long long mperf;
    18	};
    19	
    20	static DEFINE_PER_CPU(struct aperfmperf_sample, samples);
    21	
    22	/*
    23	 * aperfmperf_snapshot_khz()
    24	 * On the current CPU, snapshot APERF, MPERF, and jiffies
    25	 * unless we already did it within 100ms
    26	 * calculate kHz, save snapshot
    27	 */
    28	static void aperfmperf_snapshot_khz(void *dummy)
    29	{
    30		unsigned long long aperf, aperf_delta;
    31		unsigned long long mperf, mperf_delta;
    32		struct aperfmperf_sample *s = &get_cpu_var(samples);
    33	
    34		/* Cache khz for 100ms */
  > 35		if (time_before(jiffies, s->jiffies + HZ/10))
    36			goto out;
    37	
    38		rdmsrl(MSR_IA32_APERF, aperf);

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--YZ5djTAD1cGYuMQK
Content-Type: application/octet-stream
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
+FGKAQA=

--YZ5djTAD1cGYuMQK--
