From: gaurav jindal <gauravjindal1104@gmail.com>
Subject: Re: [PATCH] drivers: cpuidle: Fix checkpatch error and warnings
Date: Thu, 7 Sep 2017 18:10:10 +0530
Message-ID: <20170907124010.GB6427@kernel>
References: <20170907102325.GA6427@kernel>
 <1504780406.7546.19.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:37246 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754219AbdIGMkT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 7 Sep 2017 08:40:19 -0400
Content-Disposition: inline
In-Reply-To: <1504780406.7546.19.camel@perches.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Joe Perches <joe@perches.com>, rjw@rjwysocki.net, daniel.lezcano@linaro.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, toddpoynor@google.com

this patch fixes the below checkpatch errors and warnings in
drivers/cpuidle/cpuidle.c

WARNING: line over 80 characters
#311: FILE: drivers/cpuidle/cpuidle.c:311:
+		/* Make sure all changes finished before we switch to new idle */

WARNING: EXPORT_SYMBOL(foo); should immediately follow its function/variable
#343: FILE: drivers/cpuidle/cpuidle.c:343:
+EXPORT_SYMBOL_GPL(cpuidle_pause_and_lock);

WARNING: EXPORT_SYMBOL(foo); should immediately follow its function/variable
#354: FILE: drivers/cpuidle/cpuidle.c:354:
+EXPORT_SYMBOL_GPL(cpuidle_resume_and_unlock);

ERROR: do not use assignment in if condition
#402: FILE: drivers/cpuidle/cpuidle.c:402:
+	if (cpuidle_curr_governor->enable &&

WARNING: EXPORT_SYMBOL(foo); should immediately follow its function/variable
#419: FILE: drivers/cpuidle/cpuidle.c:419:
+EXPORT_SYMBOL_GPL(cpuidle_enable_device);

WARNING: EXPORT_SYMBOL(foo); should immediately follow its function/variable
#447: FILE: drivers/cpuidle/cpuidle.c:447:
+EXPORT_SYMBOL_GPL(cpuidle_disable_device);

WARNING: EXPORT_SYMBOL(foo); should immediately follow its function/variable
#537: FILE: drivers/cpuidle/cpuidle.c:537:
+EXPORT_SYMBOL_GPL(cpuidle_register_device);

WARNING: EXPORT_SYMBOL(foo); should immediately follow its function/variable
#561: FILE: drivers/cpuidle/cpuidle.c:561:
+EXPORT_SYMBOL_GPL(cpuidle_unregister_device);

Signed-off-by:gaurav jindal<gauravjindal1104@gmail.com>

---

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index 60bb64f..a42148e 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -308,7 +308,10 @@ void cpuidle_reflect(struct cpuidle_device *dev, int index)
 void cpuidle_install_idle_handler(void)
 {
 	if (enabled_devices) {
-		/* Make sure all changes finished before we switch to new idle */
+		/*
+		 * Make sure all changes finished before we switch to
+		 * new idle
+		 */
 		smp_wmb();
 		initialized = 1;
 	}
@@ -339,7 +342,6 @@ void cpuidle_pause_and_lock(void)
 	mutex_lock(&cpuidle_lock);
 	cpuidle_uninstall_idle_handler();
 }
-
 EXPORT_SYMBOL_GPL(cpuidle_pause_and_lock);

 /**
@@ -350,7 +352,6 @@ void cpuidle_resume_and_unlock(void)
 	cpuidle_install_idle_handler();
 	mutex_unlock(&cpuidle_lock);
 }
-
 EXPORT_SYMBOL_GPL(cpuidle_resume_and_unlock);

 /* Currently used in suspend/resume path to suspend cpuidle */
@@ -399,9 +400,12 @@ int cpuidle_enable_device(struct cpuidle_device *dev)
 	if (ret)
 		return ret;

-	if (cpuidle_curr_governor->enable &&
-	    (ret = cpuidle_curr_governor->enable(drv, dev)))
-		goto fail_sysfs;
+	if (cpuidle_curr_governor->enable) {
+		ret = cpuidle_curr_governor->enable(drv, dev);
+		if (ret)
+			goto fail_sysfs;
+	}

 	smp_wmb();

@@ -415,7 +419,6 @@ int cpuidle_enable_device(struct cpuidle_device *dev)

 	return ret;
 }
-
 EXPORT_SYMBOL_GPL(cpuidle_enable_device);

 /**
@@ -443,7 +446,6 @@ void cpuidle_disable_device(struct cpuidle_device *dev)
 	cpuidle_remove_device_sysfs(dev);
 	enabled_devices--;
 }
-
 EXPORT_SYMBOL_GPL(cpuidle_disable_device);

 static void __cpuidle_unregister_device(struct cpuidle_device *dev)
@@ -533,7 +535,6 @@ int cpuidle_register_device(struct cpuidle_device *dev)
 	__cpuidle_unregister_device(dev);
 	goto out_unlock;
 }
-
 EXPORT_SYMBOL_GPL(cpuidle_register_device);

 /**
@@ -557,7 +558,6 @@ void cpuidle_unregister_device(struct cpuidle_device *dev)

 	cpuidle_resume_and_unlock();
 }
-
 EXPORT_SYMBOL_GPL(cpuidle_unregister_device);

 /**
