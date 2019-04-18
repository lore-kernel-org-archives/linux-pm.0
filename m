From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 1/6] thermal: Introduce devm_thermal_of_cooling_device_register
Date: Thu, 18 Apr 2019 12:58:15 -0700
Message-ID: <1555617500-10862-2-git-send-email-linux@roeck-us.net>
References: <1555617500-10862-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1555617500-10862-1-git-send-email-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-hwmon@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org, linux-pm@vger.kernel.org
Cc: Jean Delvare <jdelvare@suse.com>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>, Avi Fishman <avifishman70@gmail.com>, Tomer Maimon <tmaimon77@gmail.com>, Tali Perry <tali.perry1@gmail.com>, Patrick Venture <venture@google.com>, Nancy Yuen <yuenn@google.com>, Benjamin Fair <benjaminfair@google.com>, Kamil Debski <kamil@wypas.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Guenter Roeck <linux@roeck-us.net>
List-Id: linux-pm@vger.kernel.org

thermal_of_cooling_device_register() and thermal_cooling_device_register()
are typically called from driver probe functions, and
thermal_cooling_device_unregister() is called from remove functions. This
makes both a perfect candidate for device managed functions.

Introduce devm_thermal_of_cooling_device_register(). This function can
also be used to replace thermal_cooling_device_register() by passing a NULL
pointer as device node. The new function requires both struct device *
and struct device_node * as parameters since the struct device_node *
parameter is not always identical to dev->of_node.

Don't introduce a device managed remove function since it is not needed
at this point.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/thermal/thermal_core.c | 49 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/thermal.h        |  5 +++++
 2 files changed, 54 insertions(+)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 6590bb5cb688..e0b530603db6 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1046,6 +1046,55 @@ thermal_of_cooling_device_register(struct device_node *np,
 }
 EXPORT_SYMBOL_GPL(thermal_of_cooling_device_register);
 
+static void thermal_cooling_device_release(struct device *dev, void *res)
+{
+	thermal_cooling_device_unregister(
+				*(struct thermal_cooling_device **)res);
+}
+
+/**
+ * devm_thermal_of_cooling_device_register() - register an OF thermal cooling
+ *					       device
+ * @dev:	a valid struct device pointer of a sensor device.
+ * @np:		a pointer to a device tree node.
+ * @type:	the thermal cooling device type.
+ * @devdata:	device private data.
+ * @ops:	standard thermal cooling devices callbacks.
+ *
+ * This function will register a cooling device with device tree node reference.
+ * This interface function adds a new thermal cooling device (fan/processor/...)
+ * to /sys/class/thermal/ folder as cooling_device[0-*]. It tries to bind itself
+ * to all the thermal zone devices registered at the same time.
+ *
+ * Return: a pointer to the created struct thermal_cooling_device or an
+ * ERR_PTR. Caller must check return value with IS_ERR*() helpers.
+ */
+struct thermal_cooling_device *
+devm_thermal_of_cooling_device_register(struct device *dev,
+				struct device_node *np,
+				char *type, void *devdata,
+				const struct thermal_cooling_device_ops *ops)
+{
+	struct thermal_cooling_device **ptr, *tcd;
+
+	ptr = devres_alloc(thermal_cooling_device_release, sizeof(*ptr),
+			   GFP_KERNEL);
+	if (!ptr)
+		return ERR_PTR(-ENOMEM);
+
+	tcd = __thermal_cooling_device_register(np, type, devdata, ops);
+	if (IS_ERR(tcd)) {
+		devres_free(ptr);
+		return tcd;
+	}
+
+	*ptr = tcd;
+	devres_add(dev, ptr);
+
+	return tcd;
+}
+EXPORT_SYMBOL_GPL(devm_thermal_of_cooling_device_register);
+
 static void __unbind(struct thermal_zone_device *tz, int mask,
 		     struct thermal_cooling_device *cdev)
 {
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 5f4705f46c2f..43cf4fdd71d4 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -447,6 +447,11 @@ struct thermal_cooling_device *thermal_cooling_device_register(char *, void *,
 struct thermal_cooling_device *
 thermal_of_cooling_device_register(struct device_node *np, char *, void *,
 				   const struct thermal_cooling_device_ops *);
+struct thermal_cooling_device *
+devm_thermal_of_cooling_device_register(struct device *dev,
+				struct device_node *np,
+				char *type, void *devdata,
+				const struct thermal_cooling_device_ops *ops);
 void thermal_cooling_device_unregister(struct thermal_cooling_device *);
 struct thermal_zone_device *thermal_zone_get_zone_by_name(const char *name);
 int thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp);
-- 
2.7.4
