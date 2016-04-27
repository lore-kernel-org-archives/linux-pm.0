From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 1/7] PM / OPP: -ENOSYS is applicable only to syscalls
Date: Wed, 27 Apr 2016 08:52:21 +0530
Message-ID: <ef830e7b9737612f6594b3580c6a3731172a4c76.1461727086.git.viresh.kumar@linaro.org>
References: <cover.1461727086.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1461727086.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1461727086.git.viresh.kumar@linaro.org>
References: <cover.1461727086.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, arnd.bergmann@linaro.org, Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Some of the routines have used -ENOSYS for the cases where the
functionality isn't implemented in the kernel. But ENOSYS is supposed to
be used only for syscalls.

Replace that with -ENOTSUPP, which specifically means that the operation
isn't supported.

While at it, replace exiting -EINVAL errors for similar cases to
-ENOTSUPP.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 include/linux/pm_opp.h | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index 5b6ad31403a5..a2df8f6fcc25 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -110,25 +110,25 @@ static inline struct dev_pm_opp *dev_pm_opp_get_suspend_opp(struct device *dev)
 static inline struct dev_pm_opp *dev_pm_opp_find_freq_exact(struct device *dev,
 					unsigned long freq, bool available)
 {
-	return ERR_PTR(-EINVAL);
+	return ERR_PTR(-ENOTSUPP);
 }
 
 static inline struct dev_pm_opp *dev_pm_opp_find_freq_floor(struct device *dev,
 					unsigned long *freq)
 {
-	return ERR_PTR(-EINVAL);
+	return ERR_PTR(-ENOTSUPP);
 }
 
 static inline struct dev_pm_opp *dev_pm_opp_find_freq_ceil(struct device *dev,
 					unsigned long *freq)
 {
-	return ERR_PTR(-EINVAL);
+	return ERR_PTR(-ENOTSUPP);
 }
 
 static inline int dev_pm_opp_add(struct device *dev, unsigned long freq,
 					unsigned long u_volt)
 {
-	return -EINVAL;
+	return -ENOTSUPP;
 }
 
 static inline void dev_pm_opp_remove(struct device *dev, unsigned long freq)
@@ -148,40 +148,40 @@ static inline int dev_pm_opp_disable(struct device *dev, unsigned long freq)
 static inline struct srcu_notifier_head *dev_pm_opp_get_notifier(
 							struct device *dev)
 {
-	return ERR_PTR(-EINVAL);
+	return ERR_PTR(-ENOTSUPP);
 }
 
 static inline int dev_pm_opp_set_supported_hw(struct device *dev,
 					      const u32 *versions,
 					      unsigned int count)
 {
-	return -EINVAL;
+	return -ENOTSUPP;
 }
 
 static inline void dev_pm_opp_put_supported_hw(struct device *dev) {}
 
 static inline int dev_pm_opp_set_prop_name(struct device *dev, const char *name)
 {
-	return -EINVAL;
+	return -ENOTSUPP;
 }
 
 static inline void dev_pm_opp_put_prop_name(struct device *dev) {}
 
 static inline int dev_pm_opp_set_regulator(struct device *dev, const char *name)
 {
-	return -EINVAL;
+	return -ENOTSUPP;
 }
 
 static inline void dev_pm_opp_put_regulator(struct device *dev) {}
 
 static inline int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 {
-	return -EINVAL;
+	return -ENOTSUPP;
 }
 
 static inline int dev_pm_opp_set_sharing_cpus(struct device *cpu_dev, cpumask_var_t cpumask)
 {
-	return -ENOSYS;
+	return -ENOTSUPP;
 }
 
 #endif		/* CONFIG_PM_OPP */
@@ -195,7 +195,7 @@ int dev_pm_opp_of_get_sharing_cpus(struct device *cpu_dev, cpumask_var_t cpumask
 #else
 static inline int dev_pm_opp_of_add_table(struct device *dev)
 {
-	return -EINVAL;
+	return -ENOTSUPP;
 }
 
 static inline void dev_pm_opp_of_remove_table(struct device *dev)
@@ -204,7 +204,7 @@ static inline void dev_pm_opp_of_remove_table(struct device *dev)
 
 static inline int dev_pm_opp_of_cpumask_add_table(cpumask_var_t cpumask)
 {
-	return -ENOSYS;
+	return -ENOTSUPP;
 }
 
 static inline void dev_pm_opp_of_cpumask_remove_table(cpumask_var_t cpumask)
@@ -213,7 +213,7 @@ static inline void dev_pm_opp_of_cpumask_remove_table(cpumask_var_t cpumask)
 
 static inline int dev_pm_opp_of_get_sharing_cpus(struct device *cpu_dev, cpumask_var_t cpumask)
 {
-	return -ENOSYS;
+	return -ENOTSUPP;
 }
 #endif
 
-- 
2.7.1.410.g6faf27b
