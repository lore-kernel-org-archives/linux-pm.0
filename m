From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [RFC patch 06/11] cpuidle / at91 : use common ARM cpuidle driver
Date: Fri, 15 Mar 2013 15:27:05 +0100
Message-ID: <1363357630-22214-7-git-send-email-daniel.lezcano@linaro.org>
References: <1363357630-22214-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-we0-f180.google.com ([74.125.82.180]:61429 "EHLO
	mail-we0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754769Ab3COO13 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 15 Mar 2013 10:27:29 -0400
Received: by mail-we0-f180.google.com with SMTP id k14so3167876wer.25
        for <linux-pm@vger.kernel.org>; Fri, 15 Mar 2013 07:27:28 -0700 (PDT)
In-Reply-To: <1363357630-22214-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linaro-kernel@lists.linaro.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Cc: linux@maxim.org.za, nicolas.ferre@atmel.com, plagnioj@jcrosoft.com, lenb@kernel.org, rjw@sisk.pl, nsekhar@ti.com, kevin.hilman@linaro.org, horms@verge.net.au, magnus.damm@gmail.com, kernel@pengutronix.de, ben-linux@fluff.org, kgene.kim@samsung.com, rob.herring@calxeda.com, jason@lakedaemon.net, andrew@lunn.ch

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/mach-at91/cpuidle.c |   15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/arch/arm/mach-at91/cpuidle.c b/arch/arm/mach-at91/cpuidle.c
index 0c63815..9dc4f6f 100644
--- a/arch/arm/mach-at91/cpuidle.c
+++ b/arch/arm/mach-at91/cpuidle.c
@@ -27,8 +27,6 @@
 
 #define AT91_MAX_STATES	2
 
-static DEFINE_PER_CPU(struct cpuidle_device, at91_cpuidle_device);
-
 /* Actual code that puts the SoC in different idle states */
 static int at91_enter_idle(struct cpuidle_device *dev,
 			struct cpuidle_driver *drv,
@@ -63,18 +61,7 @@ static struct cpuidle_driver at91_idle_driver = {
 /* Initialize CPU idle by registering the idle states */
 static int at91_init_cpuidle(void)
 {
-	struct cpuidle_device *device;
-
-	device = &per_cpu(at91_cpuidle_device, smp_processor_id());
-	device->state_count = AT91_MAX_STATES;
-
-	cpuidle_register_driver(&at91_idle_driver);
-
-	if (cpuidle_register_device(device)) {
-		printk(KERN_ERR "at91_init_cpuidle: Failed registering\n");
-		return -EIO;
-	}
-	return 0;
+	return arm_idle_init(&at91_idle_driver);
 }
 
 device_initcall(at91_init_cpuidle);
-- 
1.7.9.5

