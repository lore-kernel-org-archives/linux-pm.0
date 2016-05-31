From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCH 08/15] thermal: sysfs: improve locking of emul_temp_store()
Date: Mon, 30 May 2016 23:31:29 -0700
Message-ID: <1464676296-5610-9-git-send-email-edubezval@gmail.com>
References: <1464676296-5610-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1464676296-5610-1-git-send-email-edubezval@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>
List-Id: linux-pm@vger.kernel.org

emul_temp_store locks only for setting temperature,
but it must lock also for calls to tz.ops.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
---
 drivers/thermal/thermal_sysfs.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index 234eb18..32ffadf 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -340,13 +340,12 @@ emul_temp_store(struct device *dev, struct device_attribute *attr,
 	if (kstrtoint(buf, 10, &temperature))
 		return -EINVAL;
 
-	if (!tz->ops->set_emul_temp) {
-		mutex_lock(&tz->lock);
+	mutex_lock(&tz->lock);
+	if (!tz->ops->set_emul_temp)
 		tz->emul_temperature = temperature;
-		mutex_unlock(&tz->lock);
-	} else {
+	else
 		ret = tz->ops->set_emul_temp(tz, temperature);
-	}
+	mutex_unlock(&tz->lock);
 
 	if (!ret)
 		thermal_zone_device_update(tz);
-- 
2.1.4
