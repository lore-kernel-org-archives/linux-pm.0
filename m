From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [V4 patch 13/15] ARM: kirkwood: cpuidle: use init/exit common routine
Date: Tue, 23 Apr 2013 10:54:43 +0200
Message-ID: <1366707285-12179-14-git-send-email-daniel.lezcano@linaro.org>
References: <1366707285-12179-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:41182 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756283Ab3DWIzY (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 23 Apr 2013 04:55:24 -0400
Received: by mail-wi0-f181.google.com with SMTP id c10so430885wiw.2
        for <linux-pm@vger.kernel.org>; Tue, 23 Apr 2013 01:55:22 -0700 (PDT)
In-Reply-To: <1366707285-12179-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: andrew@lunn.ch, khilman@deeprootsystems.com, nsekhar@ti.com, josephl@nvidia.com, kgene.kim@samsung.com, patches@linaro.org, magnus.damm@gmail.com, tony@atomide.com, plagnioj@jcrosoft.com, linaro-kernel@lists.linaro.org, jason@lakedaemon.net, swarren@wwwdotorg.org, rob.herring@calxeda.com, horms@verge.net.au, linux@maxim.org.za, linux-arm-kernel@lists.infradead.org, deepthi@linux.vnet.ibm.com, jkosina@suse.cz, linux-pm@vger.kernel.org, lethal@linux-sh.org, kernel@pengutronix.de

Remove the duplicated code and use the cpuidle common code for initialization.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Tested-by: Andrew Lunn <andrew@lunn.ch>
Acked-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/cpuidle/cpuidle-kirkwood.c |   17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-kirkwood.c b/drivers/cpuidle/cpuidle-kirkwood.c
index 6f31524..53290e1 100644
--- a/drivers/cpuidle/cpuidle-kirkwood.c
+++ b/drivers/cpuidle/cpuidle-kirkwood.c
@@ -52,9 +52,6 @@ static struct cpuidle_driver kirkwood_idle_driver = {
 	},
 	.state_count = KIRKWOOD_MAX_STATES,
 };
-static struct cpuidle_device *device;
-
-static DEFINE_PER_CPU(struct cpuidle_device, kirkwood_cpuidle_device);
 
 /* Initialize CPU idle by registering the idle states */
 static int kirkwood_cpuidle_probe(struct platform_device *pdev)
@@ -69,22 +66,12 @@ static int kirkwood_cpuidle_probe(struct platform_device *pdev)
 	if (IS_ERR(ddr_operation_base))
 		return PTR_ERR(ddr_operation_base);
 
-	device = &per_cpu(kirkwood_cpuidle_device, smp_processor_id());
-	device->state_count = KIRKWOOD_MAX_STATES;
-
-	cpuidle_register_driver(&kirkwood_idle_driver);
-	if (cpuidle_register_device(device)) {
-		pr_err("kirkwood_init_cpuidle: Failed registering\n");
-		return -EIO;
-	}
-	return 0;
+	return cpuidle_register(&kirkwood_idle_driver, NULL);
 }
 
 int kirkwood_cpuidle_remove(struct platform_device *pdev)
 {
-	cpuidle_unregister_device(device);
-	cpuidle_unregister_driver(&kirkwood_idle_driver);
-
+	cpuidle_unregister(&kirkwood_idle_driver);
 	return 0;
 }
 
-- 
1.7.9.5

