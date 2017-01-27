From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH 3/4] soc: samsung: pm_domains: Remove message about failed
 memory allocation
Date: Fri, 27 Jan 2017 11:47:51 +0100
Message-ID: <1485514072-29502-4-git-send-email-m.szyprowski@samsung.com>
References: <1485514072-29502-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20170127104802eucas1p27facdbb5c2914da740f4d2ea6b87680b@eucas1p2.samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.w1.samsung.com ([210.118.77.14]:34153 "EHLO
        mailout4.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932666AbdA0KsG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 27 Jan 2017 05:48:06 -0500
In-reply-to: <1485514072-29502-1-git-send-email-m.szyprowski@samsung.com>
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

