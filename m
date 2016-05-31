From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCH 07/15] thermal: sysfs: lock tz while on policy properties
Date: Mon, 30 May 2016 23:31:28 -0700
Message-ID: <1464676296-5610-8-git-send-email-edubezval@gmail.com>
References: <1464676296-5610-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1464676296-5610-1-git-send-email-edubezval@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>
List-Id: linux-pm@vger.kernel.org

Serialized calls to tz.ops in user facing
sysfs handler policy_show().
policy_store() is already locked by
the thermal core.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
---
 drivers/thermal/thermal_sysfs.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index dcaeb17..234eb18 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -311,8 +311,14 @@ static ssize_t
 policy_show(struct device *dev, struct device_attribute *devattr, char *buf)
 {
 	struct thermal_zone_device *tz = to_thermal_zone(dev);
+	char *name;
 
-	return sprintf(buf, "%s\n", tz->governor->name);
+	/* locking the zone because governor->name does not change */
+	mutex_lock(&tz->lock);
+	name = tz->governor->name;
+	mutex_unlock(&tz->lock);
+
+	return sprintf(buf, "%s\n", name);
 }
 
 static ssize_t
-- 
2.1.4
