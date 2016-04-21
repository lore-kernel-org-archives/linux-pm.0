From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 03/10] PM / OPP: dev_pm_opp_set_sharing_cpus() doesn't depend on CONFIG_OF
Date: Thu, 21 Apr 2016 14:28:55 +0530
Message-ID: <f13962883e1e55adb8a7391b4fb6538177168adc.1461228504.git.viresh.kumar@linaro.org>
References: <cover.1461228504.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1461228504.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1461228504.git.viresh.kumar@linaro.org>
References: <cover.1461228504.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, arnd.bergmann@linaro.org, andrew@lunn.ch, gregory.clement@free-electrons.com, jason@lakedaemon.net, sebastian.hesselbarth@gmail.com, thomas.petazzoni@free-electrons.com, Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

dev_pm_opp_set_sharing_cpus() doesn't do any DT specific stuff and its
declarations are added within the CONFIG_OF ifdef by mistake. Take them
out of that.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 include/linux/pm_opp.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index cccaf4a29e9f..5b6ad31403a5 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -65,6 +65,7 @@ void dev_pm_opp_put_prop_name(struct device *dev);
 int dev_pm_opp_set_regulator(struct device *dev, const char *name);
 void dev_pm_opp_put_regulator(struct device *dev);
 int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq);
+int dev_pm_opp_set_sharing_cpus(struct device *cpu_dev, cpumask_var_t cpumask);
 #else
 static inline unsigned long dev_pm_opp_get_voltage(struct dev_pm_opp *opp)
 {
@@ -178,6 +179,11 @@ static inline int dev_pm_opp_set_rate(struct device *dev, unsigned long target_f
 	return -EINVAL;
 }
 
+static inline int dev_pm_opp_set_sharing_cpus(struct device *cpu_dev, cpumask_var_t cpumask)
+{
+	return -ENOSYS;
+}
+
 #endif		/* CONFIG_PM_OPP */
 
 #if defined(CONFIG_PM_OPP) && defined(CONFIG_OF)
@@ -186,7 +192,6 @@ void dev_pm_opp_of_remove_table(struct device *dev);
 int dev_pm_opp_of_cpumask_add_table(cpumask_var_t cpumask);
 void dev_pm_opp_of_cpumask_remove_table(cpumask_var_t cpumask);
 int dev_pm_opp_of_get_sharing_cpus(struct device *cpu_dev, cpumask_var_t cpumask);
-int dev_pm_opp_set_sharing_cpus(struct device *cpu_dev, cpumask_var_t cpumask);
 #else
 static inline int dev_pm_opp_of_add_table(struct device *dev)
 {
@@ -210,11 +215,6 @@ static inline int dev_pm_opp_of_get_sharing_cpus(struct device *cpu_dev, cpumask
 {
 	return -ENOSYS;
 }
-
-static inline int dev_pm_opp_set_sharing_cpus(struct device *cpu_dev, cpumask_var_t cpumask)
-{
-	return -ENOSYS;
-}
 #endif
 
 #endif		/* __LINUX_OPP_H__ */
-- 
2.7.1.410.g6faf27b
