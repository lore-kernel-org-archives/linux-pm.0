From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 2/7] PM / OPP: Mark cpumask as const in dev_pm_opp_set_sharing_cpus()
Date: Wed, 27 Apr 2016 08:52:22 +0530
Message-ID: <9a4fef0ecf8329541140de9bb6ccb393b2ec21db.1461727086.git.viresh.kumar@linaro.org>
References: <cover.1461727086.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1461727086.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1461727086.git.viresh.kumar@linaro.org>
References: <cover.1461727086.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, arnd.bergmann@linaro.org, Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

dev_pm_opp_set_sharing_cpus() isn't supposed to update the cpumask
passed as its parameter, and so it should always have been marked
'const'.

Do it now.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/opp/cpu.c | 3 ++-
 include/linux/pm_opp.h       | 4 ++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/base/power/opp/cpu.c b/drivers/base/power/opp/cpu.c
index 55cbf9bd8707..5469e7730ff2 100644
--- a/drivers/base/power/opp/cpu.c
+++ b/drivers/base/power/opp/cpu.c
@@ -287,7 +287,8 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_of_get_sharing_cpus);
  * that this function is *NOT* called under RCU protection or in contexts where
  * mutex cannot be locked.
  */
-int dev_pm_opp_set_sharing_cpus(struct device *cpu_dev, cpumask_var_t cpumask)
+int dev_pm_opp_set_sharing_cpus(struct device *cpu_dev,
+				const cpumask_var_t cpumask)
 {
 	struct opp_device *opp_dev;
 	struct opp_table *opp_table;
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index a2df8f6fcc25..0c08ed3836b1 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -65,7 +65,7 @@ void dev_pm_opp_put_prop_name(struct device *dev);
 int dev_pm_opp_set_regulator(struct device *dev, const char *name);
 void dev_pm_opp_put_regulator(struct device *dev);
 int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq);
-int dev_pm_opp_set_sharing_cpus(struct device *cpu_dev, cpumask_var_t cpumask);
+int dev_pm_opp_set_sharing_cpus(struct device *cpu_dev, const cpumask_var_t cpumask);
 #else
 static inline unsigned long dev_pm_opp_get_voltage(struct dev_pm_opp *opp)
 {
@@ -179,7 +179,7 @@ static inline int dev_pm_opp_set_rate(struct device *dev, unsigned long target_f
 	return -ENOTSUPP;
 }
 
-static inline int dev_pm_opp_set_sharing_cpus(struct device *cpu_dev, cpumask_var_t cpumask)
+static inline int dev_pm_opp_set_sharing_cpus(struct device *cpu_dev, const cpumask_var_t cpumask)
 {
 	return -ENOTSUPP;
 }
-- 
2.7.1.410.g6faf27b
