From: Nishanth Menon <nm@ti.com>
Subject: [PATCH] thermal: Introduce dummy functions when thermal is not defined
Date: Fri, 13 Feb 2015 19:28:02 -0600
Message-ID: <1423877282-4589-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:48148 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753457AbbBNB2K (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 13 Feb 2015 20:28:10 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, Nishanth Menon <nm@ti.com>

When CONFIG_THERMAL is not enabled, it is better to introduce
equivalent dummy functions in the exported header than to
introduce #ifdeffery in drivers using the function.

This will prevent issues such as that reported in:
http://www.spinics.net/lists/linux-next/msg31573.html

While at it switch over to IS_ENABLED for thermal macros
to allow for thermal framework to be built as framework
and relevant APIs be usable by relevant drivers as a result.

Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Nishanth Menon <nm@ti.com>
---

based on next-20150213 tag.

Note: there are a few "CHECK: Alignment should match open parenthesis"
checkpatch warnings which I ignored since these are pure dummy
functions anyways.

 include/linux/thermal.h |   56 +++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 54 insertions(+), 2 deletions(-)

diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index fc52e307efab..5eac316490ea 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -314,6 +314,8 @@ void thermal_zone_of_sensor_unregister(struct device *dev,
 }
 
 #endif
+
+#if IS_ENABLED(CONFIG_THERMAL)
 struct thermal_zone_device *thermal_zone_device_register(const char *, int, int,
 		void *, struct thermal_zone_device_ops *,
 		const struct thermal_zone_params *, int, int);
@@ -340,8 +342,58 @@ struct thermal_instance *get_thermal_instance(struct thermal_zone_device *,
 		struct thermal_cooling_device *, int);
 void thermal_cdev_update(struct thermal_cooling_device *);
 void thermal_notify_framework(struct thermal_zone_device *, int);
-
-#ifdef CONFIG_NET
+#else
+static inline struct thermal_zone_device *thermal_zone_device_register(
+	const char *type, int trips, int mask, void *devdata,
+	struct thermal_zone_device_ops *ops,
+	const struct thermal_zone_params *tzp,
+	int passive_delay, int polling_delay)
+{ return ERR_PTR(-ENODEV); }
+static inline void thermal_zone_device_unregister(
+	struct thermal_zone_device *tz)
+{ }
+static inline int thermal_zone_bind_cooling_device(
+	struct thermal_zone_device *tz, int trip,
+	struct thermal_cooling_device *cdev,
+	unsigned long upper, unsigned long lower)
+{ return -ENODEV; }
+static inline int thermal_zone_unbind_cooling_device(
+	struct thermal_zone_device *tz, int trip,
+	struct thermal_cooling_device *cdev)
+{ return -ENODEV; }
+static inline void thermal_zone_device_update(struct thermal_zone_device *tz)
+{ }
+static inline struct thermal_cooling_device *
+thermal_cooling_device_register(char *type, void *devdata,
+	const struct thermal_cooling_device_ops *ops)
+{ return ERR_PTR(-ENODEV); }
+static inline struct thermal_cooling_device *
+thermal_of_cooling_device_register(struct device_node *np,
+	char *type, void *devdata, const struct thermal_cooling_device_ops *ops)
+{ return ERR_PTR(-ENODEV); }
+static inline void thermal_cooling_device_unregister(
+	struct thermal_cooling_device *cdev)
+{ }
+static inline struct thermal_zone_device *thermal_zone_get_zone_by_name(
+		const char *name)
+{ return ERR_PTR(-ENODEV); }
+static inline int thermal_zone_get_temp(
+		struct thermal_zone_device *tz, unsigned long *temp)
+{ return -ENODEV; }
+static inline int get_tz_trend(struct thermal_zone_device *tz, int trip)
+{ return -ENODEV; }
+static inline struct thermal_instance *
+get_thermal_instance(struct thermal_zone_device *tz,
+	struct thermal_cooling_device *cdev, int trip)
+{ return ERR_PTR(-ENODEV); }
+static inline void thermal_cdev_update(struct thermal_cooling_device *cdev)
+{ }
+static inline void thermal_notify_framework(struct thermal_zone_device *tz,
+	int trip)
+{ }
+#endif /* CONFIG_THERMAL */
+
+#if defined(CONFIG_NET) && IS_ENABLED(CONFIG_THERMAL)
 extern int thermal_generate_netlink_event(struct thermal_zone_device *tz,
 						enum events event);
 #else
-- 
1.7.9.5

