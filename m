From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [RFC patch 07/11] cpuidle / shmobile : use common ARM cpuidle driver
Date: Fri, 15 Mar 2013 15:27:06 +0100
Message-ID: <1363357630-22214-8-git-send-email-daniel.lezcano@linaro.org>
References: <1363357630-22214-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:52236 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754901Ab3COO1c (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 15 Mar 2013 10:27:32 -0400
Received: by mail-wi0-f175.google.com with SMTP id l13so566248wie.14
        for <linux-pm@vger.kernel.org>; Fri, 15 Mar 2013 07:27:31 -0700 (PDT)
In-Reply-To: <1363357630-22214-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linaro-kernel@lists.linaro.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Cc: linux@maxim.org.za, nicolas.ferre@atmel.com, plagnioj@jcrosoft.com, lenb@kernel.org, rjw@sisk.pl, nsekhar@ti.com, kevin.hilman@linaro.org, horms@verge.net.au, magnus.damm@gmail.com, kernel@pengutronix.de, ben-linux@fluff.org, kgene.kim@samsung.com, rob.herring@calxeda.com, jason@lakedaemon.net, andrew@lunn.ch

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/mach-shmobile/cpuidle.c |   10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/arch/arm/mach-shmobile/cpuidle.c b/arch/arm/mach-shmobile/cpuidle.c
index 9e05026..11a0542 100644
--- a/arch/arm/mach-shmobile/cpuidle.c
+++ b/arch/arm/mach-shmobile/cpuidle.c
@@ -23,7 +23,6 @@ int shmobile_enter_wfi(struct cpuidle_device *dev, struct cpuidle_driver *drv,
 	return 0;
 }
 
-static struct cpuidle_device shmobile_cpuidle_dev;
 static struct cpuidle_driver shmobile_cpuidle_default_driver = {
 	.name			= "shmobile_cpuidle",
 	.owner			= THIS_MODULE,
@@ -43,12 +42,5 @@ void shmobile_cpuidle_set_driver(struct cpuidle_driver *drv)
 
 int shmobile_cpuidle_init(void)
 {
-	struct cpuidle_device *dev = &shmobile_cpuidle_dev;
-
-	cpuidle_register_driver(cpuidle_drv);
-
-	dev->state_count = cpuidle_drv->state_count;
-	cpuidle_register_device(dev);
-
-	return 0;
+	return arm_idle_init(cpuidle_drv);
 }
-- 
1.7.9.5

