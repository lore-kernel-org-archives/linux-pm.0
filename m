From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 11/15] ARM: s3c64xx: cpuidle: use init/exit common routine
Date: Mon, 25 Mar 2013 18:55:36 +0100
Message-ID: <1364234140-514-12-git-send-email-daniel.lezcano@linaro.org>
References: <1364234140-514-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f42.google.com ([74.125.82.42]:39596 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758320Ab3CYR4L (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 25 Mar 2013 13:56:11 -0400
Received: by mail-wg0-f42.google.com with SMTP id 12so4246319wgh.3
        for <linux-pm@vger.kernel.org>; Mon, 25 Mar 2013 10:56:09 -0700 (PDT)
In-Reply-To: <1364234140-514-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl, tglx@linutronix.de
Cc: patches@linaro.org, linaro-kernel@lists.linaro.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux@maxim.org.za, nicolas.ferre@atmel.com, plagnioj@jcrosoft.com, lenb@kernel.org, nsekhar@ti.com, kevin.hilman@linaro.org, horms@verge.net.au, magnus.damm@gmail.com, kernel@pengutronix.de, ben-linux@fluff.org, kgene.kim@samsung.com, rob.herring@calxeda.com, jason@lakedaemon.net, andrew@lunn.ch, linus.walleij@linaro.org, linux@arm.linux.org.uk

Remove the duplicate code and use the arm cpuidle driver's common code
for initialization.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/mach-s3c64xx/cpuidle.c |   15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/cpuidle.c b/arch/arm/mach-s3c64xx/cpuidle.c
index ead5fab..ce56142 100644
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
+	return arm_cpuidle_init(&s3c64xx_cpuidle_driver);
 }
 device_initcall(s3c64xx_init_cpuidle);
-- 
1.7.9.5

