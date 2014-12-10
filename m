From: Lukasz Majewski <l.majewski@samsung.com>
Subject: [PATCH v2 16/17] thermal: exynos: Make Exynos5250 TMU compatible with
 Exynos4412
Date: Wed, 10 Dec 2014 13:09:55 +0100
Message-ID: <1418213396-743-17-git-send-email-l.majewski@samsung.com>
References: <1412872737-624-1-git-send-email-l.majewski@samsung.com>
 <1418213396-743-1-git-send-email-l.majewski@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:23280 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751442AbaLJMOk (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 10 Dec 2014 07:14:40 -0500
In-reply-to: <1418213396-743-1-git-send-email-l.majewski@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>
Cc: Linux PM list <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, Kukjin Kim <kgene.kim@samsung.com>, Amit Daniel Kachhap <amit.daniel@samsung.com>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Abhilash Kesavan <a.kesavan@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Lukasz Majewski <l.majewski@samsung.com>

Both SoCs have the same TMU IP block embedded on them. Necessary differences
are specified via device tree.

Therefore there is no need to maintain a separate compatible entry.

Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
---
Changes for v2:
- None
---
 arch/arm/boot/dts/exynos5250.dtsi    | 2 +-
 drivers/thermal/samsung/exynos_tmu.c | 3 ---
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index 2167394..7cb1a5b 100644
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
index dfbf9bd..05441fc 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -768,9 +768,6 @@ static const struct of_device_id exynos_tmu_match[] = {
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

