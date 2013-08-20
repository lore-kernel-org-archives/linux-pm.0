From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 9/9] cpuidle: remove state_count field from struct
 cpuidle_device
Date: Tue, 20 Aug 2013 16:23:47 +0200
Message-ID: <1377008627-32691-10-git-send-email-b.zolnierkie@samsung.com>
References: <1377008627-32691-1-git-send-email-b.zolnierkie@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:29021 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751045Ab3HTO0o (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 20 Aug 2013 10:26:44 -0400
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
 by mailout4.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MRU00L9P2SJWMI0@mailout4.samsung.com> for
 linux-pm@vger.kernel.org; Tue, 20 Aug 2013 23:26:43 +0900 (KST)
In-reply-to: <1377008627-32691-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: daniel.lezcano@linaro.org
Cc: rjw@sisk.pl, linux-pm@vger.kernel.org, kyungmin.park@samsung.com, b.zolnierkie@samsung.com

dev->state_count is now always equal to drv->state_count so
it can be removed.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/cpuidle/cpuidle.c | 3 ---
 drivers/cpuidle/sysfs.c   | 5 +++--
 include/linux/cpuidle.h   | 1 -
 3 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index d75040d..60947ca 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -293,9 +293,6 @@ int cpuidle_enable_device(struct cpuidle_device *dev)
 	if (!dev->registered)
 		return -EINVAL;
 
-	if (!dev->state_count)
-		dev->state_count = drv->state_count;
-
 	poll_idle_init(drv);
 
 	ret = cpuidle_add_device_sysfs(dev);
diff --git a/drivers/cpuidle/sysfs.c b/drivers/cpuidle/sysfs.c
index 8739cc0..5af3fa9 100644
--- a/drivers/cpuidle/sysfs.c
+++ b/drivers/cpuidle/sysfs.c
@@ -397,7 +397,7 @@ static int cpuidle_add_state_sysfs(struct cpuidle_device *device)
 	struct cpuidle_driver *drv = cpuidle_get_cpu_driver(device);
 
 	/* state statistics */
-	for (i = 0; i < device->state_count; i++) {
+	for (i = 0; i < drv->state_count; i++) {
 		kobj = kzalloc(sizeof(struct cpuidle_state_kobj), GFP_KERNEL);
 		if (!kobj)
 			goto error_state;
@@ -429,9 +429,10 @@ error_state:
  */
 static void cpuidle_remove_state_sysfs(struct cpuidle_device *device)
 {
+	struct cpuidle_driver *drv = cpuidle_get_cpu_driver(device);
 	int i;
 
-	for (i = 0; i < device->state_count; i++)
+	for (i = 0; i < drv->state_count; i++)
 		cpuidle_free_state_kobj(device, i);
 }
 
diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
index 781addc..ecf7b09 100644
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -69,7 +69,6 @@ struct cpuidle_device {
 	unsigned int		cpu;
 
 	int			last_residency;
-	int			state_count;
 	struct cpuidle_state_usage	states_usage[CPUIDLE_STATE_MAX];
 	struct cpuidle_state_kobj *kobjs[CPUIDLE_STATE_MAX];
 	struct cpuidle_driver_kobj *kobj_driver;
-- 
1.8.2.3

