From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCH 09/15] thermal: sysfs: lock tz when access sustainable power properties
Date: Mon, 30 May 2016 23:31:30 -0700
Message-ID: <1464676296-5610-10-git-send-email-edubezval@gmail.com>
References: <1464676296-5610-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1464676296-5610-1-git-send-email-edubezval@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>
List-Id: linux-pm@vger.kernel.org

Lock tz when in user facing sysfs handlers to expose
sustainable power properties. This includes:
sustainable_power_show()
sustainable_power_store()

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
---
 drivers/thermal/thermal_sysfs.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index 32ffadf..5b08d64 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -360,9 +360,14 @@ sustainable_power_show(struct device *dev, struct device_attribute *devattr,
 		       char *buf)
 {
 	struct thermal_zone_device *tz = to_thermal_zone(dev);
+	unsigned int sustainable_power;
+
+	mutex_lock(&tz->lock);
+	sustainable_power = tz->tzp->sustainable_power;
+	mutex_unlock(&tz->lock);
 
 	if (tz->tzp)
-		return sprintf(buf, "%u\n", tz->tzp->sustainable_power);
+		return sprintf(buf, "%u\n", sustainable_power);
 	else
 		return -EIO;
 }
@@ -380,7 +385,9 @@ sustainable_power_store(struct device *dev, struct device_attribute *devattr,
 	if (kstrtou32(buf, 10, &sustainable_power))
 		return -EINVAL;
 
+	mutex_lock(&tz->lock);
 	tz->tzp->sustainable_power = sustainable_power;
+	mutex_unlock(&tz->lock);
 
 	return count;
 }
-- 
2.1.4
