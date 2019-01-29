From: Amit Kucheria <amit.kucheria@linaro.org>
Subject: [PATCH v5 8/9] cpufreq: scmi: Use auto-registration of thermal cooling device
Date: Tue, 29 Jan 2019 10:25:14 +0530
Message-ID: <a96487a516184166eadb18020b23de273100b442.1548737236.git.amit.kucheria@linaro.org>
References: <cover.1548737236.git.amit.kucheria@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1548737236.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1548737236.git.amit.kucheria@linaro.org>
References: <cover.1548737236.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Use the CPUFREQ_IS_COOLING_DEV flag to allow cpufreq core to
automatically register as a thermal cooling device.

This allows removal of boiler plate code from the driver.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
Acked-by: Sudeep Holla <sudeep.holla@arm.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/cpufreq/scmi-cpufreq.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
index 242c3370544e..66b633b48eb1 100644
--- a/drivers/cpufreq/scmi-cpufreq.c
+++ b/drivers/cpufreq/scmi-cpufreq.c
@@ -11,7 +11,6 @@
 #include <linux/cpu.h>
 #include <linux/cpufreq.h>
 #include <linux/cpumask.h>
-#include <linux/cpu_cooling.h>
 #include <linux/export.h>
 #include <linux/module.h>
 #include <linux/pm_opp.h>
@@ -22,7 +21,6 @@
 struct scmi_data {
 	int domain_id;
 	struct device *cpu_dev;
-	struct thermal_cooling_device *cdev;
 };
 
 static const struct scmi_handle *handle;
@@ -185,7 +183,6 @@ static int scmi_cpufreq_exit(struct cpufreq_policy *policy)
 {
 	struct scmi_data *priv = policy->driver_data;
 
-	cpufreq_cooling_unregister(priv->cdev);
 	dev_pm_opp_free_cpufreq_table(priv->cpu_dev, &policy->freq_table);
 	kfree(priv);
 	dev_pm_opp_remove_all_dynamic(priv->cpu_dev);
@@ -193,17 +190,11 @@ static int scmi_cpufreq_exit(struct cpufreq_policy *policy)
 	return 0;
 }
 
-static void scmi_cpufreq_ready(struct cpufreq_policy *policy)
-{
-	struct scmi_data *priv = policy->driver_data;
-
-	priv->cdev = of_cpufreq_cooling_register(policy);
-}
-
 static struct cpufreq_driver scmi_cpufreq_driver = {
 	.name	= "scmi",
 	.flags	= CPUFREQ_STICKY | CPUFREQ_HAVE_GOVERNOR_PER_POLICY |
-		  CPUFREQ_NEED_INITIAL_FREQ_CHECK,
+		  CPUFREQ_NEED_INITIAL_FREQ_CHECK |
+		  CPUFREQ_IS_COOLING_DEV,
 	.verify	= cpufreq_generic_frequency_table_verify,
 	.attr	= cpufreq_generic_attr,
 	.target_index	= scmi_cpufreq_set_target,
@@ -211,7 +202,6 @@ static struct cpufreq_driver scmi_cpufreq_driver = {
 	.get	= scmi_cpufreq_get_rate,
 	.init	= scmi_cpufreq_init,
 	.exit	= scmi_cpufreq_exit,
-	.ready	= scmi_cpufreq_ready,
 };
 
 static int scmi_cpufreq_probe(struct scmi_device *sdev)
-- 
2.17.1
