From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 4/5] cpufreq: ARM big LITTLE: Move cpu_to_cluster() to arm_big_little.h
Date: Mon, 29 Apr 2013 18:54:47 +0530
Message-ID: <8dd9ca3f1848c74e25d8279dfd6e113b0f537b24.1367241503.git.viresh.kumar@linaro.org>
References: <cover.1367241503.git.viresh.kumar@linaro.org>
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <cover.1367241503.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1367241503.git.viresh.kumar@linaro.org>
References: <cover.1367241503.git.viresh.kumar@linaro.org>
Sender: cpufreq-owner@vger.kernel.org
To: rjw@sisk.pl
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, robin.randhawa@arm.com, Steve.Bannister@arm.com, Liviu.Dudau@arm.com, charles.garcia-tobin@arm.com, arvind.chauhan@arm.com, linux-arm-kernel@lists.infradead.org, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

This routine can be used by glue drivers and so better to keep it in
arm_big_little.h file.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/arm_big_little.c | 5 -----
 drivers/cpufreq/arm_big_little.h | 5 +++++
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/cpufreq/arm_big_little.c b/drivers/cpufreq/arm_big_little.c
index dbdf677..fd7beed 100644
--- a/drivers/cpufreq/arm_big_little.c
+++ b/drivers/cpufreq/arm_big_little.c
@@ -40,11 +40,6 @@ static struct clk *clk[MAX_CLUSTERS];
 static struct cpufreq_frequency_table *freq_table[MAX_CLUSTERS];
 static atomic_t cluster_usage[MAX_CLUSTERS] = {ATOMIC_INIT(0), ATOMIC_INIT(0)};
 
-static int cpu_to_cluster(int cpu)
-{
-	return topology_physical_package_id(cpu);
-}
-
 static unsigned int bL_cpufreq_get(unsigned int cpu)
 {
 	u32 cur_cluster = cpu_to_cluster(cpu);
diff --git a/drivers/cpufreq/arm_big_little.h b/drivers/cpufreq/arm_big_little.h
index 70f18fc..79b2ce1 100644
--- a/drivers/cpufreq/arm_big_little.h
+++ b/drivers/cpufreq/arm_big_little.h
@@ -34,6 +34,11 @@ struct cpufreq_arm_bL_ops {
 	int (*init_opp_table)(struct device *cpu_dev);
 };
 
+static inline int cpu_to_cluster(int cpu)
+{
+	return topology_physical_package_id(cpu);
+}
+
 int bL_cpufreq_register(struct cpufreq_arm_bL_ops *ops);
 void bL_cpufreq_unregister(struct cpufreq_arm_bL_ops *ops);
 
-- 
1.7.12.rc2.18.g61b472e

