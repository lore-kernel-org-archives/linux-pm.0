From: Chander Kashyap <chander.kashyap@linaro.org>
Subject: [Patch v4 3/5] driver: cpuidle: cpuidle-big-little: init driver for Exynos5420
Date: Mon,  5 May 2014 14:57:18 +0530
Message-ID: <1399282040-8995-4-git-send-email-chander.kashyap@linaro.org>
References: <1399278444-8312-3-git-send-email-chander.kashyap@linaro.org>
 <1399282040-8995-1-git-send-email-chander.kashyap@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:60654 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755895AbaEEJ1s (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 5 May 2014 05:27:48 -0400
Received: by mail-pa0-f48.google.com with SMTP id rd3so613021pab.7
        for <linux-pm@vger.kernel.org>; Mon, 05 May 2014 02:27:47 -0700 (PDT)
In-Reply-To: <1399282040-8995-1-git-send-email-chander.kashyap@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: lorenzo.pieralisi@arm.com, daniel.lezcano@linaro.org, rjw@rjwysocki.net, kgene.kim@samsung.com, Chander Kashyap <chander.kashyap@linaro.org>, Chander Kashyap <k.chander@samsung.com>

Add "samsung,exynos5420" compatible string to initialize generic
big-little cpuidle driver for Exynos5420.

Signed-off-by: Chander Kashyap <chander.kashyap@linaro.org>
Signed-off-by: Chander Kashyap <k.chander@samsung.com>
Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
Changes in v4: None
Changes in v3:
	1. Add compatible string to of_device_id table insted comparing directoly
Changes in v2: none

 drivers/cpuidle/cpuidle-big_little.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpuidle/cpuidle-big_little.c b/drivers/cpuidle/cpuidle-big_little.c
index 4cd02bd..344d79fa 100644
--- a/drivers/cpuidle/cpuidle-big_little.c
+++ b/drivers/cpuidle/cpuidle-big_little.c
@@ -165,6 +165,7 @@ static int __init bl_idle_driver_init(struct cpuidle_driver *drv, int cpu_id)
 
 static const struct of_device_id compatible_machine_match[] = {
 	{ .compatible = "arm,vexpress,v2p-ca15_a7" },
+	{ .compatible = "samsung,exynos5420" },
 	{},
 };
 
-- 
1.7.9.5

