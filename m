From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: [PATCH v4 03/10] cpufreq: arm_big_little: invoke frequency-invariance setter function
Date: Fri, 25 Aug 2017 15:31:59 +0100
Message-ID: <20170825143206.30467-4-dietmar.eggemann@arm.com>
References: <20170825143206.30467-1-dietmar.eggemann@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170825143206.30467-1-dietmar.eggemann@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, linux@arm.linux.org.uk, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Juri Lelli <juri.lelli@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>, Peter Zijlstra <peterz@infradead.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Sudeep Holla <sudeep.holla@arm.com>
List-Id: linux-pm@vger.kernel.org

Call the frequency-invariance setter function arch_set_freq_scale()
if the new frequency has been successfully set which is indicated by
bL_cpufreq_set_rate() returning 0.

Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/arm_big_little.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/arm_big_little.c b/drivers/cpufreq/arm_big_little.c
index ea6d62547b10..8880f8d9d09d 100644
--- a/drivers/cpufreq/arm_big_little.c
+++ b/drivers/cpufreq/arm_big_little.c
@@ -213,6 +213,7 @@ static int bL_cpufreq_set_target(struct cpufreq_policy *policy,
 {
 	u32 cpu = policy->cpu, cur_cluster, new_cluster, actual_cluster;
 	unsigned int freqs_new;
+	int ret;
 
 	cur_cluster = cpu_to_cluster(cpu);
 	new_cluster = actual_cluster = per_cpu(physical_cluster, cpu);
@@ -229,7 +230,14 @@ static int bL_cpufreq_set_target(struct cpufreq_policy *policy,
 		}
 	}
 
-	return bL_cpufreq_set_rate(cpu, actual_cluster, new_cluster, freqs_new);
+	ret = bL_cpufreq_set_rate(cpu, actual_cluster, new_cluster, freqs_new);
+
+	if (!ret) {
+		arch_set_freq_scale(policy->related_cpus, freqs_new,
+				    policy->cpuinfo.max_freq);
+	}
+
+	return ret;
 }
 
 static inline u32 get_table_count(struct cpufreq_frequency_table *table)
-- 
2.11.0
