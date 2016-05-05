From: Rajendra Nayak <rnayak@codeaurora.org>
Subject: [PATCH v6 04/11] thermal: core: export apis to get slope and offset
Date: Thu,  5 May 2016 14:21:42 +0530
Message-ID: <1462438309-11196-5-git-send-email-rnayak@codeaurora.org>
References: <1462438309-11196-1-git-send-email-rnayak@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1462438309-11196-1-git-send-email-rnayak@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: edubezval@gmail.com, andy.gross@linaro.org
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, rui.zhang@intel.com, sboyd@codeaurora.org, nrajan@codeaurora.org, lina.iyer@linaro.org, punit.agrawal@arm.com, Rajendra Nayak <rnayak@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

Add apis for platform thermal drivers to query for slope and offset
attributes, which might be needed for temperature calculations.

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
---
 Documentation/thermal/sysfs-api.txt | 12 ++++++++++++
 drivers/thermal/thermal_core.c      | 30 ++++++++++++++++++++++++++++++
 include/linux/thermal.h             |  8 ++++++++
 3 files changed, 50 insertions(+)

diff --git a/Documentation/thermal/sysfs-api.txt b/Documentation/thermal/sysfs-api.txt
index ed419d6..3450cb0 100644
--- a/Documentation/thermal/sysfs-api.txt
+++ b/Documentation/thermal/sysfs-api.txt
@@ -140,6 +140,18 @@ temperature) and throttle appropriate devices.
 	Normally this function will not need to be called and the resource
 	management code will ensure that the resource is freed.
 
+1.1.7 int thermal_zone_get_slope(struct thermal_zone_device *tz)
+
+	This interface is used to read the slope attribute value
+	for the thermal zone device, which might be useful for platform
+	drivers for temperature calculations.
+
+1.1.8 int thermal_zone_get_offset(struct thermal_zone_device *tz)
+
+	This interface is used to read the offset attribute value
+	for the thermal zone device, which might be useful for platform
+	drivers for temperature calculations.
+
 1.2 thermal cooling device interface
 1.2.1 struct thermal_cooling_device *thermal_cooling_device_register(char *name,
 		void *devdata, struct thermal_cooling_device_ops *)
diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 5133cd1..b118aae 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -2065,6 +2065,36 @@ exit:
 }
 EXPORT_SYMBOL_GPL(thermal_zone_get_zone_by_name);
 
+/**
+ * thermal_zone_get_slope - return the slope attribute of the thermal zone
+ * @tz: thermal zone device with the slope attribute
+ *
+ * Return: If the thermal zone device has a slope attribute, return it, else
+ * return 1.
+ */
+int thermal_zone_get_slope(struct thermal_zone_device *tz)
+{
+	if (tz && tz->tzp)
+		return tz->tzp->slope;
+	return 1;
+}
+EXPORT_SYMBOL_GPL(thermal_zone_get_slope);
+
+/**
+ * thermal_zone_get_offset - return the offset attribute of the thermal zone
+ * @tz: thermal zone device with the offset attribute
+ *
+ * Return: If the thermal zone device has a offset attribute, return it, else
+ * return 0.
+ */
+int thermal_zone_get_offset(struct thermal_zone_device *tz)
+{
+	if (tz && tz->tzp)
+		return tz->tzp->offset;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(thermal_zone_get_offset);
+
 #ifdef CONFIG_NET
 static const struct genl_multicast_group thermal_event_mcgrps[] = {
 	{ .name = THERMAL_GENL_MCAST_GROUP_NAME, },
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 1b8a5a7..fd206b9 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -432,6 +432,8 @@ thermal_of_cooling_device_register(struct device_node *np, char *, void *,
 void thermal_cooling_device_unregister(struct thermal_cooling_device *);
 struct thermal_zone_device *thermal_zone_get_zone_by_name(const char *name);
 int thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp);
+int thermal_zone_get_slope(struct thermal_zone_device *tz);
+int thermal_zone_get_offset(struct thermal_zone_device *tz);
 
 int get_tz_trend(struct thermal_zone_device *, int);
 struct thermal_instance *get_thermal_instance(struct thermal_zone_device *,
@@ -489,6 +491,12 @@ static inline struct thermal_zone_device *thermal_zone_get_zone_by_name(
 static inline int thermal_zone_get_temp(
 		struct thermal_zone_device *tz, int *temp)
 { return -ENODEV; }
+static inline int thermal_zone_get_slope(
+		struct thermal_zone_device *tz)
+{ return -ENODEV; }
+static inline int thermal_zone_get_offset(
+		struct thermal_zone_device *tz)
+{ return -ENODEV; }
 static inline int get_tz_trend(struct thermal_zone_device *tz, int trip)
 { return -ENODEV; }
 static inline struct thermal_instance *
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
