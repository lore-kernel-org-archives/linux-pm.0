From: Paul Menzel <pmenzel@molgen.mpg.de>
Subject: intel_pstate: Lowest frequency not reached with Intel i7-6700
Date: Wed, 12 Dec 2018 22:40:22 +0100
Message-ID: <ac4d2bed-be16-71ee-8c3b-dc4fa0cb87f9@molgen.mpg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: de-DE
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>
Cc: linux-pm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Dear Linux folks,


Using *powersave* as P-state selection algorithm, on an idle system
with an Intel i7-6700 (Sandy Bridge), the frequency only goes down to
900 MHz instead of the minimum frequency of 800 MHz.

> $ uname -a
> Linux keineahnung.molgen.mpg.de 4.20.0-rc5.mx64.234 #1 SMP Mon Dec 3 16:58:29 CET 2018 x86_64 GNU/Linux
> $ dmesg | grep state
> [    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
> [    0.000000] x86/fpu: xstate_offset[3]:  832, xstate_sizes[3]:   64
> [    0.000000] x86/fpu: xstate_offset[4]:  896, xstate_sizes[4]:   64
> [    0.000000] x86/fpu: Enabled xstate features 0x1f, context size is 960 bytes, using 'compacted' format.
> [    0.686027] acpi PNP0C0B:00: Failed to change power state to D0
> [    0.694017] acpi PNP0C0B:00: Failed to set initial power state
> [    0.703020] acpi PNP0C0B:01: Failed to change power state to D0
> [    0.712012] acpi PNP0C0B:01: Failed to set initial power state
> [    0.722010] acpi PNP0C0B:02: Failed to change power state to D0
> [    0.730013] acpi PNP0C0B:02: Failed to set initial power state
> [    0.739010] acpi PNP0C0B:03: Failed to change power state to D0
> [    0.748012] acpi PNP0C0B:03: Failed to set initial power state
> [    0.758009] acpi PNP0C0B:04: Failed to change power state to D0
> [    0.766012] acpi PNP0C0B:04: Failed to set initial power state
> [    0.767127] Monitor-Mwait will be used to enter C-1 state
> [    0.767131] Monitor-Mwait will be used to enter C-2 state
> [    0.767134] Monitor-Mwait will be used to enter C-3 state
> [    2.092456] intel_pstate: Intel P-state driver initializing
> [    2.094820] intel_pstate: HWP enabled
> $ lscpu
> Architecture:        x86_64
> CPU op-mode(s):      32-bit, 64-bit
> Byte Order:          Little Endian
> CPU(s):              8
> On-line CPU(s) list: 0-7
> Thread(s) per core:  2
> Core(s) per socket:  4
> Socket(s):           1
> NUMA node(s):        1
> Vendor ID:           GenuineIntel
> CPU family:          6
> Model:               94
> Model name:          Intel(R) Core(TM) i7-6700 CPU @ 3.40GHz
> Stepping:            3
> CPU MHz:             900.392
> CPU max MHz:         4000.0000
> CPU min MHz:         800.0000
> BogoMIPS:            6816.00
> Virtualization:      VT-x
> L1d cache:           32K
> L1i cache:           32K
> L2 cache:            256K
> L3 cache:            8192K
> NUMA node0 CPU(s):   0-7
> Flags:               fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc cpuid aperfmperf tsc_known_freq pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic movbe popcnt aes xsave avx f16c rdrand lahf_lm abm 3dnowprefetch cpuid_fault epb invpcid_single pti tpr_shadow vnmi flexpriority ept vpid ept_ad fsgsbase tsc_adjust bmi1 hle avx2 smep bmi2 erms invpcid rtm mpx rdseed adx smap clflushopt intel_pt xsaveopt xsavec xgetbv1 xsaves dtherm ida arat pln pts hwp hwp_notify hwp_act_window hwp_epp
> $ cat /sys/devices/system/cpu/cpufreq/policy*/scaling_governor
> powersave
> powersave
> powersave
> powersave
> powersave
> powersave
> powersave
> powersave
> $ cat /sys/devices/system/cpu/cpufreq/policy*/scaling_cur_freq
> 900335
> 900285
> 900179
> 900314
> 900510
> 900226
> 900376
> 900375

Shouldn’t it go down until 800 MHz?


Kind regards,

Paul
