From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [RFC patch 09/11] cpuidle / s3c64xx : use common ARM cpuidle driver
Date: Fri, 15 Mar 2013 15:27:08 +0100
Message-ID: <1363357630-22214-10-git-send-email-daniel.lezcano@linaro.org>
References: <1363357630-22214-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-we0-f176.google.com ([74.125.82.176]:49505 "EHLO
	mail-we0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754928Ab3COO1h (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 15 Mar 2013 10:27:37 -0400
Received: by mail-we0-f176.google.com with SMTP id s43so3309445wey.35
        for <linux-pm@vger.kernel.org>; Fri, 15 Mar 2013 07:27:36 -0700 (PDT)
In-Reply-To: <1363357630-22214-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linaro-kernel@lists.linaro.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Cc: linux@maxim.org.za, nicolas.ferre@atmel.com, plagnioj@jcrosoft.com, lenb@kernel.org, rjw@sisk.pl, nsekhar@ti.com, kevin.hilman@linaro.org, horms@verge.net.au, magnus.damm@gmail.com, kernel@pengutronix.de, ben-linux@fluff.org, kgene.kim@samsung.com, rob.herring@calxeda.com, jason@lakedaemon.net, andrew@lunn.ch

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/mach-s3c64xx/cpuidle.c |   15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/cpuidle.c b/arch/arm/mach-s3c64xx/cpuidle.c
index ead5fab..d50ffd2 100644
--- a/arch/arm/mach-s3c64xx/cpuidle.c
+++ b/arch/arm/mach-s3c64xx/cpuidle.c
@@ -16,6 +16,7 @@
 #include <linux/export.h>
 #include <linux/time.h>
 
+#include <asm/cpuidle.h>
 #include <asm/proc-fns.h>
 
 #include <mach/map.h>
@@ -40,8 +41,6 @@ static int s3c64xx_enter_idle(struct cpuidle_device *dev,
 	return index;
 }
 
-static DEFINE_PER_CPU(struct cpuidle_device, s3c64xx_cpuidle_device);
-
 static struct cpuidle_driver s3c64xx_cpuidle_driver = {
 	.name	= "s3c64xx_cpuidle",
 	.owner  = THIS_MODULE,
@@ -61,16 +60,6 @@ static struct cpuidle_driver s3c64xx_cpuidle_driver = {
 
 static int __init s3c64xx_init_cpuidle(void)
 {
-	int ret;
-
-	cpuidle_register_driver(&s3c64xx_cpuidle_driver);
-
-	ret = cpuidle_register_device(&s3c64xx_cpuidle_device);
-	if (ret) {
-		pr_err("Failed to register cpuidle device: %d\n", ret);
-		return ret;
-	}
-
-	return 0;
+	return arm_idle_init(&s3c64xx_cpuidle_driver);
 }
 device_initcall(s3c64xx_init_cpuidle);
-- 
1.7.9.5

