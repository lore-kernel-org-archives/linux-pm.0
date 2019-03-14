From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 5/7] x86/tsc: Update cpufreq transition notifier to handle multiple CPUs
Date: Thu, 14 Mar 2019 12:12:51 +0530
Message-ID: <8a27342332bc467242f6ccdb4d4bd4d10f8aa552.1552545525.git.viresh.kumar@linaro.org>
References: <cover.1552545525.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1552545525.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The cpufreq core currently calls the cpufreq transition notifier
callback once for each affected CPU. This is going to change soon and
the cpufreq core will call the callback only once for each cpufreq
policy. The callback must look at the newly added field in struct
cpufreq_freqs, "cpus", which contains policy->related_cpus (both
online/offline CPUs) and perform per-cpu actions for them if any.

This patch updates time_cpufreq_notifier() to use the new "cpus" field,
update per-cpu data for all the related CPUs and call set_cyc2ns_scale()
for all online related_cpus.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/x86/kernel/tsc.c | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 3fae23834069..587a6aa72f38 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -956,28 +956,37 @@ static int time_cpufreq_notifier(struct notifier_block *nb, unsigned long val,
 				void *data)
 {
 	struct cpufreq_freqs *freq = data;
-	unsigned long *lpj;
-
-	lpj = &boot_cpu_data.loops_per_jiffy;
-#ifdef CONFIG_SMP
-	if (!(freq->flags & CPUFREQ_CONST_LOOPS))
-		lpj = &cpu_data(freq->cpu).loops_per_jiffy;
-#endif
+	bool boot_cpu = !IS_ENABLED(CONFIG_SMP) || freq->flags & CPUFREQ_CONST_LOOPS;
+	unsigned long lpj;
+	int cpu;
 
 	if (!ref_freq) {
 		ref_freq = freq->old;
-		loops_per_jiffy_ref = *lpj;
 		tsc_khz_ref = tsc_khz;
+
+		if (boot_cpu)
+			loops_per_jiffy_ref = boot_cpu_data.loops_per_jiffy;
+		else
+			loops_per_jiffy_ref = cpu_data(cpumask_first(freq->cpus)).loops_per_jiffy;
 	}
+
 	if ((val == CPUFREQ_PRECHANGE  && freq->old < freq->new) ||
 			(val == CPUFREQ_POSTCHANGE && freq->old > freq->new)) {
-		*lpj = cpufreq_scale(loops_per_jiffy_ref, ref_freq, freq->new);
-
+		lpj = cpufreq_scale(loops_per_jiffy_ref, ref_freq, freq->new);
 		tsc_khz = cpufreq_scale(tsc_khz_ref, ref_freq, freq->new);
+
 		if (!(freq->flags & CPUFREQ_CONST_LOOPS))
 			mark_tsc_unstable("cpufreq changes");
 
-		set_cyc2ns_scale(tsc_khz, freq->cpu, rdtsc());
+		if (boot_cpu) {
+			boot_cpu_data.loops_per_jiffy = lpj;
+		} else {
+			for_each_cpu(cpu, freq->cpus)
+				cpu_data(cpu).loops_per_jiffy = lpj;
+		}
+
+		for_each_cpu_and(cpu, freq->cpus, cpu_online_mask)
+			set_cyc2ns_scale(tsc_khz, cpu, rdtsc());
 	}
 
 	return 0;
-- 
2.21.0.rc0.269.g1a574e7a288b
