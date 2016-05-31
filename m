From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCH 10/15] thermal: sysfs: lock tz when access tzp properties
Date: Mon, 30 May 2016 23:31:31 -0700
Message-ID: <1464676296-5610-11-git-send-email-edubezval@gmail.com>
References: <1464676296-5610-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1464676296-5610-1-git-send-email-edubezval@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>
List-Id: linux-pm@vger.kernel.org

Lock tz when in user facing sysfs handlers to expose
tzp properties. This includes changing the macro
create_s32_tzp_attr(), which is used  in the
tzp properties:
k_po, k_pu, k_i, k_d, integral_cutoff, slope, offset.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
---
 drivers/thermal/thermal_sysfs.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index 5b08d64..86a77cd 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -398,11 +398,16 @@ sustainable_power_store(struct device *dev, struct device_attribute *devattr,
 		char *buf)						\
 	{								\
 	struct thermal_zone_device *tz = to_thermal_zone(dev);		\
+	int value;							\
 									\
-	if (tz->tzp)							\
-		return sprintf(buf, "%d\n", tz->tzp->name);		\
-	else								\
+	if (!tz->tzp)							\
 		return -EIO;						\
+									\
+	mutex_lock(&tz->lock);						\
+	value = tz->tzp->name;						\
+	mutex_unlock(&tz->lock);					\
+									\
+	return sprintf(buf, "%d\n", value);				\
 	}								\
 									\
 	static ssize_t							\
@@ -418,7 +423,9 @@ sustainable_power_store(struct device *dev, struct device_attribute *devattr,
 		if (kstrtos32(buf, 10, &value))				\
 			return -EINVAL;					\
 									\
+		mutex_lock(&tz->lock);					\
 		tz->tzp->name = value;					\
+		mutex_unlock(&tz->lock);				\
 									\
 		return count;						\
 	}								\
-- 
2.1.4
