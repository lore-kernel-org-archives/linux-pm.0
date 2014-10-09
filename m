From: Lukasz Majewski <l.majewski@samsung.com>
Subject: [PATCH 20/21] thermal: exynos: Make Exynos5250 TMU compatible with
 Exynos4412
Date: Thu, 09 Oct 2014 18:38:56 +0200
Message-ID: <1412872737-624-21-git-send-email-l.majewski@samsung.com>
References: <1412872737-624-1-git-send-email-l.majewski@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:58917 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751118AbaJIQkc (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 9 Oct 2014 12:40:32 -0400
In-reply-to: <1412872737-624-1-git-send-email-l.majewski@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>
Cc: "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, Linux PM list <linux-pm@vger.kernel.org>, Kukjin Kim <kgene.kim@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, Amit Daniel Kachhap <amit.daniel@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Lukasz Majewski <l.majewski@samsung.com>

Since both SoCs have the same TMU IP block embedded on them, it is
not necessary to maintain separate compatible entry.

Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
---
 arch/arm/boot/dts/exynos5250.dtsi    | 2 +-
 drivers/thermal/samsung/exynos_tmu.c | 3 ---
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index e71ec78..3426bab 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -238,7 +238,7 @@
 	};
 
 	tmu: tmu@10060000 {
-		compatible = "samsung,exynos5250-tmu";
+		compatible = "samsung,exynos4412-tmu";
 		reg = <0x10060000 0x100>;
 		interrupts = <0 65 0>;
 		clocks = <&clock CLK_TMU>;
diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index e26042a..f1e8c9b 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -753,9 +753,6 @@ static const struct of_device_id exynos_tmu_match[] = {
 		.compatible = "samsung,exynos4412-tmu",
 	},
 	{
-		.compatible = "samsung,exynos5250-tmu",
-	},
-	{
 		.compatible = "samsung,exynos5260-tmu",
 	},
 	{
-- 
2.0.0.rc2

