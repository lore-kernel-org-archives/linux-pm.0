From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v3 3/5] soc: samsung: pm_domains: Remove message about failed
 memory allocation
Date: Mon, 30 Jan 2017 13:18:58 +0100
Message-ID: <1485778740-30337-4-git-send-email-m.szyprowski@samsung.com>
References: <1485778740-30337-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20170130121924eucas1p24f99bd1ca38a37d88d54aae96d0e141f@eucas1p2.samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.w1.samsung.com ([210.118.77.13]:18855 "EHLO
        mailout3.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752523AbdA3Mag (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 30 Jan 2017 07:30:36 -0500
In-reply-to: <1485778740-30337-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Inki Dae <inki.dae@samsung.com>

Memory subsystem already prints message about failed memory
allocation, there is no need to do it in the drivers.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/soc/samsung/pm_domains.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/soc/samsung/pm_domains.c b/drivers/soc/samsung/pm_domains.c
index 00e32772655a..5a0a46bcbe18 100644
--- a/drivers/soc/samsung/pm_domains.c
+++ b/drivers/soc/samsung/pm_domains.c
@@ -156,8 +156,6 @@ static __init int exynos4_pm_init_power_domain(void)
 
 		pd = kzalloc(sizeof(*pd), GFP_KERNEL);
 		if (!pd) {
-			pr_err("%s: failed to allocate memory for domain\n",
-					__func__);
 			of_node_put(np);
 			return -ENOMEM;
 		}
-- 
1.9.1

