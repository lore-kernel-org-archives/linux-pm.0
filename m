From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH] ARM: ux500: cpuidle: fix section mismatch
Date: Fri, 27 Sep 2013 19:16:35 +0200
Message-ID: <1380302195-18678-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f53.google.com ([74.125.82.53]:43524 "EHLO
	mail-wg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753726Ab3I0RQj (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 27 Sep 2013 13:16:39 -0400
Received: by mail-wg0-f53.google.com with SMTP id x12so2493724wgg.20
        for <linux-pm@vger.kernel.org>; Fri, 27 Sep 2013 10:16:38 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linus.walleij@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org

The dbx500_cpuidle_probe is tagged as an __init section but the variable
dbx500_cpuidle_plat_driver is not.

The dbx500_cpuidle_probe could not be declared as __init because of macro
module_platform_driver builds the exit function, tags as __exit and this one
refers to the dbx500_cpuidle_plat_driver which is an __initdata.

That leads to a section mismatch.

Fix it by removing the __init tag for the probe function.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/cpuidle/cpuidle-ux500.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpuidle/cpuidle-ux500.c b/drivers/cpuidle/cpuidle-ux500.c
index e056465..5e35804 100644
--- a/drivers/cpuidle/cpuidle-ux500.c
+++ b/drivers/cpuidle/cpuidle-ux500.c
@@ -111,7 +111,7 @@ static struct cpuidle_driver ux500_idle_driver = {
 	.state_count = 2,
 };
 
-static int __init dbx500_cpuidle_probe(struct platform_device *pdev)
+static int dbx500_cpuidle_probe(struct platform_device *pdev)
 {
 	/* Configure wake up reasons */
 	prcmu_enable_wakeups(PRCMU_WAKEUP(ARM) | PRCMU_WAKEUP(RTC) |
-- 
1.7.9.5

