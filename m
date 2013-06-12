From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 2/8] cpuidle: Check cpuidle_enable_device succeed
Date: Wed, 12 Jun 2013 15:08:49 +0200
Message-ID: <1371042535-22630-2-git-send-email-daniel.lezcano@linaro.org>
References: <1371042535-22630-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f45.google.com ([74.125.82.45]:50459 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751560Ab3FLNI5 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 12 Jun 2013 09:08:57 -0400
Received: by mail-wg0-f45.google.com with SMTP id j13so1603345wgh.24
        for <linux-pm@vger.kernel.org>; Wed, 12 Jun 2013 06:08:56 -0700 (PDT)
In-Reply-To: <1371042535-22630-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: linux-pm@vger.kernel.org, linaro-kernel@lists.linaro.org, patches@linaro.org

The previous patch changed the order of the framework initialization, the
governors are registered first and then the drivers can register their devices.

We can safely remove the __cpuidle_register_device call hack in the
cpuidle_enable_device function and check if the driver is registered before
enabling it. The cpuidle_register_function can check consistently the return
code when enabling the device.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/cpuidle/cpuidle.c |   17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index fdc432f..52ec46b 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -292,15 +292,12 @@ int cpuidle_enable_device(struct cpuidle_device *dev)
 	if (!drv || !cpuidle_curr_governor)
 		return -EIO;
 
+	if (dev->registered == 0)
+		return -EINVAL;
+
 	if (!dev->state_count)
 		dev->state_count = drv->state_count;
 
-	if (dev->registered == 0) {
-		ret = __cpuidle_register_device(dev);
-		if (ret)
-			return ret;
-	}
-
 	poll_idle_init(drv);
 
 	ret = cpuidle_add_device_sysfs(dev);
@@ -415,13 +412,17 @@ int cpuidle_register_device(struct cpuidle_device *dev)
 		return ret;
 	}
 
-	cpuidle_enable_device(dev);
+	ret = cpuidle_enable_device(dev);
+	if (ret) {
+		mutex_unlock(&cpuidle_lock);
+		return ret;
+	}
+
 	cpuidle_install_idle_handler();
 
 	mutex_unlock(&cpuidle_lock);
 
 	return 0;
-
 }
 
 EXPORT_SYMBOL_GPL(cpuidle_register_device);
-- 
1.7.9.5

