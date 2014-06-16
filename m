From: Chander Kashyap <k.chander@samsung.com>
Subject: [Patch v7 4/6] driver: cpuidle: cpuidle-big-little: init driver for Exynos5420
Date: Mon, 16 Jun 2014 15:56:21 +0530
Message-ID: <1402914383-20471-5-git-send-email-k.chander@samsung.com>
References: <1402914383-20471-1-git-send-email-k.chander@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f180.google.com ([209.85.192.180]:64358 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755231AbaFPK05 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 16 Jun 2014 06:26:57 -0400
In-Reply-To: <1402914383-20471-1-git-send-email-k.chander@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, daniel.lezcano@linaro.org, lorenzo.pieralisi@arm.com, rjw@rjwysocki.net, kgene.kim@samsung.com, tomasz.figa@gmail.com, Chander Kashyap <chander.kashyap@linaro.org>, Chander Kashyap <k.chander@samsung.com>

From: Chander Kashyap <chander.kashyap@linaro.org>

Add "samsung,exynos5420" compatible string to initialize generic
big-little cpuidle driver for Exynos5420.

Signed-off-by: Chander Kashyap <chander.kashyap@linaro.org>
Signed-off-by: Chander Kashyap <k.chander@samsung.com>
Reviewed-by: Tomasz Figa <t.figa@samsung.com>
Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
Changes in v5: None
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

