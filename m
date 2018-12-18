From: Vincent Guittot <vincent.guittot@linaro.org>
Subject: [RFC v3 1/3] PM/runtime: Add a new interface to get accounted time
Date: Tue, 18 Dec 2018 15:55:21 +0100
Message-ID: <1545144923-31546-2-git-send-email-vincent.guittot@linaro.org>
References: <1545144923-31546-1-git-send-email-vincent.guittot@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1545144923-31546-1-git-send-email-vincent.guittot@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, rjw@rjwysocki.net, thara.gopinath@linaro.org, jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com, airlied@linux.ie, intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: ulf.hansson@linaro.org, Vincent Guittot <vincent.guittot@linaro.org>
List-Id: linux-pm@vger.kernel.org

Some drivers (like i915/drm) need to get the accounted suspended time.
pm_runtime_accounted_time_get() will return the suspended or active
accounted time until now.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 drivers/base/power/runtime.c | 26 ++++++++++++++++++++++++++
 include/linux/pm_runtime.h   |  2 ++
 2 files changed, 28 insertions(+)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 7062469..6461469 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -88,6 +88,32 @@ static void __update_runtime_status(struct device *dev, enum rpm_status status)
 	dev->power.runtime_status = status;
 }
 
+u64 pm_runtime_accounted_time_get(struct device *dev, enum rpm_status status, bool update)
+{
+	u64 now = ktime_to_ns(ktime_get());
+	u64 delta = 0, time = 0;
+	unsigned long flags;
+
+	spin_lock_irqsave(&dev->power.lock, flags);
+
+	if (dev->power.disable_depth > 0)
+		goto unlock;
+
+	/* Add ongoing state  if requested */
+	if (update && dev->power.runtime_status == status)
+		delta = now - dev->power.accounting_timestamp;
+
+	if (status == RPM_SUSPENDED)
+		time = dev->power.suspended_time + delta;
+	else
+		time = dev->power.active_time + delta;
+
+unlock:
+	spin_unlock_irqrestore(&dev->power.lock, flags);
+
+	return time;
+}
+
 /**
  * pm_runtime_deactivate_timer - Deactivate given device's suspend timer.
  * @dev: Device to handle.
diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
index 54af4ee..86f21f9 100644
--- a/include/linux/pm_runtime.h
+++ b/include/linux/pm_runtime.h
@@ -113,6 +113,8 @@ static inline bool pm_runtime_is_irq_safe(struct device *dev)
 	return dev->power.irq_safe;
 }
 
+extern u64 pm_runtime_accounted_time_get(struct device *dev, enum rpm_status status, bool update);
+
 #else /* !CONFIG_PM */
 
 static inline bool queue_pm_work(struct work_struct *work) { return false; }
-- 
2.7.4
