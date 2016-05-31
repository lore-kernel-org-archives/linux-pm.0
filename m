From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCH 02/15] thermal: sysfs: lock tz while on access to mode properties
Date: Mon, 30 May 2016 23:31:23 -0700
Message-ID: <1464676296-5610-3-git-send-email-edubezval@gmail.com>
References: <1464676296-5610-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1464676296-5610-1-git-send-email-edubezval@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>
List-Id: linux-pm@vger.kernel.org

Serialized calls to tz.ops in user facing
sysfs handler mode_show()  and mode_store().

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
---
 drivers/thermal/thermal_sysfs.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index ee983ca..1db2406 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -62,7 +62,9 @@ mode_show(struct device *dev, struct device_attribute *attr, char *buf)
 	if (!tz->ops->get_mode)
 		return -EPERM;
 
+	mutex_lock(&tz->lock);
 	result = tz->ops->get_mode(tz, &mode);
+	mutex_unlock(&tz->lock);
 	if (result)
 		return result;
 
@@ -75,17 +77,22 @@ mode_store(struct device *dev, struct device_attribute *attr,
 	   const char *buf, size_t count)
 {
 	struct thermal_zone_device *tz = to_thermal_zone(dev);
+	enum thermal_device_mode mode = THERMAL_DEVICE_DISABLED;
 	int result;
 
 	if (!tz->ops->set_mode)
 		return -EPERM;
 
 	if (!strncmp(buf, "enabled", sizeof("enabled") - 1))
-		result = tz->ops->set_mode(tz, THERMAL_DEVICE_ENABLED);
+		mode = THERMAL_DEVICE_ENABLED;
 	else if (!strncmp(buf, "disabled", sizeof("disabled") - 1))
-		result = tz->ops->set_mode(tz, THERMAL_DEVICE_DISABLED);
+		mode = THERMAL_DEVICE_DISABLED;
 	else
-		result = -EINVAL;
+		return -EINVAL;
+
+	mutex_lock(&tz->lock);
+	result = tz->ops->set_mode(tz, mode);
+	mutex_unlock(&tz->lock);
 
 	if (result)
 		return result;
-- 
2.1.4
