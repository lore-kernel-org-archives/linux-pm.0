From: Thara Gopinath <thara.gopinath@linaro.org>
Subject: [PATCH V2] thermal: Fix locking in cooling device sysfs update cur_state
Date: Tue, 27 Nov 2018 17:43:11 -0500
Message-ID: <1543358591-25189-1-git-send-email-thara.gopinath@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com, daniel.lezcano@linaro.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Sysfs interface to update cooling device cur_state does not
currently holding cooling device lock sometimes leading to
stale values in cur_state if getting updated simultanelously
from user space and thermal framework. Adding the proper locking
code fixes this issue.

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---

V1->V2: Rearranged the code as per Daniel's  review comment 

 drivers/thermal/thermal_sysfs.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index 2241cea..aa99edb 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -712,11 +712,14 @@ cur_state_store(struct device *dev, struct device_attribute *attr,
 	if ((long)state < 0)
 		return -EINVAL;
 
+	mutex_lock(&cdev->lock);
+
 	result = cdev->ops->set_cur_state(cdev, state);
-	if (result)
-		return result;
-	thermal_cooling_device_stats_update(cdev, state);
-	return count;
+	if (!result)
+		thermal_cooling_device_stats_update(cdev, state);
+
+	mutex_unlock(&cdev->lock);
+	return result ? result : count;
 }
 
 static struct device_attribute
-- 
2.1.4
