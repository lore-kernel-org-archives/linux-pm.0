From: Arto Jantunen <viiru@iki.fi>
Subject: PROBLEM: Cpufreq constantly keeps frequency at maximum on 4.5-rc4
Date: Sat, 20 Feb 2016 10:49:52 +0200
Message-ID: <87egc7ahqn.fsf@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from viiru.iki.fi ([185.19.28.114]:38809 "EHLO viiru.iki.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2992561AbcBTI6A (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sat, 20 Feb 2016 03:58:00 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org

Hi,

When using kernel 4.5-rc4 my Skylake machine runs very warm since all
cpu cores are always kept at 3.10Ghz (with maximum without turboboost
being 2.6Ghz), completely regardless of load. Swapping between the
governors (performance and powersave) doesn't change the result in any
way, frequency remains at a constant 3.10Ghz.

The machine is using the intel_pstate driver, I don't know if it's
possible to choose to use the acpi driver instead (without recompiling
the kernel so that intel_pstate is not supported).

I can force the frequency down manually with cpufreq-set, so the problem
doesn't seem to be with the actual frequency changing.

Cpuinfo (taken from 4.4 which doesn't have the problem):

processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 94
model name	: Intel(R) Core(TM) i7-6700HQ CPU @ 2.60GHz
stepping	: 3
microcode	: 0x33
cpu MHz		: 1067.929
cache size	: 6144 KB
physical id	: 0
siblings	: 8
core id		: 0
cpu cores	: 4
apicid		: 0
initial apicid	: 0
fpu		: yes
fpu_exception	: yes
cpuid level	: 22
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl vmx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm 3dnowprefetch ida arat epb pln pts dtherm hwp hwp_notify hwp_act_window hwp_epp intel_pt tpr_shadow vnmi flexpriority ept vpid fsgsbase tsc_adjust bmi1 hle avx2 smep bmi2 erms invpcid rtm mpx rdseed adx smap clflushopt xsaveopt xsavec xgetbv1
bugs		:
bogomips	: 5183.96
clflush size	: 64
cache_alignment	: 64
address sizes	: 39 bits physical, 48 bits virtual
power management:

-- 
Arto Jantunen
