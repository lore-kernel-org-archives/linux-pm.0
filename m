From: Calvin Walton <calvin.walton@kepstin.ca>
Subject: [PATCH 0/2] turbostat: Improve support for AMD Zen CPUs (RAPL, CPUID) (Resend)
Date: Wed, 18 Jul 2018 18:26:54 -0400
Message-ID: <20180718222656.11795-1-calvin.walton@kepstin.ca>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Calvin Walton <calvin.walton@kepstin.ca>
List-Id: linux-pm@vger.kernel.org

Based on the documentation provided in AMD's Open-Source
Register Reference For AMD Family 17h Processors:
https://support.amd.com/TechDocs/56255_OSRR.pdf

I've added support for reading Cores and Package energy usage from AMD's
"RAPL" MSRs. In order to correctly detect the AMD processor generation,
I've also had to update the CPUID code to handle AMD's extended family
field.

I've resent this including the linux-pm mailing list per Rafael's
suggestion (I wasn't sure who to send this to initially - maybe the
MAINTAINERS file should be updated so get_maintainer.pl gives better
results). The patches are unchanged from my previous submission.

Here's some example output from my (idle) Ryzen 3 2200G test system:

turbostat version 17.06.23 - Len Brown <lenb@kernel.org>
CPUID(0): AuthenticAMD 13 CPUID levels; family:model:stepping 0x17:11:0 (23:17:0)
CPUID(1): SSE3 MONITOR - - - TSC MSR - -
CPUID(6): APERF, No-TURBO, No-DTS, No-PTM, No-HWP, No-HWPnotify, No-HWPwindow, No-HWPepp, No-HWPpkg, No-EPB
CPUID(7): No-SGX
RAPL: 364 sec. Joule Counter Range, at 180 Watts
cpu2: POLL: CPUIDLE CORE POLL IDLE
cpu2: C1: ACPI FFH INTEL MWAIT 0x0
cpu2: C2: ACPI IOPORT 0x414
cpu2: cpufreq driver: acpi-cpufreq
cpu2: cpufreq governor: schedutil
cpu0: MSR_RAPL_PWR_UNIT: 0x000a1003 (0.125000 Watts, 0.000015 Joules, 0.000977 sec.)
Core	CPU	Avg_MHz	Busy%	Bzy_MHz	TSC_MHz	IRQ	C1	C2	C1%	C2%	CorWatt	PkgWatt
-	-	33	2.20	1485	3500	5073	1263	3694	2.75	95.12	0.03	3.29
0	0	33	2.20	1483	3500	1213	354	886	2.96	94.89	0.01	3.29
1	1	25	1.67	1474	3500	907	197	682	1.55	96.80	0.01
2	2	33	2.24	1478	3500	1674	450	1175	4.16	93.70	0.01
3	3	40	2.67	1501	3500	1279	262	951	2.33	95.07	0.01


Calvin Walton (2):
  turbostat: Read extended processor family from CPUID
  turbostat: Add support for AMD Fam 17h (Zen) RAPL

 tools/power/x86/turbostat/turbostat.c | 184 ++++++++++++++++++++++----
 1 file changed, 156 insertions(+), 28 deletions(-)

-- 
2.18.0
