From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH V3 1/4] cpuidle: move driver's refcount to cpuidle
Date: Wed, 31 Oct 2012 17:44:45 +0100
Message-ID: <1351701888-19963-2-git-send-email-daniel.lezcano@linaro.org>
References: <1351701888-19963-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:35944 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752933Ab2JaQo7 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 31 Oct 2012 12:44:59 -0400
Received: by mail-bk0-f46.google.com with SMTP id jk13so767932bkc.19
        for <linux-pm@vger.kernel.org>; Wed, 31 Oct 2012 09:44:58 -0700 (PDT)
In-Reply-To: <1351701888-19963-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: linux-pm@vger.kernel.org, pdeschrijver@nvidia.com, lorenzo.pieralisi@arm.com, linaro-dev@lists.linaro.org

We want to support different cpuidle drivers co-existing together.
In this case we should move the refcount to the cpuidle_driver
structure to handle several drivers at a time.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
---
 drivers/cpuidle/driver.c |   13 ++++++++-----
 include/linux/cpuidle.h  |    1 +
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/cpuidle/driver.c b/drivers/cpuidle/driver.c
index 87db387..39ba8e1 100644
--- a/drivers/cpuidle/driver.c
+++ b/drivers/cpuidle/driver.c
@@ -16,7 +16,6 @@
 
 static struct cpuidle_driver *cpuidle_curr_driver;
 DEFINE_SPINLOCK(cpuidle_driver_lock);
-int cpuidle_driver_refcount;
 
 static void set_power_states(struct cpuidle_driver *drv)
 {
@@ -61,6 +60,8 @@ int cpuidle_register_driver(struct cpuidle_driver *drv)
 	if (!drv->power_specified)
 		set_power_states(drv);
 
+	drv->refcnt = 0;
+
 	cpuidle_curr_driver = drv;
 
 	spin_unlock(&cpuidle_driver_lock);
@@ -92,7 +93,7 @@ void cpuidle_unregister_driver(struct cpuidle_driver *drv)
 
 	spin_lock(&cpuidle_driver_lock);
 
-	if (!WARN_ON(cpuidle_driver_refcount > 0))
+	if (!WARN_ON(drv->refcnt > 0))
 		cpuidle_curr_driver = NULL;
 
 	spin_unlock(&cpuidle_driver_lock);
@@ -106,7 +107,7 @@ struct cpuidle_driver *cpuidle_driver_ref(void)
 	spin_lock(&cpuidle_driver_lock);
 
 	drv = cpuidle_curr_driver;
-	cpuidle_driver_refcount++;
+	drv->refcnt++;
 
 	spin_unlock(&cpuidle_driver_lock);
 	return drv;
@@ -114,10 +115,12 @@ struct cpuidle_driver *cpuidle_driver_ref(void)
 
 void cpuidle_driver_unref(void)
 {
+	struct cpuidle_driver *drv = cpuidle_curr_driver;
+
 	spin_lock(&cpuidle_driver_lock);
 
-	if (!WARN_ON(cpuidle_driver_refcount <= 0))
-		cpuidle_driver_refcount--;
+	if (drv && !WARN_ON(drv->refcnt <= 0))
+		drv->refcnt--;
 
 	spin_unlock(&cpuidle_driver_lock);
 }
diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
index 7daf0e3..d08e1af 100644
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -124,6 +124,7 @@ static inline int cpuidle_get_last_residency(struct cpuidle_device *dev)
 struct cpuidle_driver {
 	const char		*name;
 	struct module 		*owner;
+	int                     refcnt;
 
 	unsigned int		power_specified:1;
 	/* set to 1 to use the core cpuidle time keeping (for all states). */
-- 
1.7.5.4

