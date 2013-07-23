From: Dongsheng Wang <dongsheng.wang@freescale.com>
Subject: [PATCH 1/2] cpuidle: fix cpu idle driver as a module can not remove
Date: Tue, 23 Jul 2013 17:28:00 +0800
Message-ID: <1374571681-31911-1-git-send-email-dongsheng.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from co1ehsobe003.messaging.microsoft.com ([216.32.180.186]:12355
	"EHLO co1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756012Ab3GWKTf (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 23 Jul 2013 06:19:35 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: daniel.lezcano@linaro.org
Cc: rjw@sisk.pl, linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Wang Dongsheng <dongsheng.wang@freescale.com>

From: Wang Dongsheng <dongsheng.wang@freescale.com>

The module can not be removed when execute "rmmod". rmmod not use
"--force".

Log:
root:~# rmmod cpuidle-e500
incs[9], decs[1]
rmmod: can't unload 'cpuidle_e500': Resource temporarily unavailable

Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>
---
Branch: pm-cpuidle

 drivers/cpuidle/cpuidle.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index fdc432f..534320a 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -386,6 +386,9 @@ static int __cpuidle_register_device(struct cpuidle_device *dev)
 		goto err_coupled;
 
 	dev->registered = 1;
+
+	module_put(drv->owner);
+
 	return 0;
 
 err_coupled:
@@ -432,8 +435,6 @@ EXPORT_SYMBOL_GPL(cpuidle_register_device);
  */
 void cpuidle_unregister_device(struct cpuidle_device *dev)
 {
-	struct cpuidle_driver *drv = cpuidle_get_cpu_driver(dev);
-
 	if (dev->registered == 0)
 		return;
 
@@ -448,8 +449,6 @@ void cpuidle_unregister_device(struct cpuidle_device *dev)
 	cpuidle_coupled_unregister_device(dev);
 
 	cpuidle_resume_and_unlock();
-
-	module_put(drv->owner);
 }
 
 EXPORT_SYMBOL_GPL(cpuidle_unregister_device);
-- 
1.8.0


