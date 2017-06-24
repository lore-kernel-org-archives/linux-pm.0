From: Len Brown <lenb@kernel.org>
Subject: [PATCH 2/4 v2] x86: use common aperfmperf_khz_on_cpu() to calculate KHz using APERF/MPERF
Date: Fri, 23 Jun 2017 22:11:52 -0700
Message-ID: <7c8784a63cdab6ff5ff7756060be6a77f5fe5915.1498280509.git.len.brown@intel.com>
References: <1498281114-3868-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1498281114-3868-1-git-send-email-lenb@kernel.org>
In-Reply-To: <e3f0ab4d677eb1337999731f1a98022caa8a796a.1498280509.git.len.brown@intel.com>
References: <e3f0ab4d677eb1337999731f1a98022caa8a796a.1498280509.git.len.brown@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rafael@kernel.org, tglx@linutronix.de
Cc: x86@kernel.org, srinivas.pandruvada@linux.intel.com, peterz@infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

From: Len Brown <len.brown@intel.com>

The goal of this change is to give users a uniform and meaningful
result when they read /sys/...cpufreq/scaling_cur_freq
on modern x86 hardware, as compared to what they get today.

Modern x86 processors include the hardware needed
to accurately calculate frequency over an interval --
APERF, MPERF, and the TSC.

Here we provide an x86 routine to make this calculation
on supported hardware, and use it in preference to any
driver driver-specific cpufreq_driver.get() routine.

MHz is computed like so:

MHz = base_MHz * delta_APERF / delta_MPERF

MHz is the average frequency of the busy processor
over a measurement interval.  The interval is
defined to be the time between successive invocations
of aperfmperf_khz_on_cpu(), which are expected to to
happen on-demand when users read sysfs attribute
cpufreq/scaling_cur_freq.

As with previous methods of calculating MHz,
idle time is excluded.

base_MHz above is from TSC calibration global "cpu_khz".

This x86 native method to calculate MHz returns a meaningful result
no matter if P-states are controlled by hardware or firmware
and/or if the Linux cpufreq sub-system is or is-not installed.

When this routine is invoked more frequently, the measurement
interval becomes shorter.  However, the code limits re-computation
to 10ms intervals so that average frequency remains meaningful.

Discerning users are encouraged to take advantage of
the turbostat(8) utility, which can gracefully handle
concurrent measurement intervals of arbitrary length.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 arch/x86/kernel/cpu/Makefile     |  1 +
 arch/x86/kernel/cpu/aperfmperf.c | 79 ++++++++++++++++++++++++++++++++++++++++
 drivers/cpufreq/cpufreq.c        | 12 +++++-
 include/linux/cpufreq.h          |  2 +
 4 files changed, 93 insertions(+), 1 deletion(-)
 create mode 100644 arch/x86/kernel/cpu/aperfmperf.c

diff --git a/arch/x86/kernel/cpu/Makefile b/arch/x86/kernel/cpu/Makefile
index 5200001..cdf8249 100644
--- a/arch/x86/kernel/cpu/Makefile
+++ b/arch/x86/kernel/cpu/Makefile
@@ -21,6 +21,7 @@ obj-y			+= common.o
 obj-y			+= rdrand.o
 obj-y			+= match.o
 obj-y			+= bugs.o
+obj-$(CONFIG_CPU_FREQ)	+= aperfmperf.o
 
 obj-$(CONFIG_PROC_FS)	+= proc.o
 obj-$(CONFIG_X86_FEATURE_NAMES) += capflags.o powerflags.o
diff --git a/arch/x86/kernel/cpu/aperfmperf.c b/arch/x86/kernel/cpu/aperfmperf.c
new file mode 100644
index 0000000..d869c86
--- /dev/null
+++ b/arch/x86/kernel/cpu/aperfmperf.c
@@ -0,0 +1,79 @@
+/*
+ * x86 APERF/MPERF KHz calculation for
+ * /sys/.../cpufreq/scaling_cur_freq
+ *
+ * Copyright (C) 2017 Intel Corp.
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
+	unsigned int	khz;
+	unsigned long	jiffies;
+	u64	aperf;
+	u64	mperf;
+};
+
+static DEFINE_PER_CPU(struct aperfmperf_sample, samples);
+
+/*
+ * aperfmperf_snapshot_khz()
+ * On the current CPU, snapshot APERF, MPERF, and jiffies
+ * unless we already did it within 10ms
+ * calculate kHz, save snapshot
+ */
+static void aperfmperf_snapshot_khz(void *dummy)
+{
+	u64 aperf, aperf_delta;
+	u64 mperf, mperf_delta;
+	struct aperfmperf_sample *s = this_cpu_ptr(&samples);
+
+	/* Don't bother re-computing within 10 ms */
+	if (time_before(jiffies, s->jiffies + HZ/100))
+		return;
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
+		return;
+
+	/*
+	 * if (cpu_khz * aperf_delta) fits into ULLONG_MAX, then
+	 *	khz = (cpu_khz * aperf_delta) / mperf_delta
+	 */
+	if (div64_u64(ULLONG_MAX, cpu_khz) > aperf_delta)
+		s->khz = div64_u64((cpu_khz * aperf_delta), mperf_delta);
+	else	/* khz = aperf_delta / (mperf_delta / cpu_khz) */
+		s->khz = div64_u64(aperf_delta,
+			div64_u64(mperf_delta, cpu_khz));
+	s->jiffies = jiffies;
+	s->aperf = aperf;
+	s->mperf = mperf;
+}
+
+unsigned int arch_freq_get_on_cpu(int cpu)
+{
+	if (!cpu_khz)
+		return 0;
+
+	if (!static_cpu_has(X86_FEATURE_APERFMPERF))
+		return 0;
+
+	smp_call_function_single(cpu, aperfmperf_snapshot_khz, NULL, 1);
+
+	return per_cpu(samples.khz, cpu);
+}
diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 26b643d..6e7424d 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -632,11 +632,21 @@ show_one(cpuinfo_transition_latency, cpuinfo.transition_latency);
 show_one(scaling_min_freq, min);
 show_one(scaling_max_freq, max);
 
+__weak unsigned int arch_freq_get_on_cpu(int cpu)
+{
+	return 0;
+}
+
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
index a5ce0bbe..905117b 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -883,6 +883,8 @@ static inline bool policy_has_boost_freq(struct cpufreq_policy *policy)
 }
 #endif
 
+extern unsigned int arch_freq_get_on_cpu(int cpu);
+
 /* the following are really really optional */
 extern struct freq_attr cpufreq_freq_attr_scaling_available_freqs;
 extern struct freq_attr cpufreq_freq_attr_scaling_boost_freqs;
-- 
2.7.4
