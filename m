From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCHv4 09/48] thermal: core: move power actor code out of sysfs I/F section
Date: Mon, 30 May 2016 23:18:16 -0700
Message-ID: <1464675535-2433-10-git-send-email-edubezval@gmail.com>
References: <1464675535-2433-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1464675535-2433-1-git-send-email-edubezval@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Keerthy <a0393675@ti.com>, Eduardo Valentin <edubezval@gmail.com>
List-Id: linux-pm@vger.kernel.org

Simply reorganize code to keep only functions of sysfs interface
of thermal zone device together. Therefore, move the power actor code
out of the sysfs I/F section.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
---
 drivers/thermal/thermal_core.c | 162 ++++++++++++++++++++---------------------
 1 file changed, 81 insertions(+), 81 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index a05a293..c3d9473 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -582,6 +582,87 @@ static void thermal_zone_device_check(struct work_struct *work)
 	thermal_zone_device_update(tz);
 }
 
+/**
+ * power_actor_get_max_power() - get the maximum power that a cdev can consume
+ * @cdev:	pointer to &thermal_cooling_device
+ * @tz:		a valid thermal zone device pointer
+ * @max_power:	pointer in which to store the maximum power
+ *
+ * Calculate the maximum power consumption in milliwats that the
+ * cooling device can currently consume and store it in @max_power.
+ *
+ * Return: 0 on success, -EINVAL if @cdev doesn't support the
+ * power_actor API or -E* on other error.
+ */
+int power_actor_get_max_power(struct thermal_cooling_device *cdev,
+			      struct thermal_zone_device *tz, u32 *max_power)
+{
+	if (!cdev_is_power_actor(cdev))
+		return -EINVAL;
+
+	return cdev->ops->state2power(cdev, tz, 0, max_power);
+}
+
+/**
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
+ * power_actor_set_power() - limit the maximum power a cooling device consumes
+ * @cdev:	pointer to &thermal_cooling_device
+ * @instance:	thermal instance to update
+ * @power:	the power in milliwatts
+ *
+ * Set the cooling device to consume at most @power milliwatts. The limit is
+ * expected to be a cap at the maximum power consumption.
+ *
+ * Return: 0 on success, -EINVAL if the cooling device does not
+ * implement the power actor API or -E* for other failures.
+ */
+int power_actor_set_power(struct thermal_cooling_device *cdev,
+			  struct thermal_instance *instance, u32 power)
+{
+	unsigned long state;
+	int ret;
+
+	if (!cdev_is_power_actor(cdev))
+		return -EINVAL;
+
+	ret = cdev->ops->power2state(cdev, instance->tz, power, &state);
+	if (ret)
+		return ret;
+
+	instance->target = state;
+	cdev->updated = false;
+	thermal_cdev_update(cdev);
+
+	return 0;
+}
+
 /* sys I/F for thermal zone */
 
 #define to_thermal_zone(_dev) \
@@ -1095,87 +1176,6 @@ static const struct attribute_group *thermal_zone_attribute_groups[] = {
 	NULL
 };
 
-/**
- * power_actor_get_max_power() - get the maximum power that a cdev can consume
- * @cdev:	pointer to &thermal_cooling_device
- * @tz:		a valid thermal zone device pointer
- * @max_power:	pointer in which to store the maximum power
- *
- * Calculate the maximum power consumption in milliwats that the
- * cooling device can currently consume and store it in @max_power.
- *
- * Return: 0 on success, -EINVAL if @cdev doesn't support the
- * power_actor API or -E* on other error.
- */
-int power_actor_get_max_power(struct thermal_cooling_device *cdev,
-			      struct thermal_zone_device *tz, u32 *max_power)
-{
-	if (!cdev_is_power_actor(cdev))
-		return -EINVAL;
-
-	return cdev->ops->state2power(cdev, tz, 0, max_power);
-}
-
-/**
- * power_actor_get_min_power() - get the mainimum power that a cdev can consume
- * @cdev:	pointer to &thermal_cooling_device
- * @tz:		a valid thermal zone device pointer
- * @min_power:	pointer in which to store the minimum power
- *
- * Calculate the minimum power consumption in milliwatts that the
- * cooling device can currently consume and store it in @min_power.
- *
- * Return: 0 on success, -EINVAL if @cdev doesn't support the
- * power_actor API or -E* on other error.
- */
-int power_actor_get_min_power(struct thermal_cooling_device *cdev,
-			      struct thermal_zone_device *tz, u32 *min_power)
-{
-	unsigned long max_state;
-	int ret;
-
-	if (!cdev_is_power_actor(cdev))
-		return -EINVAL;
-
-	ret = cdev->ops->get_max_state(cdev, &max_state);
-	if (ret)
-		return ret;
-
-	return cdev->ops->state2power(cdev, tz, max_state, min_power);
-}
-
-/**
- * power_actor_set_power() - limit the maximum power a cooling device consumes
- * @cdev:	pointer to &thermal_cooling_device
- * @instance:	thermal instance to update
- * @power:	the power in milliwatts
- *
- * Set the cooling device to consume at most @power milliwatts. The limit is
- * expected to be a cap at the maximum power consumption.
- *
- * Return: 0 on success, -EINVAL if the cooling device does not
- * implement the power actor API or -E* for other failures.
- */
-int power_actor_set_power(struct thermal_cooling_device *cdev,
-			  struct thermal_instance *instance, u32 power)
-{
-	unsigned long state;
-	int ret;
-
-	if (!cdev_is_power_actor(cdev))
-		return -EINVAL;
-
-	ret = cdev->ops->power2state(cdev, instance->tz, power, &state);
-	if (ret)
-		return ret;
-
-	instance->target = state;
-	cdev->updated = false;
-	thermal_cdev_update(cdev);
-
-	return 0;
-}
-
 /* sys I/F for cooling device */
 #define to_cooling_device(_dev)	\
 	container_of(_dev, struct thermal_cooling_device, device)
-- 
2.1.4
