From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 4/4][V2] davinci: cpuidle - remove useless initialization
Date: Mon,  4 Feb 2013 13:01:44 +0100
Message-ID: <1359979304-8715-5-git-send-email-daniel.lezcano@linaro.org>
References: <1359979304-8715-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f54.google.com ([74.125.82.54]:34143 "EHLO
	mail-wg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755620Ab3BDMB6 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 4 Feb 2013 07:01:58 -0500
Received: by mail-wg0-f54.google.com with SMTP id fm10so4757263wgb.9
        for <linux-pm@vger.kernel.org>; Mon, 04 Feb 2013 04:01:57 -0800 (PST)
In-Reply-To: <1359979304-8715-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: khilman@deeprootsystems.com, nsekhar@ti.com
Cc: patches@linaro.org, linaro-dev@lists.linaro.org, davinci-linux-open-source@linux.davincidsp.com, lenb@kernel.org, linux-pm@vger.kernel.org

The device->state_count is initialized in the cpuidle_register_device
function.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: Sekhar Nori <nsekhar@ti.com>
---
 arch/arm/mach-davinci/cpuidle.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/mach-davinci/cpuidle.c b/arch/arm/mach-davinci/cpuidle.c
index 5e430bf..5ac9e93 100644
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

