From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 6/8] cpuidle: Encapsulate code in __cpuidle_unregister_device
Date: Wed, 12 Jun 2013 15:08:53 +0200
Message-ID: <1371042535-22630-6-git-send-email-daniel.lezcano@linaro.org>
References: <1371042535-22630-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-we0-f181.google.com ([74.125.82.181]:35551 "EHLO
	mail-we0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751483Ab3FLNJE (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 12 Jun 2013 09:09:04 -0400
Received: by mail-we0-f181.google.com with SMTP id p58so6634807wes.26
        for <linux-pm@vger.kernel.org>; Wed, 12 Jun 2013 06:09:03 -0700 (PDT)
In-Reply-To: <1371042535-22630-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: linux-pm@vger.kernel.org, linaro-kernel@lists.linaro.org, patches@linaro.org

The same code is used at different places.

Group the common code into a single functions and call this function.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/cpuidle/cpuidle.c |   62 +++++++++++++++++++++++----------------------
 1 file changed, 32 insertions(+), 30 deletions(-)

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index 52ec46b..bdb7180 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -42,8 +42,6 @@ void disable_cpuidle(void)
 	off = 1;
 }
 
-static int __cpuidle_register_device(struct cpuidle_device *dev);
-
 /**
  * cpuidle_play_dead - cpu off-lining
  *
@@ -357,6 +355,15 @@ void cpuidle_disable_device(struct cpuidle_device *dev)
 
 EXPORT_SYMBOL_GPL(cpuidle_disable_device);
 
+static void __cpuidle_unregister_device(struct cpuidle_device *dev)
+{
+	struct cpuidle_driver *drv = cpuidle_get_cpu_driver(dev);
+
+	list_del(&dev->device_list);
+	per_cpu(cpuidle_devices, dev->cpu) = NULL;
+	module_put(drv->owner);
+}
+
 /**
  * __cpuidle_register_device - internal register function called before register
  * and enable routines
@@ -374,24 +381,15 @@ static int __cpuidle_register_device(struct cpuidle_device *dev)
 
 	per_cpu(cpuidle_devices, dev->cpu) = dev;
 	list_add(&dev->device_list, &cpuidle_detected_devices);
-	ret = cpuidle_add_sysfs(dev);
-	if (ret)
-		goto err_sysfs;
 
 	ret = cpuidle_coupled_register_device(dev);
-	if (ret)
-		goto err_coupled;
+	if (ret) {
+		__cpuidle_unregister_device(dev);
+		return ret;
+	}
 
 	dev->registered = 1;
 	return 0;
-
-err_coupled:
-	cpuidle_remove_sysfs(dev);
-err_sysfs:
-	list_del(&dev->device_list);
-	per_cpu(cpuidle_devices, dev->cpu) = NULL;
-	module_put(drv->owner);
-	return ret;
 }
 
 /**
@@ -407,22 +405,30 @@ int cpuidle_register_device(struct cpuidle_device *dev)
 
 	mutex_lock(&cpuidle_lock);
 
-	if ((ret = __cpuidle_register_device(dev))) {
-		mutex_unlock(&cpuidle_lock);
-		return ret;
-	}
+	ret = __cpuidle_register_device(dev);
+	if (ret)
+		goto out_unlock;
+
+	ret = cpuidle_add_sysfs(dev);
+	if (ret)
+		goto out_unregister;
 
 	ret = cpuidle_enable_device(dev);
-	if (ret) {
-		mutex_unlock(&cpuidle_lock);
-		return ret;
-	}
+	if (ret)
+		goto out_sysfs;
 
 	cpuidle_install_idle_handler();
 
+out_unlock:
 	mutex_unlock(&cpuidle_lock);
 
-	return 0;
+	return ret;
+
+out_sysfs:
+	cpuidle_remove_sysfs(dev);
+out_unregister:
+	__cpuidle_unregister_device(dev);
+	goto out_unlock;
 }
 
 EXPORT_SYMBOL_GPL(cpuidle_register_device);
@@ -433,8 +439,6 @@ EXPORT_SYMBOL_GPL(cpuidle_register_device);
  */
 void cpuidle_unregister_device(struct cpuidle_device *dev)
 {
-	struct cpuidle_driver *drv = cpuidle_get_cpu_driver(dev);
-
 	if (dev->registered == 0)
 		return;
 
@@ -443,14 +447,12 @@ void cpuidle_unregister_device(struct cpuidle_device *dev)
 	cpuidle_disable_device(dev);
 
 	cpuidle_remove_sysfs(dev);
-	list_del(&dev->device_list);
-	per_cpu(cpuidle_devices, dev->cpu) = NULL;
+
+	__cpuidle_unregister_device(dev);
 
 	cpuidle_coupled_unregister_device(dev);
 
 	cpuidle_resume_and_unlock();
-
-	module_put(drv->owner);
 }
 
 EXPORT_SYMBOL_GPL(cpuidle_unregister_device);
-- 
1.7.9.5

