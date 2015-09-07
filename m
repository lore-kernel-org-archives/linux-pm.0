From: Javi Merino <javi.merino@arm.com>
Subject: [PATCH v5 1/5] thermal: Add a function to get the minimum power
Date: Mon,  7 Sep 2015 14:19:25 +0100
Message-ID: <1441631969-3272-2-git-send-email-javi.merino@arm.com>
References: <1440595604-27197-1-git-send-email-javi.merino@arm.com>
 <1441631969-3272-1-git-send-email-javi.merino@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1441631969-3272-1-git-send-email-javi.merino@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, cywang@chromium.org, linux-kernel@vger.kernel.org, punit.agrawal@arm.com, djkurtz@chromium.org, edubezval@gmail.com, Javi Merino <javi.merino@arm.com>, Zhang Rui <rui.zhang@intel.com>
List-Id: linux-pm@vger.kernel.org

The thermal core already has a function to get the maximum power of a
cooling device: power_actor_get_max_power().  Add a function to get the
minimum power of a cooling device.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <edubezval@gmail.com>
Signed-off-by: Javi Merino <javi.merino@arm.com>
---
 drivers/thermal/thermal_core.c | 28 ++++++++++++++++++++++++++++
 include/linux/thermal.h        |  6 ++++++
 2 files changed, 34 insertions(+)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 4ca211be4c0f..760204f0b63c 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -997,6 +997,34 @@ int power_actor_get_max_power(struct thermal_cooling_device *cdev,
 }
 
 /**
+ * power_actor_get_min_power() - get the mainimum power that a cdev can consume
+ * @cdev:	pointer to &thermal_cooling_device
+ * @tz:		a valid thermal zone device pointer
+ * @min_power:	pointer in which to store the minimum power
+ *
+ * Calculate the minimum power consumption in milliwatts that the
+ * cooling device can currently consume and store it in @min_power.
+ *
+ * Return: 0 on success, -EINVAL if @cdev doesn't support the
+ * power_actor API or -E* on other error.
+ */
+int power_actor_get_min_power(struct thermal_cooling_device *cdev,
+			      struct thermal_zone_device *tz, u32 *min_power)
+{
+	unsigned long max_state;
+	int ret;
+
+	if (!cdev_is_power_actor(cdev))
+		return -EINVAL;
+
+	ret = cdev->ops->get_max_state(cdev, &max_state);
+	if (ret)
+		return ret;
+
+	return cdev->ops->state2power(cdev, tz, max_state, min_power);
+}
+
+/**
  * power_actor_set_power() - limit the maximum power that a cooling device can consume
  * @cdev:	pointer to &thermal_cooling_device
  * @instance:	thermal instance to update
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 037e9df2f610..f99d934d373a 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -384,6 +384,8 @@ static inline bool cdev_is_power_actor(struct thermal_cooling_device *cdev)
 
 int power_actor_get_max_power(struct thermal_cooling_device *,
 			      struct thermal_zone_device *tz, u32 *max_power);
+int power_actor_get_min_power(struct thermal_cooling_device *,
+			      struct thermal_zone_device *tz, u32 *min_power);
 int power_actor_set_power(struct thermal_cooling_device *,
 			  struct thermal_instance *, u32);
 struct thermal_zone_device *thermal_zone_device_register(const char *, int, int,
@@ -419,6 +421,10 @@ static inline bool cdev_is_power_actor(struct thermal_cooling_device *cdev)
 static inline int power_actor_get_max_power(struct thermal_cooling_device *cdev,
 			      struct thermal_zone_device *tz, u32 *max_power)
 { return 0; }
+static inline int power_actor_get_min_power(struct thermal_cooling_device *cdev,
+					    struct thermal_zone_device *tz,
+					    u32 *min_power)
+{ return -ENODEV; }
 static inline int power_actor_set_power(struct thermal_cooling_device *cdev,
 			  struct thermal_instance *tz, u32 power)
 { return 0; }
-- 
1.9.1
