From: Thara Gopinath <thara.gopinath@linaro.org>
Subject: [PATCH] thermal: Fix locking in cooling device sysfs update cur_state
Date: Wed, 21 Nov 2018 14:01:31 -0500
Message-ID: <1542826891-28642-1-git-send-email-thara.gopinath@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com, daniel.lezcano@linaro.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Sysfs interface to update cooling device cur_state does not
currently hold cooling device lock, leading to stale values
in cur_state especially if getting updated simultanelously
from user space and thermal framework. Adding the proper locking
code fixes this issue.

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---
 drivers/thermal/thermal_sysfs.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index 2241cea..1f0c1e2 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -712,10 +712,14 @@ cur_state_store(struct device *dev, struct device_attribute *attr,
 	if ((long)state < 0)
 		return -EINVAL;
 
+	mutex_lock(&cdev->lock);
 	result = cdev->ops->set_cur_state(cdev, state);
-	if (result)
+	if (result) {
+		mutex_unlock(&cdev->lock);
 		return result;
+	}
 	thermal_cooling_device_stats_update(cdev, state);
+	mutex_unlock(&cdev->lock);
 	return count;
 }
 
-- 
2.1.4
