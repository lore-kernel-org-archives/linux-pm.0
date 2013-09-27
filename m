From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 1/2] ARM: zynq: cpuidle: Remove useless compatibility string
Date: Fri, 27 Sep 2013 10:17:46 +0200
Message-ID: <1380269867-18336-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f41.google.com ([74.125.82.41]:60711 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753071Ab3I0IRu (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 27 Sep 2013 04:17:50 -0400
Received: by mail-wg0-f41.google.com with SMTP id l18so472857wgh.0
        for <linux-pm@vger.kernel.org>; Fri, 27 Sep 2013 01:17:49 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: michal.simek@xilinx.com
Cc: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org

All zynq platforms have this compatibility string and there is no any other
clone.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/cpuidle/cpuidle-zynq.c |    4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-zynq.c b/drivers/cpuidle/cpuidle-zynq.c
index 38e03a1..ab6c4b4 100644
--- a/drivers/cpuidle/cpuidle-zynq.c
+++ b/drivers/cpuidle/cpuidle-zynq.c
@@ -28,7 +28,6 @@
 #include <linux/init.h>
 #include <linux/cpu_pm.h>
 #include <linux/cpuidle.h>
-#include <linux/of.h>
 #include <asm/proc-fns.h>
 #include <asm/cpuidle.h>
 
@@ -72,9 +71,6 @@ static struct cpuidle_driver zynq_idle_driver = {
 /* Initialize CPU idle by registering the idle states */
 static int __init zynq_cpuidle_init(void)
 {
-	if (!of_machine_is_compatible("xlnx,zynq-7000"))
-		return -ENODEV;
-
 	pr_info("Xilinx Zynq CpuIdle Driver started\n");
 
 	return cpuidle_register(&zynq_idle_driver, NULL);
-- 
1.7.9.5

