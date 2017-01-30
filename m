From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v3 1/5] soc: samsung: pm_domains: Use full names in subdomains
 registration log
Date: Mon, 30 Jan 2017 13:18:56 +0100
Message-ID: <1485778740-30337-2-git-send-email-m.szyprowski@samsung.com>
References: <1485778740-30337-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20170130121913eucas1p22838794c26581e0b1757f2610ce9b32d@eucas1p2.samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.w1.samsung.com ([210.118.77.11]:23651 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752996AbdA3Mai (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 30 Jan 2017 07:30:38 -0500
In-reply-to: <1485778740-30337-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Inki Dae <inki.dae@samsung.com>

Device tree none name for each power domain should be "power-domain", so
use a bit more descriptive full node name in messages about subdomain
registration. This way the following meaningless message:

power-domain has as child subdomain: power-domain.

is changed to a bit more meaningful one:

/soc/power-domain@105c40a0 has as child subdomain: /soc/power-domain@105c4020.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/soc/samsung/pm_domains.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/samsung/pm_domains.c b/drivers/soc/samsung/pm_domains.c
index 15bad1543409..c33196087e9f 100644
--- a/drivers/soc/samsung/pm_domains.c
+++ b/drivers/soc/samsung/pm_domains.c
@@ -234,10 +234,10 @@ static __init int exynos4_pm_init_power_domain(void)
 
 		if (of_genpd_add_subdomain(&parent, &child))
 			pr_warn("%s failed to add subdomain: %s\n",
-				parent.np->name, child.np->name);
+				parent.np->full_name, child.np->full_name);
 		else
 			pr_info("%s has as child subdomain: %s.\n",
-				parent.np->name, child.np->name);
+				parent.np->full_name, child.np->full_name);
 	}
 
 	return 0;
-- 
1.9.1

