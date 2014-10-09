From: Lukasz Majewski <l.majewski@samsung.com>
Subject: [PATCH 21/21] thermal: exynos: Make Exynos3250 TMU compatible with
 Exynos4412
Date: Thu, 09 Oct 2014 18:38:57 +0200
Message-ID: <1412872737-624-22-git-send-email-l.majewski@samsung.com>
References: <1412872737-624-1-git-send-email-l.majewski@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:17238 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751118AbaJIQkh (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 9 Oct 2014 12:40:37 -0400
In-reply-to: <1412872737-624-1-git-send-email-l.majewski@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>
Cc: "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, Linux PM list <linux-pm@vger.kernel.org>, Kukjin Kim <kgene.kim@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, Amit Daniel Kachhap <amit.daniel@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Lukasz Majewski <l.majewski@samsung.com>

Since both SoCs have the same TMU IP block embedded on them, it is
not necessary to maintain separate compatible entry.

Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
---
 drivers/thermal/samsung/exynos_tmu.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index f1e8c9b..7818e2f 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -744,9 +744,6 @@ static irqreturn_t exynos_tmu_irq(int irq, void *id)
 
 static const struct of_device_id exynos_tmu_match[] = {
 	{
-		.compatible = "samsung,exynos3250-tmu",
-	},
-	{
 		.compatible = "samsung,exynos4210-tmu",
 	},
 	{
-- 
2.0.0.rc2

