From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 2/2] PM / Runtime: Use pm_runtime_active|suspended_time() from sysfs
Date: Tue,  5 Mar 2019 13:55:35 +0100
Message-ID: <20190305125535.21412-1-ulf.hansson@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Let's avoid the open-coding in runtime_active|suspend_time_show() and
convert to use pm_runtime_active|suspended_time() instead.

Note that, this change also indirectly avoid us from keeping the
dev->power.lock held, while doing the do_div() and the sprintf()
operations, which is yet another improvement.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/runtime.c |  2 +-
 drivers/base/power/sysfs.c   | 12 ++----------
 include/linux/pm.h           |  1 -
 3 files changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index d1908fc422cc..17136da0bb6a 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -64,7 +64,7 @@ static int rpm_suspend(struct device *dev, int rpmflags);
  * runtime_status field is updated, to account the time in the old state
  * correctly.
  */
-void update_pm_runtime_accounting(struct device *dev)
+static void update_pm_runtime_accounting(struct device *dev)
 {
 	u64 now, last, delta;
 
diff --git a/drivers/base/power/sysfs.c b/drivers/base/power/sysfs.c
index c6bf76124184..1226e441ddfe 100644
--- a/drivers/base/power/sysfs.c
+++ b/drivers/base/power/sysfs.c
@@ -125,13 +125,9 @@ static ssize_t runtime_active_time_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
 	int ret;
-	u64 tmp;
-	spin_lock_irq(&dev->power.lock);
-	update_pm_runtime_accounting(dev);
-	tmp = dev->power.active_time;
+	u64 tmp = pm_runtime_active_time(dev);
 	do_div(tmp, NSEC_PER_MSEC);
 	ret = sprintf(buf, "%llu\n", tmp);
-	spin_unlock_irq(&dev->power.lock);
 	return ret;
 }
 
@@ -141,13 +137,9 @@ static ssize_t runtime_suspended_time_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
 	int ret;
-	u64 tmp;
-	spin_lock_irq(&dev->power.lock);
-	update_pm_runtime_accounting(dev);
-	tmp = dev->power.suspended_time;
+	u64 tmp = pm_runtime_suspended_time(dev);
 	do_div(tmp, NSEC_PER_MSEC);
 	ret = sprintf(buf, "%llu\n", tmp);
-	spin_unlock_irq(&dev->power.lock);
 	return ret;
 }
 
diff --git a/include/linux/pm.h b/include/linux/pm.h
index 06f7ed893928..66c19a65a514 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -643,7 +643,6 @@ struct dev_pm_info {
 	struct dev_pm_qos	*qos;
 };
 
-extern void update_pm_runtime_accounting(struct device *dev);
 extern int dev_pm_get_subsys_data(struct device *dev);
 extern void dev_pm_put_subsys_data(struct device *dev);
 
-- 
2.17.1
