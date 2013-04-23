From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 1/2] ARM: s3c64xx: cpuidle: use init/exit common routine
Date: Tue, 23 Apr 2013 16:41:16 +0200
Message-ID: <1366728077-18988-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:38706 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752095Ab3DWOlW (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 23 Apr 2013 10:41:22 -0400
Received: by mail-wi0-f170.google.com with SMTP id l13so6579782wie.3
        for <linux-pm@vger.kernel.org>; Tue, 23 Apr 2013 07:41:20 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
Cc: ben-linux@fluff.org, kgene.kim@samsung.com, horms+renesas@verge.net.au, lethal@linux-sh.org, patches@linaro.org, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org

Remove the duplicated code and use the cpuidle common code for initialization.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/mach-s3c64xx/cpuidle.c |   14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/cpuidle.c b/arch/arm/mach-s3c64xx/cpuidle.c
index 852ff16..3c8ab07 100644
--- a/arch/arm/mach-s3c64xx/cpuidle.c
+++ b/arch/arm/mach-s3c64xx/cpuidle.c
@@ -40,8 +40,6 @@ static int s3c64xx_enter_idle(struct cpuidle_device *dev,
 	return index;
 }
 
-static DEFINE_PER_CPU(struct cpuidle_device, s3c64xx_cpuidle_device);
-
 static struct cpuidle_driver s3c64xx_cpuidle_driver = {
 	.name	= "s3c64xx_cpuidle",
 	.owner  = THIS_MODULE,
@@ -60,16 +58,6 @@ static struct cpuidle_driver s3c64xx_cpuidle_driver = {
 
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
+	return cpuidle_register(&s3c64xx_cpuidle_driver, NULL);
 }
 device_initcall(s3c64xx_init_cpuidle);
-- 
1.7.9.5

