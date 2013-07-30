From: Dongsheng Wang <dongsheng.wang@freescale.com>
Subject: [PATCH] cpuidle: fix unremovable issue for module driver
Date: Tue, 30 Jul 2013 14:55:19 +0800
Message-ID: <1375167319-12821-1-git-send-email-dongsheng.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from ch1ehsobe004.messaging.microsoft.com ([216.32.181.184]:16907
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753802Ab3G3Hrs (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 30 Jul 2013 03:47:48 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl, daniel.lezcano@linaro.org
Cc: linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Wang Dongsheng <dongsheng.wang@freescale.com>

From: Wang Dongsheng <dongsheng.wang@freescale.com>

After __cpuidle_register_device, the cpu incs are added up, but decs
are not, thus the module refcount is not match. So the module "exit"
function can not be executed when we do remove operation. Move
module_put into __cpuidle_register_device to fix it.

Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index d75040d..e964ada 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -351,11 +351,8 @@ EXPORT_SYMBOL_GPL(cpuidle_disable_device);
 
 static void __cpuidle_unregister_device(struct cpuidle_device *dev)
 {
-	struct cpuidle_driver *drv = cpuidle_get_cpu_driver(dev);
-
 	list_del(&dev->device_list);
 	per_cpu(cpuidle_devices, dev->cpu) = NULL;
-	module_put(drv->owner);
 }
 
 static int __cpuidle_device_init(struct cpuidle_device *dev)
@@ -384,6 +381,8 @@ static int __cpuidle_register_device(struct cpuidle_device *dev)
 	per_cpu(cpuidle_devices, dev->cpu) = dev;
 	list_add(&dev->device_list, &cpuidle_detected_devices);
 
+	module_put(drv->owner);
+
 	ret = cpuidle_coupled_register_device(dev);
 	if (ret) {
 		__cpuidle_unregister_device(dev);
-- 
1.8.0


