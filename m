From: Amit Daniel Kachhap <amit.daniel@samsung.com>
Subject: [PATCH RFC v4 1/3] PM / Runtime: Add an API pm_runtime_set_slave
Date: Mon, 09 Feb 2015 16:32:04 +0530
Message-ID: <1423479726-23140-2-git-send-email-amit.daniel@samsung.com>
References: <1423479726-23140-1-git-send-email-amit.daniel@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1423479726-23140-1-git-send-email-amit.daniel@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, khilman@linaro.org, rjw@rjwysocki.net, len.brown@intel.com, ulf.hansson@linaro.org, tomasz.figa@gmail.com, kgene.kim@samsung.com, s.nawrocki@samsung.com, thomas.ab@samsung.com, pankaj.dubey@samsung.com, m.szyprowski@samsung.com, geert+renesas@glider.be, Amit Daniel Kachhap <amit.daniel@samsung.com>
List-Id: linux-pm@vger.kernel.org

This API creates a pm runtime slave type device which does not itself
participates in pm runtime but depends on the master devices to power
manage them. These devices should have pm runtime callbacks.

These devices (like clock) may not implement complete pm_runtime calls
such as pm_runtime_get/pm_runtime_put due to subsystems interaction
behaviour or any other reason.

Signed-off-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
---
 drivers/base/power/runtime.c | 18 ++++++++++++++++++
 include/linux/pm.h           |  1 +
 include/linux/pm_runtime.h   |  2 ++
 3 files changed, 21 insertions(+)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 5070c4f..e247f08 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -1252,6 +1252,24 @@ void pm_runtime_no_callbacks(struct device *dev)
 EXPORT_SYMBOL_GPL(pm_runtime_no_callbacks);
 
 /**
+ * pm_runtime_set_slave - Set these devices as slave.
+ * @dev: Device to handle.
+ *
+ * Set the power.slave flag, which tells the PM core that this device is
+ * power-managed by the master device through the runtime callbacks. Since it
+ * will not manage runtime callbacks on its own, so runtime sysfs attributes is
+ * removed.
+ */
+void pm_runtime_set_slave(struct device *dev)
+{
+	spin_lock_irq(&dev->power.lock);
+	dev->power.slave = true;
+	spin_unlock_irq(&dev->power.lock);
+	if (device_is_registered(dev))
+		rpm_sysfs_remove(dev);
+}
+
+/**
  * pm_runtime_irq_safe - Leave interrupts disabled during callbacks.
  * @dev: Device to handle
  *
diff --git a/include/linux/pm.h b/include/linux/pm.h
index 8b59763..a4090ef 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -581,6 +581,7 @@ struct dev_pm_info {
 	unsigned int		use_autosuspend:1;
 	unsigned int		timer_autosuspends:1;
 	unsigned int		memalloc_noio:1;
+	unsigned int		slave:1;
 	enum rpm_request	request;
 	enum rpm_status		runtime_status;
 	int			runtime_error;
diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
index 30e84d4..0707a4b 100644
--- a/include/linux/pm_runtime.h
+++ b/include/linux/pm_runtime.h
@@ -47,6 +47,7 @@ extern void __pm_runtime_disable(struct device *dev, bool check_resume);
 extern void pm_runtime_allow(struct device *dev);
 extern void pm_runtime_forbid(struct device *dev);
 extern void pm_runtime_no_callbacks(struct device *dev);
+extern void pm_runtime_set_slave(struct device *dev);
 extern void pm_runtime_irq_safe(struct device *dev);
 extern void __pm_runtime_use_autosuspend(struct device *dev, bool use);
 extern void pm_runtime_set_autosuspend_delay(struct device *dev, int delay);
@@ -168,6 +169,7 @@ static inline bool pm_runtime_suspended_if_enabled(struct device *dev) { return
 static inline bool pm_runtime_enabled(struct device *dev) { return false; }
 
 static inline void pm_runtime_no_callbacks(struct device *dev) {}
+static inline void pm_runtime_set_slave(struct device *dev) {}
 static inline void pm_runtime_irq_safe(struct device *dev) {}
 static inline bool pm_runtime_is_irq_safe(struct device *dev) { return false; }
 
-- 
2.2.0
