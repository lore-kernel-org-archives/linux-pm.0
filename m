From: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH 1/2] cpufreq: arm_big_little: make function arguments and structure pointer const
Date: Thu, 19 Oct 2017 12:59:14 +0200
Message-ID: <1508410755-13666-2-git-send-email-bhumirks@gmail.com>
References: <1508410755-13666-1-git-send-email-bhumirks@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1508410755-13666-1-git-send-email-bhumirks@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: julia.lawall@lip6.fr, viresh.kumar@linaro.org, sudeep.holla@arm.com, rjw@rjwysocki.net, liviu.dudau@arm.com, lorenzo.pieralisi@arm.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Bhumika Goyal <bhumirks@gmail.com>
List-Id: linux-pm@vger.kernel.org

Make the arguments of functions bL_cpufreq_{register/unregister} as
const as the ops pointer does not modify the fields of the
cpufreq_arm_bL_ops structure it points to. The pointer arm_bL_ops is
also getting initialized with ops but the pointer does not modify the
fields. So, make the function argument and the structure pointer const.
Add const to function prototypes too.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 drivers/cpufreq/arm_big_little.c | 6 +++---
 drivers/cpufreq/arm_big_little.h | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/cpufreq/arm_big_little.c b/drivers/cpufreq/arm_big_little.c
index 0c41ab3..65ec5f0 100644
--- a/drivers/cpufreq/arm_big_little.c
+++ b/drivers/cpufreq/arm_big_little.c
@@ -57,7 +57,7 @@
 #define VIRT_FREQ(cluster, freq)    ((cluster == A7_CLUSTER) ? freq >> 1 : freq)
 
 static struct thermal_cooling_device *cdev[MAX_CLUSTERS];
-static struct cpufreq_arm_bL_ops *arm_bL_ops;
+static const struct cpufreq_arm_bL_ops *arm_bL_ops;
 static struct clk *clk[MAX_CLUSTERS];
 static struct cpufreq_frequency_table *freq_table[MAX_CLUSTERS + 1];
 static atomic_t cluster_usage[MAX_CLUSTERS + 1];
@@ -617,7 +617,7 @@ static int __bLs_unregister_notifier(void)
 static int __bLs_unregister_notifier(void) { return 0; }
 #endif
 
-int bL_cpufreq_register(struct cpufreq_arm_bL_ops *ops)
+int bL_cpufreq_register(const struct cpufreq_arm_bL_ops *ops)
 {
 	int ret, i;
 
@@ -661,7 +661,7 @@ int bL_cpufreq_register(struct cpufreq_arm_bL_ops *ops)
 }
 EXPORT_SYMBOL_GPL(bL_cpufreq_register);
 
-void bL_cpufreq_unregister(struct cpufreq_arm_bL_ops *ops)
+void bL_cpufreq_unregister(const struct cpufreq_arm_bL_ops *ops)
 {
 	if (arm_bL_ops != ops) {
 		pr_err("%s: Registered with: %s, can't unregister, exiting\n",
diff --git a/drivers/cpufreq/arm_big_little.h b/drivers/cpufreq/arm_big_little.h
index 184d7c3..88a176e 100644
--- a/drivers/cpufreq/arm_big_little.h
+++ b/drivers/cpufreq/arm_big_little.h
@@ -37,7 +37,7 @@ struct cpufreq_arm_bL_ops {
 	void (*free_opp_table)(const struct cpumask *cpumask);
 };
 
-int bL_cpufreq_register(struct cpufreq_arm_bL_ops *ops);
-void bL_cpufreq_unregister(struct cpufreq_arm_bL_ops *ops);
+int bL_cpufreq_register(const struct cpufreq_arm_bL_ops *ops);
+void bL_cpufreq_unregister(const struct cpufreq_arm_bL_ops *ops);
 
 #endif /* CPUFREQ_ARM_BIG_LITTLE_H */
-- 
1.9.1
