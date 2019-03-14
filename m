From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 2/7] ARM: smp: Update cpufreq transition notifier to handle multiple CPUs
Date: Thu, 14 Mar 2019 12:12:48 +0530
Message-ID: <4bcc5e47e3b5959e9b1e21578323a84dc9a3c79a.1552545525.git.viresh.kumar@linaro.org>
References: <cover.1552545525.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1552545525.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Russell King <linux@armlinux.org.uk>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The cpufreq core currently calls the cpufreq transition notifier
callback once for each affected CPU. This is going to change soon and
the cpufreq core will call the callback only once for each cpufreq
policy. The callback must look at the newly added field in struct
cpufreq_freqs, "cpus", which contains policy->related_cpus (both
online/offline CPUs) and perform per-cpu actions for them if any.

This patch updates cpufreq_callback() to use the new "cpus" field.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/arm/kernel/smp.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 1d6f5ea522f4..59ee0f4db449 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -758,15 +758,19 @@ static int cpufreq_callback(struct notifier_block *nb,
 					unsigned long val, void *data)
 {
 	struct cpufreq_freqs *freq = data;
-	int cpu = freq->cpu;
+	int cpu, first = cpumask_first(freq->cpus);
+	unsigned int lpj;
 
 	if (freq->flags & CPUFREQ_CONST_LOOPS)
 		return NOTIFY_OK;
 
-	if (!per_cpu(l_p_j_ref, cpu)) {
-		per_cpu(l_p_j_ref, cpu) =
-			per_cpu(cpu_data, cpu).loops_per_jiffy;
-		per_cpu(l_p_j_ref_freq, cpu) = freq->old;
+	if (!per_cpu(l_p_j_ref, first)) {
+		for_each_cpu(cpu, freq->cpus) {
+			per_cpu(l_p_j_ref, cpu) =
+				per_cpu(cpu_data, cpu).loops_per_jiffy;
+			per_cpu(l_p_j_ref_freq, cpu) = freq->old;
+		}
+
 		if (!global_l_p_j_ref) {
 			global_l_p_j_ref = loops_per_jiffy;
 			global_l_p_j_ref_freq = freq->old;
@@ -778,10 +782,11 @@ static int cpufreq_callback(struct notifier_block *nb,
 		loops_per_jiffy = cpufreq_scale(global_l_p_j_ref,
 						global_l_p_j_ref_freq,
 						freq->new);
-		per_cpu(cpu_data, cpu).loops_per_jiffy =
-			cpufreq_scale(per_cpu(l_p_j_ref, cpu),
-					per_cpu(l_p_j_ref_freq, cpu),
-					freq->new);
+
+		lpj = cpufreq_scale(per_cpu(l_p_j_ref, first),
+				    per_cpu(l_p_j_ref_freq, first), freq->new);
+		for_each_cpu(cpu, freq->cpus)
+			per_cpu(cpu_data, cpu).loops_per_jiffy = lpj;
 	}
 	return NOTIFY_OK;
 }
-- 
2.21.0.rc0.269.g1a574e7a288b
