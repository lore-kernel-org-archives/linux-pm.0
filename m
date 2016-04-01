From: Len Brown <lenb@kernel.org>
Subject: [PATCH] x86: Calculate MHz using APERF/MPERF for cpuinfo and scaling_cur_freq
Date: Fri,  1 Apr 2016 00:37:00 -0400
Message-ID: <52f711be59539723358bea1aa3c368910a68b46d.1459485198.git.len.brown@intel.com>
References: <6e0c25e64e0fb65a42dfc63ad5f660302e07cd87.1459485198.git.len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yw0-f196.google.com ([209.85.161.196]:36798 "EHLO
	mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750741AbcDAEhx (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 1 Apr 2016 00:37:53 -0400
In-Reply-To: <6e0c25e64e0fb65a42dfc63ad5f660302e07cd87.1459485198.git.len.brown@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: x86@kernel.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

For x86 processors with APERF/MPERF and TSC,
return meaningful and consistent MHz in
/proc/cpuinfo and
/sys/devices/system/cpu/cpu*/cpufreq/scaling_cur_freq

MHz is computed like so:

MHz = base_MHz * delta_APERF / delta_MPERF

MHz is the average frequency of the busy processor
over a measurement interval.  The interval is
defined to be the time between successive reads
of the frequency on that processor, whether from
/proc/cpuinfo or from sysfs cpufreq/scaling_cur_freq.
As with previous methods of calculating MHz,
idle time is excluded.

base_MHz above is from TSC calibration global "cpu_khz".

This x86 native method to calculate MHz returns a meaningful result
no matter if P-states are controlled by hardware or firmware
and/or the Linux cpufreq sub-system is/is-not installed.

Note that frequent or concurrent reads of /proc/cpuinfo
or sysfs cpufreq/scaling_cur_freq will shorten the
measurement interval seen by each reader.  The code
mitigates that issue by caching results for 100ms.

Discerning users are encouraged to take advantage of
the turbostat(8) utility, which can gracefully handle
concurrent measurement intervals of arbitrary length.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 arch/x86/kernel/cpu/Makefile     |  1 +
 arch/x86/kernel/cpu/aperfmperf.c | 76 ++++++++++++++++++++++++++++++++++++++++
 arch/x86/kernel/cpu/proc.c       |  4 ++-
 drivers/cpufreq/cpufreq.c        |  7 +++-
 include/linux/cpufreq.h          | 13 +++++++
 5 files changed, 99 insertions(+), 2 deletions(-)
 create mode 100644 arch/x86/kernel/cpu/aperfmperf.c

diff --git a/arch/x86/kernel/cpu/Makefile b/arch/x86/kernel/cpu/Makefile
index 4a8697f..821e31a 100644
--- a/arch/x86/kernel/cpu/Makefile
+++ b/arch/x86/kernel/cpu/Makefile
@@ -20,6 +20,7 @@ obj-y			:= intel_cacheinfo.o scattered.o topology.o
 obj-y			+= common.o
 obj-y			+= rdrand.o
 obj-y			+= match.o
+obj-y			+= aperfmperf.o
 
 obj-$(CONFIG_PROC_FS)	+= proc.o
 obj-$(CONFIG_X86_FEATURE_NAMES) += capflags.o powerflags.o
diff --git a/arch/x86/kernel/cpu/aperfmperf.c b/arch/x86/kernel/cpu/aperfmperf.c
new file mode 100644
index 0000000..9380102
--- /dev/null
+++ b/arch/x86/kernel/cpu/aperfmperf.c
@@ -0,0 +1,76 @@
+/*
+ * x86 APERF/MPERF KHz calculation
+ * Used by /proc/cpuinfo and /sys/.../cpufreq/scaling_cur_freq
+ *
+ * Copyright (C) 2015 Intel Corp.
+ * Author: Len Brown <len.brown@intel.com>
+ *
+ * This file is licensed under GPLv2.
+ */
+
+#include <linux/jiffies.h>
+#include <linux/math64.h>
+#include <linux/percpu.h>
+#include <linux/smp.h>
+
+struct aperfmperf_sample {
+	unsigned int khz;
+	unsigned long jiffies;
+	unsigned long long aperf;
+	unsigned long long mperf;
+};
+
+static DEFINE_PER_CPU(struct aperfmperf_sample, samples);
+
+/*
+ * aperfmperf_snapshot_khz()
+ * On the current CPU, snapshot APERF, MPERF, and jiffies
+ * unless we already did it within 100ms
+ * calculate kHz, save snapshot
+ */
+static void aperfmperf_snapshot_khz(void *dummy)
+{
+	unsigned long long aperf, aperf_delta;
+	unsigned long long mperf, mperf_delta;
+	unsigned long long numerator;
+	struct aperfmperf_sample *s = &get_cpu_var(samples);
+
+	/* Cache KHz for 100 ms */
+	if (time_before(jiffies, s->jiffies + HZ/10))
+		goto out;
+
+	rdmsrl(MSR_IA32_APERF, aperf);
+	rdmsrl(MSR_IA32_MPERF, mperf);
+
+	aperf_delta = aperf - s->aperf;
+	mperf_delta = mperf - s->mperf;
+
+	/*
+	 * There is no architectural guarantee that MPERF
+	 * increments faster than we can read it.
+	 */
+	if (mperf_delta == 0)
+		goto out;
+
+	numerator = cpu_khz * aperf_delta;
+	s->khz = div64_u64(numerator, mperf_delta);
+	s->jiffies = jiffies;
+	s->aperf = aperf;
+	s->mperf = mperf;
+
+out:
+	put_cpu_var(samples);
+}
+
+unsigned int aperfmperf_khz_on_cpu(int cpu)
+{
+	if (!cpu_khz)
+		return 0;
+
+	if (!boot_cpu_has(X86_FEATURE_APERFMPERF))
+		return 0;
+
+	smp_call_function_single(cpu, aperfmperf_snapshot_khz, NULL, 1);
+
+	return per_cpu(samples.khz, cpu);
+}
diff --git a/arch/x86/kernel/cpu/proc.c b/arch/x86/kernel/cpu/proc.c
index 18ca99f..44507c0 100644
--- a/arch/x86/kernel/cpu/proc.c
+++ b/arch/x86/kernel/cpu/proc.c
@@ -78,9 +78,11 @@ static int show_cpuinfo(struct seq_file *m, void *v)
 		seq_printf(m, "microcode\t: 0x%x\n", c->microcode);
 
 	if (cpu_has(c, X86_FEATURE_TSC)) {
-		unsigned int freq = cpufreq_quick_get(cpu);
+		unsigned int freq = aperfmperf_khz_on_cpu(cpu);
 
 		if (!freq)
+			freq = cpufreq_quick_get(cpu);
+		if (!freq)
 			freq = cpu_khz;
 		seq_printf(m, "cpu MHz\t\t: %u.%03u\n",
 			   freq / 1000, (freq % 1000));
diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index b87596b..7fcd090 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -541,8 +541,13 @@ show_one(scaling_max_freq, max);
 static ssize_t show_scaling_cur_freq(struct cpufreq_policy *policy, char *buf)
 {
 	ssize_t ret;
+	unsigned int freq;
 
-	if (cpufreq_driver && cpufreq_driver->setpolicy && cpufreq_driver->get)
+	freq = arch_freq_get_on_cpu(policy->cpu);
+	if (freq)
+		ret = sprintf(buf, "%u\n", freq);
+	else if (cpufreq_driver && cpufreq_driver->setpolicy &&
+			cpufreq_driver->get)
 		ret = sprintf(buf, "%u\n", cpufreq_driver->get(policy->cpu));
 	else
 		ret = sprintf(buf, "%u\n", policy->cur);
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 718e872..a9b8ec6 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -566,6 +566,19 @@ static inline bool policy_has_boost_freq(struct cpufreq_policy *policy)
 /* the following funtion is for cpufreq core use only */
 struct cpufreq_frequency_table *cpufreq_frequency_get_table(unsigned int cpu);
 
+#ifdef CONFIG_X86
+extern unsigned int aperfmperf_khz_on_cpu(int cpu);
+static inline unsigned int arch_freq_get_on_cpu(int cpu)
+{
+	return aperfmperf_khz_on_cpu(cpu);
+}
+#else
+static inline unsigned int arch_freq_get_on_cpu(int cpu)
+{
+	return 0;
+}
+#endif
+
 /* the following are really really optional */
 extern struct freq_attr cpufreq_freq_attr_scaling_available_freqs;
 extern struct freq_attr cpufreq_freq_attr_scaling_boost_freqs;
-- 
2.8.0.rc4.16.g56331f8

