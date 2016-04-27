From: Aaron Lu <aaron.lu@intel.com>
Subject: [PATCH v3 1/4] video / backlight: add two APIs for drivers to use
Date: Wed, 27 Apr 2016 20:45:02 +0800
Message-ID: <1461761105-5961-2-git-send-email-aaron.lu@intel.com>
References: <1461761105-5961-1-git-send-email-aaron.lu@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1461761105-5961-1-git-send-email-aaron.lu@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Zhang Rui <rui.zhang@intel.com>, Jingoo Han <jingoohan1@gmail.com>
Cc: linux-fbdev@vger.kernel.org, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@intel.com>
List-Id: linux-pm@vger.kernel.org

It is useful to get the backlight device's pointer and use it to set
backlight in some cases(the following patch will make use of it) so add
the two APIs and export them.

Signed-off-by: Aaron Lu <aaron.lu@intel.com>
Acked-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/video/backlight/backlight.c | 43 +++++++++++++++++++++++++------------
 include/linux/backlight.h           |  2 ++
 2 files changed, 31 insertions(+), 14 deletions(-)

diff --git a/drivers/video/backlight/backlight.c b/drivers/video/backlight/backlight.c
index bddc8b17a4d8..18901b9b1eb4 100644
--- a/drivers/video/backlight/backlight.c
+++ b/drivers/video/backlight/backlight.c
@@ -164,18 +164,10 @@ static ssize_t brightness_show(struct device *dev,
 	return sprintf(buf, "%d\n", bd->props.brightness);
 }
 
-static ssize_t brightness_store(struct device *dev,
-		struct device_attribute *attr, const char *buf, size_t count)
+int backlight_device_set_brightness(struct backlight_device *bd,
+				    unsigned long brightness)
 {
-	int rc;
-	struct backlight_device *bd = to_backlight_device(dev);
-	unsigned long brightness;
-
-	rc = kstrtoul(buf, 0, &brightness);
-	if (rc)
-		return rc;
-
-	rc = -ENXIO;
+	int rc = -ENXIO;
 
 	mutex_lock(&bd->ops_lock);
 	if (bd->ops) {
@@ -185,7 +177,7 @@ static ssize_t brightness_store(struct device *dev,
 			pr_debug("set brightness to %lu\n", brightness);
 			bd->props.brightness = brightness;
 			backlight_update_status(bd);
-			rc = count;
+			rc = 0;
 		}
 	}
 	mutex_unlock(&bd->ops_lock);
@@ -194,6 +186,23 @@ static ssize_t brightness_store(struct device *dev,
 
 	return rc;
 }
+EXPORT_SYMBOL(backlight_device_set_brightness);
+
+static ssize_t brightness_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	int rc;
+	struct backlight_device *bd = to_backlight_device(dev);
+	unsigned long brightness;
+
+	rc = kstrtoul(buf, 0, &brightness);
+	if (rc)
+		return rc;
+
+	rc = backlight_device_set_brightness(bd, brightness);
+
+	return rc ? rc : count;
+}
 static DEVICE_ATTR_RW(brightness);
 
 static ssize_t type_show(struct device *dev, struct device_attribute *attr,
@@ -380,7 +389,7 @@ struct backlight_device *backlight_device_register(const char *name,
 }
 EXPORT_SYMBOL(backlight_device_register);
 
-bool backlight_device_registered(enum backlight_type type)
+struct backlight_device *backlight_device_get_by_type(enum backlight_type type)
 {
 	bool found = false;
 	struct backlight_device *bd;
@@ -394,7 +403,13 @@ bool backlight_device_registered(enum backlight_type type)
 	}
 	mutex_unlock(&backlight_dev_list_mutex);
 
-	return found;
+	return found ? bd : NULL;
+}
+EXPORT_SYMBOL(backlight_device_get_by_type);
+
+bool backlight_device_registered(enum backlight_type type)
+{
+	return backlight_device_get_by_type(type) ? true : false;
 }
 EXPORT_SYMBOL(backlight_device_registered);
 
diff --git a/include/linux/backlight.h b/include/linux/backlight.h
index 1e7a69adbe6f..f46b88fa4a09 100644
--- a/include/linux/backlight.h
+++ b/include/linux/backlight.h
@@ -144,6 +144,8 @@ extern void backlight_force_update(struct backlight_device *bd,
 extern bool backlight_device_registered(enum backlight_type type);
 extern int backlight_register_notifier(struct notifier_block *nb);
 extern int backlight_unregister_notifier(struct notifier_block *nb);
+extern struct backlight_device *backlight_device_get_by_type(enum backlight_type type);
+extern int backlight_device_set_brightness(struct backlight_device *bd, unsigned long brightness);
 
 #define to_backlight_device(obj) container_of(obj, struct backlight_device, dev)
 
-- 
2.5.5

