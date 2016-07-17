From: Carsten Emde <C.Emde@osadl.org>
Subject: cpufreq: Intel P state driver: add cycle counter for clock frequency
 monitoring
Date: Sun, 17 Jul 2016 23:51:26 +0200
Message-ID: <66b88042-0f03-893b-33ac-c4e6df17534c@osadl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from toro.web-alm.net ([62.245.132.31]:38387 "EHLO toro.web-alm.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751216AbcGQXDd (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 17 Jul 2016 19:03:33 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Linux PM mailing list <linux-pm@vger.kernel.org>

Most cpufreq drivers contain an interface to the cpufreq_stats plugin
that counts the time the processor stays in a given P state. The Intel P
state driver, however, does not work on discrete P states but allows to
run the processor at arbitrary clock frequencies within the allowed
range. Even if the frequencies were reduced to steps of 100 MHz, this
would result in too many P states. This patch, therefore, introduces the
additional cpufreq variable kcycles that contains the number of clock
cycles divided by 1000 since the most recent reboot. This allows to
monitor the average clock frequency during a defined time interval by
simply calculating the derivative. With this patch, there are no longer
Intel processors around that do not provide a way to monitor the clock
frequency. Such monitoring is important to fine tune a system's energy
efficiency and to debug clock frequency modulation.

(Earlier kernel versions can immediately use the now abandoned function
intel_pstate_calc_freq(). I had to resuscitate it for kernel versions
where it disappeared.)

Signed-off-by: Carsten Emde <C.Emde@osadl.org>

---
 drivers/cpufreq/cpufreq.c      |   15 +++++++++++++++
 drivers/cpufreq/intel_pstate.c |   39 ++++++++++++++++++++++++++++++++++++---
 include/linux/cpufreq.h        |    2 ++
 3 files changed, 53 insertions(+), 3 deletions(-)

Index: linux-4.7.0-rc3+/drivers/cpufreq/cpufreq.c
===================================================================
--- linux-4.7.0-rc3+.orig/drivers/cpufreq/cpufreq.c
+++ linux-4.7.0-rc3+/drivers/cpufreq/cpufreq.c
@@ -815,6 +815,19 @@ static ssize_t show_bios_limit(struct cp
 	return sprintf(buf, "%u\n", policy->cpuinfo.max_freq);
 }
 
+/**
+ * show_scaling_kcycles - show number of accumulated CPU cycles by 1000
+ */
+static ssize_t show_scaling_kcycles(struct cpufreq_policy *policy,
+					char *buf)
+{
+	if (cpufreq_driver && cpufreq_driver->kcycles) {
+		u64 kcycles = cpufreq_driver->kcycles(policy->cpu);
+		return sprintf(buf, "%llu\n", kcycles);
+	} else
+		return sprintf(buf, "<unsupported>");
+}
+
 cpufreq_freq_attr_ro_perm(cpuinfo_cur_freq, 0400);
 cpufreq_freq_attr_ro(cpuinfo_min_freq);
 cpufreq_freq_attr_ro(cpuinfo_max_freq);
@@ -829,6 +842,7 @@ cpufreq_freq_attr_rw(scaling_min_freq);
 cpufreq_freq_attr_rw(scaling_max_freq);
 cpufreq_freq_attr_rw(scaling_governor);
 cpufreq_freq_attr_rw(scaling_setspeed);
+cpufreq_freq_attr_ro(scaling_kcycles);
 
 static struct attribute *default_attrs[] = {
 	&cpuinfo_min_freq.attr,
@@ -842,6 +856,7 @@ static struct attribute *default_attrs[]
 	&scaling_driver.attr,
 	&scaling_available_governors.attr,
 	&scaling_setspeed.attr,
+	&scaling_kcycles.attr,
 	NULL
 };
 
Index: linux-4.7.0-rc3+/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-4.7.0-rc3+.orig/drivers/cpufreq/intel_pstate.c
+++ linux-4.7.0-rc3+/drivers/cpufreq/intel_pstate.c
@@ -96,7 +96,6 @@ static inline u64 div_ext_fp(u64 x, u64
  *			read from MPERF MSR between last and current sample
  * @tsc:		Difference of time stamp counter between last and
  *			current sample
- * @freq:		Effective frequency calculated from APERF/MPERF
  * @time:		Current time from scheduler
  *
  * This structure is used in the cpudata structure to store performance sample
@@ -108,8 +107,8 @@ struct sample {
 	u64 aperf;
 	u64 mperf;
 	u64 tsc;
-	int freq;
 	u64 time;
+	u64 kcycles;
 };
 
 /**
@@ -1154,11 +1153,26 @@ static inline void intel_pstate_calc_avg
 	sample->core_avg_perf = div_ext_fp(sample->aperf, sample->mperf);
 }
 
+static inline int intel_pstate_calc_freq(struct cpudata *cpu)
+{
+	struct sample *sample = &cpu->sample;
+	int64_t core_pct;
+
+	core_pct = int_tofp(sample->aperf) * int_tofp(100);
+	core_pct = div64_u64(core_pct, int_tofp(sample->mperf));
+
+	return fp_toint(mul_fp(int_tofp(
+			cpu->pstate.max_pstate_physical *
+			cpu->pstate.scaling / 100),
+			core_pct));
+}
+
 static inline bool intel_pstate_sample(struct cpudata *cpu, u64 time)
 {
-	u64 aperf, mperf;
+	u64 aperf, mperf, interval;
 	unsigned long flags;
 	u64 tsc;
+	int freq;
 
 	local_irq_save(flags);
 	rdmsrl(MSR_IA32_APERF, aperf);
@@ -1179,6 +1193,12 @@ static inline bool intel_pstate_sample(s
 	cpu->sample.mperf -= cpu->prev_mperf;
 	cpu->sample.tsc -= cpu->prev_tsc;
 
+	freq = intel_pstate_calc_freq(cpu);
+	interval = (cpu->sample.time - cpu->last_sample_time) /
+		   NSEC_PER_MSEC;
+	cpu->sample.kcycles += ((u64) freq * interval) /
+		1000ULL;
+
 	cpu->prev_aperf = aperf;
 	cpu->prev_mperf = mperf;
 	cpu->prev_tsc = tsc;
@@ -1436,6 +1456,18 @@ static void intel_pstate_set_performance
 	limits->min_sysfs_pct = 0;
 }
 
+static u64 intel_pstate_kcycles_get(unsigned int cpu_num)
+{
+	struct sample *sample;
+	struct cpudata *cpu;
+
+	cpu = all_cpu_data[cpu_num];
+	if (!cpu)
+		return 0;
+	sample = &cpu->sample;
+	return sample->kcycles;
+}
+
 static int intel_pstate_set_policy(struct cpufreq_policy *policy)
 {
 	struct cpudata *cpu;
@@ -1569,6 +1601,7 @@ static struct cpufreq_driver intel_pstat
 	.setpolicy	= intel_pstate_set_policy,
 	.resume		= intel_pstate_hwp_set_policy,
 	.get		= intel_pstate_get,
+	.kcycles	= intel_pstate_kcycles_get,
 	.init		= intel_pstate_cpu_init,
 	.exit		= intel_pstate_cpu_exit,
 	.stop_cpu	= intel_pstate_stop_cpu,
Index: linux-4.7.0-rc3+/include/linux/cpufreq.h
===================================================================
--- linux-4.7.0-rc3+.orig/include/linux/cpufreq.h
+++ linux-4.7.0-rc3+/include/linux/cpufreq.h
@@ -275,6 +275,8 @@ struct cpufreq_driver {
 	unsigned int	(*get)(unsigned int cpu);
 
 	/* optional */
+	u64		(*kcycles) (unsigned int cpu);
+
 	int		(*bios_limit)(int cpu, unsigned int *limit);
 
 	int		(*exit)(struct cpufreq_policy *policy);
