From: Lukasz Majewski <l.majewski@samsung.com>
Subject: [PATCH v2 17/17] thermal: exynos: Make Exynos3250 TMU compatible with
 Exynos4412
Date: Wed, 10 Dec 2014 13:09:56 +0100
Message-ID: <1418213396-743-18-git-send-email-l.majewski@samsung.com>
References: <1412872737-624-1-git-send-email-l.majewski@samsung.com>
 <1418213396-743-1-git-send-email-l.majewski@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1418213396-743-1-git-send-email-l.majewski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>
Cc: Linux PM list <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, Kukjin Kim <kgene.kim@samsung.com>, Amit Daniel Kachhap <amit.daniel@samsung.com>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Abhilash Kesavan <a.kesavan@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Lukasz Majewski <l.majewski@samsung.com>
List-Id: linux-pm@vger.kernel.org

Both SoCs have the same TMU IP block embedded on them. Necessary differences
are specified via device tree.

Therefore there is no need to maintain a separate compatible entry.

Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
---
Changes for v2:
- Update DTS TMU entry for Exynos3250 to be compatible with Exynos4412
---
 arch/arm/boot/dts/exynos3250.dtsi    | 2 +-
 drivers/thermal/samsung/exynos_tmu.c | 3 ---
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/exynos3250.dtsi b/arch/arm/boot/dts/exynos3250.dtsi
index 6edfa76..306d988 100644
--- a/arch/arm/boot/dts/exynos3250.dtsi
+++ b/arch/arm/boot/dts/exynos3250.dtsi
@@ -185,7 +185,7 @@
 		};
 
 		tmu: tmu@100C0000 {
-			compatible = "samsung,exynos3250-tmu";
+			compatible = "samsung,exynos4412-tmu";
 			reg = <0x100C0000 0x100>;
 			interrupts = <0 216 0>;
 			clocks = <&cmu CLK_TMU_APBIF>;
diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 05441fc..86728c5 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -759,9 +759,6 @@ static irqreturn_t exynos_tmu_irq(int irq, void *id)
 
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
