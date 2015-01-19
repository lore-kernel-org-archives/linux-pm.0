From: Lukasz Majewski <l.majewski@samsung.com>
Subject: [PATCH v5 18/18] thermal: exynos: Remove not needed
 exynos_tmu_init_data declarations from exynos_tmu.h
Date: Mon, 19 Jan 2015 12:21:02 +0100
Message-ID: <1421666462-7606-19-git-send-email-l.majewski@samsung.com>
References: <1412872737-624-1-git-send-email-l.majewski@samsung.com>
 <1421666462-7606-1-git-send-email-l.majewski@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:40761 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751526AbbASLZH (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 19 Jan 2015 06:25:07 -0500
In-reply-to: <1421666462-7606-1-git-send-email-l.majewski@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, Amit Daniel Kachhap <amit.daniel@samsung.com>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Abhilash Kesavan <a.kesavan@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Lukasz Majewski <l.majewski@samsung.com>

After switching to device tree based configuration those declarations are
not needed anymore.

Reported-by: Abhilash Kesavan <a.kesavan@samsung.com>
Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
---
Changes for v5:
- New patch
---
 drivers/thermal/samsung/exynos_tmu.h | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.h b/drivers/thermal/samsung/exynos_tmu.h
index d876d4c..9f9b1b8 100644
--- a/drivers/thermal/samsung/exynos_tmu.h
+++ b/drivers/thermal/samsung/exynos_tmu.h
@@ -71,12 +71,4 @@ struct exynos_tmu_platform_data {
 	u32 cal_mode;
 };
 
-extern struct exynos_tmu_init_data const exynos3250_default_tmu_data;
-extern struct exynos_tmu_init_data const exynos4210_default_tmu_data;
-extern struct exynos_tmu_init_data const exynos4412_default_tmu_data;
-extern struct exynos_tmu_init_data const exynos5250_default_tmu_data;
-extern struct exynos_tmu_init_data const exynos5260_default_tmu_data;
-extern struct exynos_tmu_init_data const exynos5420_default_tmu_data;
-extern struct exynos_tmu_init_data const exynos5440_default_tmu_data;
-
 #endif /* _EXYNOS_TMU_H */
-- 
2.0.0.rc2

