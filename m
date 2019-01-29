From: Amit Kucheria <amit.kucheria@linaro.org>
Subject: [PATCH v5 5/9] cpufreq: cpufreq-dt: Use auto-registration of thermal cooling device
Date: Tue, 29 Jan 2019 10:25:11 +0530
Message-ID: <4e19a2d9c5d929cdd87a984953c880c1e5a2e057.1548737236.git.amit.kucheria@linaro.org>
References: <cover.1548737236.git.amit.kucheria@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1548737236.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1548737236.git.amit.kucheria@linaro.org>
References: <cover.1548737236.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Use the CPUFREQ_IS_COOLING_DEV flag to allow cpufreq core to
automatically register as a thermal cooling device.

This allows removal of boiler plate code from the driver.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/cpufreq/cpufreq-dt.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index e58bfcb1169e..7ba392911cd0 100644
--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -13,7 +13,6 @@
 
 #include <linux/clk.h>
 #include <linux/cpu.h>
-#include <linux/cpu_cooling.h>
 #include <linux/cpufreq.h>
 #include <linux/cpumask.h>
 #include <linux/err.h>
@@ -30,7 +29,6 @@
 struct private_data {
 	struct opp_table *opp_table;
 	struct device *cpu_dev;
-	struct thermal_cooling_device *cdev;
 	const char *reg_name;
 	bool have_static_opps;
 };
@@ -301,7 +299,6 @@ static int cpufreq_exit(struct cpufreq_policy *policy)
 {
 	struct private_data *priv = policy->driver_data;
 
-	cpufreq_cooling_unregister(priv->cdev);
 	dev_pm_opp_free_cpufreq_table(priv->cpu_dev, &policy->freq_table);
 	if (priv->have_static_opps)
 		dev_pm_opp_of_cpumask_remove_table(policy->related_cpus);
@@ -314,21 +311,14 @@ static int cpufreq_exit(struct cpufreq_policy *policy)
 	return 0;
 }
 
-static void cpufreq_ready(struct cpufreq_policy *policy)
-{
-	struct private_data *priv = policy->driver_data;
-
-	priv->cdev = of_cpufreq_cooling_register(policy);
-}
-
 static struct cpufreq_driver dt_cpufreq_driver = {
-	.flags = CPUFREQ_STICKY | CPUFREQ_NEED_INITIAL_FREQ_CHECK,
+	.flags = CPUFREQ_STICKY | CPUFREQ_NEED_INITIAL_FREQ_CHECK |
+		 CPUFREQ_IS_COOLING_DEV,
 	.verify = cpufreq_generic_frequency_table_verify,
 	.target_index = set_target,
 	.get = cpufreq_generic_get,
 	.init = cpufreq_init,
 	.exit = cpufreq_exit,
-	.ready = cpufreq_ready,
 	.name = "cpufreq-dt",
 	.attr = cpufreq_dt_attr,
 	.suspend = cpufreq_generic_suspend,
-- 
2.17.1
