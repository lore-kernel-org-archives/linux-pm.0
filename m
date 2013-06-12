From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 7/8] cpuidle: Add a cpuidle_device init function
Date: Wed, 12 Jun 2013 15:08:54 +0200
Message-ID: <1371042535-22630-7-git-send-email-daniel.lezcano@linaro.org>
References: <1371042535-22630-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:38321 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751483Ab3FLNJF (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 12 Jun 2013 09:09:05 -0400
Received: by mail-wi0-f181.google.com with SMTP id hq4so457821wib.2
        for <linux-pm@vger.kernel.org>; Wed, 12 Jun 2013 06:09:04 -0700 (PDT)
In-Reply-To: <1371042535-22630-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: linux-pm@vger.kernel.org, linaro-kernel@lists.linaro.org, patches@linaro.org

Create a specific function to initialize the cpuidle_device structure.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/cpuidle/cpuidle.c |   20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index bdb7180..7c3f625 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -276,7 +276,7 @@ static void poll_idle_init(struct cpuidle_driver *drv) {}
  */
 int cpuidle_enable_device(struct cpuidle_device *dev)
 {
-	int ret, i;
+	int ret;
 	struct cpuidle_driver *drv;
 
 	if (!dev)
@@ -306,12 +306,6 @@ int cpuidle_enable_device(struct cpuidle_device *dev)
 	    (ret = cpuidle_curr_governor->enable(drv, dev)))
 		goto fail_sysfs;
 
-	for (i = 0; i < dev->state_count; i++) {
-		dev->states_usage[i].usage = 0;
-		dev->states_usage[i].time = 0;
-	}
-	dev->last_residency = 0;
-
 	smp_wmb();
 
 	dev->enabled = 1;
@@ -364,6 +358,14 @@ static void __cpuidle_unregister_device(struct cpuidle_device *dev)
 	module_put(drv->owner);
 }
 
+static int __cpuidle_device_init(struct cpuidle_device *dev)
+{
+	memset(dev->states_usage, 0, sizeof(dev->states_usage));
+	dev->last_residency = 0;
+
+	return 0;
+}
+
 /**
  * __cpuidle_register_device - internal register function called before register
  * and enable routines
@@ -405,6 +407,10 @@ int cpuidle_register_device(struct cpuidle_device *dev)
 
 	mutex_lock(&cpuidle_lock);
 
+	ret = __cpuidle_device_init(dev);
+	if (ret)
+		goto out_unlock;
+
 	ret = __cpuidle_register_device(dev);
 	if (ret)
 		goto out_unlock;
-- 
1.7.9.5

