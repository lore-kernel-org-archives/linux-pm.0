From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 2/2] SH: cpuidle: use init/exit common routine
Date: Tue, 23 Apr 2013 16:41:17 +0200
Message-ID: <1366728077-18988-2-git-send-email-daniel.lezcano@linaro.org>
References: <1366728077-18988-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:33512 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752242Ab3DWOlX (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 23 Apr 2013 10:41:23 -0400
Received: by mail-wi0-f177.google.com with SMTP id hj19so865291wib.10
        for <linux-pm@vger.kernel.org>; Tue, 23 Apr 2013 07:41:22 -0700 (PDT)
In-Reply-To: <1366728077-18988-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
Cc: ben-linux@fluff.org, kgene.kim@samsung.com, horms+renesas@verge.net.au, lethal@linux-sh.org, patches@linaro.org, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org

Remove the duplicated code and use the cpuidle common code for initialization.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/sh/kernel/cpu/shmobile/cpuidle.c |    7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/sh/kernel/cpu/shmobile/cpuidle.c b/arch/sh/kernel/cpu/shmobile/cpuidle.c
index fdfe57f4..d306225 100644
--- a/arch/sh/kernel/cpu/shmobile/cpuidle.c
+++ b/arch/sh/kernel/cpu/shmobile/cpuidle.c
@@ -51,7 +51,6 @@ static int cpuidle_sleep_enter(struct cpuidle_device *dev,
 	return k;
 }
 
-static struct cpuidle_device cpuidle_dev;
 static struct cpuidle_driver cpuidle_driver = {
 	.name   = "sh_idle",
 	.owner  = THIS_MODULE,
@@ -100,9 +99,5 @@ int __init sh_mobile_setup_cpuidle(void)
 	if (sh_mobile_sleep_supported & SUSP_SH_STANDBY)
 		cpuidle_driver.states[2].disabled = false;
 
-	ret = cpuidle_register_driver(&cpuidle_driver);
-	if (ret)
-		return ret;
-
-	return cpuidle_register_device(&cpuidle_dev);
+	return cpuidle_register(&cpuidle_driver);
 }
-- 
1.7.9.5

