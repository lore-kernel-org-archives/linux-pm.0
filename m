From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 4/4] davinci: cpuidle - remove useless initialization
Date: Fri,  1 Feb 2013 14:48:15 +0100
Message-ID: <1359726495-8024-5-git-send-email-daniel.lezcano@linaro.org>
References: <1359726495-8024-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:45710 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755309Ab3BANs1 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 1 Feb 2013 08:48:27 -0500
Received: by mail-wi0-f175.google.com with SMTP id l13so76574wie.14
        for <linux-pm@vger.kernel.org>; Fri, 01 Feb 2013 05:48:26 -0800 (PST)
In-Reply-To: <1359726495-8024-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: nsekhar@ti.com, khilman@ti.com
Cc: patches@linaro.org, linaro-dev@lists.linaro.org, davinci-linux-open-source@linux.davincidsp.com, lenb@kernel.org, linux-pm@vger.kernel.org

The device->state_count is initialized in the cpuidle_register_device
function.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/mach-davinci/cpuidle.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/mach-davinci/cpuidle.c b/arch/arm/mach-davinci/cpuidle.c
index 28cc8e8..144839b 100644
--- a/arch/arm/mach-davinci/cpuidle.c
+++ b/arch/arm/mach-davinci/cpuidle.c
@@ -96,8 +96,6 @@ static int __init davinci_cpuidle_probe(struct platform_device *pdev)
 
 	ddr2_pdown = pdata->ddr2_pdown;
 
-	device->state_count = DAVINCI_CPUIDLE_MAX_STATES;
-
 	ret = cpuidle_register_driver(&davinci_idle_driver);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to register driver\n");
-- 
1.7.9.5

