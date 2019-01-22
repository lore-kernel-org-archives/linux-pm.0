From: Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 2/2] PM-runtime: Replace jiffies based accounting with ktime-based accounting
Date: Tue, 22 Jan 2019 15:24:30 +0100
Message-ID: <1548167070-421-3-git-send-email-vincent.guittot@linaro.org>
References: <1548167070-421-1-git-send-email-vincent.guittot@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1548167070-421-1-git-send-email-vincent.guittot@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, rjw@rjwysocki.net, thara.gopinath@linaro.org, linux@roeck-us.net
Cc: ulf.hansson@linaro.org, Vincent Guittot <vincent.guittot@linaro.org>
List-Id: linux-pm@vger.kernel.org

From: Thara Gopinath <thara.gopinath@linaro.org>

This patch replaces jiffies based accounting for runtime_active_time
and runtime_suspended_time with ktime-based accounting. This makes the
runtime debug counters inline with genpd and other PM subsytems which
use ktime-based accounting.

Timekeeping is initialized before driver_init(). It's only at that time
that PM runtime can be enabled.

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
[switch from ktime to raw nsec]
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 drivers/base/power/runtime.c | 17 +++++++++--------
 drivers/base/power/sysfs.c   | 11 ++++++++---
 include/linux/pm.h           |  6 +++---
 3 files changed, 20 insertions(+), 14 deletions(-)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 7df1d05..e49b3a8 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -66,8 +66,8 @@ static int rpm_suspend(struct device *dev, int rpmflags);
  */
 void update_pm_runtime_accounting(struct device *dev)
 {
-	unsigned long now = jiffies;
-	unsigned long delta;
+	u64 now = ktime_to_ns(ktime_get());
+	u64 delta;
 
 	delta = now - dev->power.accounting_timestamp;
 
@@ -77,9 +77,9 @@ void update_pm_runtime_accounting(struct device *dev)
 		return;
 
 	if (dev->power.runtime_status == RPM_SUSPENDED)
-		dev->power.suspended_jiffies += delta;
+		dev->power.suspended_time += delta;
 	else
-		dev->power.active_jiffies += delta;
+		dev->power.active_time += delta;
 }
 
 static void __update_runtime_status(struct device *dev, enum rpm_status status)
@@ -90,16 +90,17 @@ static void __update_runtime_status(struct device *dev, enum rpm_status status)
 
 u64 pm_runtime_suspended_time(struct device *dev)
 {
-	unsigned long flags, time;
+	u64 time;
+	unsigned long flags;
 
 	spin_lock_irqsave(&dev->power.lock, flags);
 
 	update_pm_runtime_accounting(dev);
-	time = dev->power.suspended_jiffies;
+	time = dev->power.suspended_time;
 
 	spin_unlock_irqrestore(&dev->power.lock, flags);
 
-	return jiffies_to_nsecs(time);
+	return time;
 }
 EXPORT_SYMBOL_GPL(pm_runtime_suspended_time);
 
@@ -1308,7 +1309,7 @@ void pm_runtime_enable(struct device *dev)
 
 	/* About to enable runtime pm, set accounting_timestamp to now */
 	if (dev->power.disable_depth == 1)
-		dev->power.accounting_timestamp = jiffies;
+		dev->power.accounting_timestamp = ktime_to_ns(ktime_get());
 
 	if (dev->power.disable_depth > 0)
 		dev->power.disable_depth--;
diff --git a/drivers/base/power/sysfs.c b/drivers/base/power/sysfs.c
index d713738..96c8a22 100644
--- a/drivers/base/power/sysfs.c
+++ b/drivers/base/power/sysfs.c
@@ -125,9 +125,12 @@ static ssize_t runtime_active_time_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
 	int ret;
+	u64 tmp;
 	spin_lock_irq(&dev->power.lock);
 	update_pm_runtime_accounting(dev);
-	ret = sprintf(buf, "%i\n", jiffies_to_msecs(dev->power.active_jiffies));
+	tmp = dev->power.active_time;
+	do_div(tmp, NSEC_PER_MSEC);
+	ret = sprintf(buf, "%llu\n", tmp);
 	spin_unlock_irq(&dev->power.lock);
 	return ret;
 }
@@ -138,10 +141,12 @@ static ssize_t runtime_suspended_time_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
 	int ret;
+	u64 tmp;
 	spin_lock_irq(&dev->power.lock);
 	update_pm_runtime_accounting(dev);
-	ret = sprintf(buf, "%i\n",
-		jiffies_to_msecs(dev->power.suspended_jiffies));
+	tmp = dev->power.suspended_time;
+	do_div(tmp, NSEC_PER_MSEC);
+	ret = sprintf(buf, "%llu\n", tmp);
 	spin_unlock_irq(&dev->power.lock);
 	return ret;
 }
diff --git a/include/linux/pm.h b/include/linux/pm.h
index 0bd9de1..3d2cbf9 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -633,9 +633,9 @@ struct dev_pm_info {
 	int			runtime_error;
 	int			autosuspend_delay;
 	u64			last_busy;
-	unsigned long		active_jiffies;
-	unsigned long		suspended_jiffies;
-	unsigned long		accounting_timestamp;
+	u64			active_time;
+	u64			suspended_time;
+	u64			accounting_timestamp;
 #endif
 	struct pm_subsys_data	*subsys_data;  /* Owned by the subsystem. */
 	void (*set_latency_tolerance)(struct device *, s32);
-- 
2.7.4
