From: Lukasz Majewski <l.majewski@samsung.com>
Subject: [PATCH 05/21] thermal: exynos: cosmetic: Correct comment format
Date: Thu, 09 Oct 2014 18:38:41 +0200
Message-ID: <1412872737-624-6-git-send-email-l.majewski@samsung.com>
References: <1412872737-624-1-git-send-email-l.majewski@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:58851 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757508AbaJIQj3 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 9 Oct 2014 12:39:29 -0400
In-reply-to: <1412872737-624-1-git-send-email-l.majewski@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>
Cc: "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, Linux PM list <linux-pm@vger.kernel.org>, Kukjin Kim <kgene.kim@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, Amit Daniel Kachhap <amit.daniel@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Lukasz Majewski <l.majewski@samsung.com>

Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
---
 drivers/thermal/samsung/exynos_tmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 9e7f720..fa29b95 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -606,7 +606,7 @@ out:
 #define exynos5440_tmu_set_emulation NULL
 static int exynos_tmu_set_emulation(void *drv_data,	unsigned long temp)
 	{ return -EINVAL; }
-#endif/*CONFIG_THERMAL_EMULATION*/
+#endif /* CONFIG_THERMAL_EMULATION */
 
 static int exynos4210_tmu_read(struct exynos_tmu_data *data)
 {
-- 
2.0.0.rc2

