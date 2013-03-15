From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [RFC patch 11/11] cpuidle / kirkwood : use common ARM cpuidle driver
Date: Fri, 15 Mar 2013 15:27:10 +0100
Message-ID: <1363357630-22214-12-git-send-email-daniel.lezcano@linaro.org>
References: <1363357630-22214-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-we0-f182.google.com ([74.125.82.182]:43630 "EHLO
	mail-we0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754665Ab3COO1m (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 15 Mar 2013 10:27:42 -0400
Received: by mail-we0-f182.google.com with SMTP id t57so3254323wey.41
        for <linux-pm@vger.kernel.org>; Fri, 15 Mar 2013 07:27:41 -0700 (PDT)
In-Reply-To: <1363357630-22214-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linaro-kernel@lists.linaro.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Cc: linux@maxim.org.za, nicolas.ferre@atmel.com, plagnioj@jcrosoft.com, lenb@kernel.org, rjw@sisk.pl, nsekhar@ti.com, kevin.hilman@linaro.org, horms@verge.net.au, magnus.damm@gmail.com, kernel@pengutronix.de, ben-linux@fluff.org, kgene.kim@samsung.com, rob.herring@calxeda.com, jason@lakedaemon.net, andrew@lunn.ch

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/cpuidle/cpuidle-kirkwood.c |   17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-kirkwood.c b/drivers/cpuidle/cpuidle-kirkwood.c
index 670aa1e..60efdc5 100644
--- a/drivers/cpuidle/cpuidle-kirkwood.c
+++ b/drivers/cpuidle/cpuidle-kirkwood.c
@@ -53,9 +53,6 @@ static struct cpuidle_driver kirkwood_idle_driver = {
 	},
 	.state_count = KIRKWOOD_MAX_STATES,
 };
-static struct cpuidle_device *device;
-
-static DEFINE_PER_CPU(struct cpuidle_device, kirkwood_cpuidle_device);
 
 /* Initialize CPU idle by registering the idle states */
 static int kirkwood_cpuidle_probe(struct platform_device *pdev)
@@ -70,22 +67,12 @@ static int kirkwood_cpuidle_probe(struct platform_device *pdev)
 	if (!ddr_operation_base)
 		return -EADDRNOTAVAIL;
 
-	device = &per_cpu(kirkwood_cpuidle_device, smp_processor_id());
-	device->state_count = KIRKWOOD_MAX_STATES;
-
-	cpuidle_register_driver(&kirkwood_idle_driver);
-	if (cpuidle_register_device(device)) {
-		pr_err("kirkwood_init_cpuidle: Failed registering\n");
-		return -EIO;
-	}
-	return 0;
+	return arm_idle_init(&kirkwood_idle_driver);
 }
 
 int kirkwood_cpuidle_remove(struct platform_device *pdev)
 {
-	cpuidle_unregister_device(device);
-	cpuidle_unregister_driver(&kirkwood_idle_driver);
-
+	arm_idle_exit(&kirkwood_idle_driver);
 	return 0;
 }
 
-- 
1.7.9.5

