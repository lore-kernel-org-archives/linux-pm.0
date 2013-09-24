From: Lukasz Majewski <l.majewski@samsung.com>
Subject: [PATCH 3/6] thermal: exynos: Provide initial setting for TMU's test
 MUX address at Exynos4412
Date: Tue, 24 Sep 2013 10:08:19 +0200
Message-ID: <1380010102-25817-4-git-send-email-l.majewski@samsung.com>
References: <1380010102-25817-1-git-send-email-l.majewski@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1380010102-25817-1-git-send-email-l.majewski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>, Amit Daniel Kachhap <amit.daniel@samsung.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Linux PM list <linux-pm@vger.kernel.org>, Jonghwa Lee <jonghwa3.lee@samsung.com>, Lukasz Majewski <l.majewski@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, linux-kernel <linux-kernel@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Tomasz Figa <t.figa@samsung.com>, Myungjoo Ham <myungjoo.ham@samsung.com>, devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The commit d0a0ce3e77c795258d47f9163e92d5031d0c5221 ("thermal: exynos: Add
missing definations and code cleanup") has removed setting of test MUX address
value at TMU configuration setting.

This field is not present on Exynos4210 and Exynos5 SoCs. However on Exynos4412
SoC it is required to set this field after reset because without it TMU shows
maximal available temperature, which causes immediate platform shutdown.

Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Reviewed-by: Tomasz Figa <t.figa@samsung.com>
---
 drivers/thermal/samsung/exynos_tmu.c      |    3 +++
 drivers/thermal/samsung/exynos_tmu_data.h |    4 ++++
 2 files changed, 7 insertions(+)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index a858cc4..21b89e4 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -317,6 +317,9 @@ static void exynos_tmu_control(struct platform_device *pdev, bool on)
 
 	con = readl(data->base + reg->tmu_ctrl);
 
+	if (pdata->type == SOC_ARCH_EXYNOS4412)
+		con |= (EXYNOS4412_MUX_ADDR_VALUE << EXYNOS4412_MUX_ADDR_SHIFT);
+
 	if (pdata->reference_voltage) {
 		con &= ~(reg->buf_vref_sel_mask << reg->buf_vref_sel_shift);
 		con |= pdata->reference_voltage << reg->buf_vref_sel_shift;
diff --git a/drivers/thermal/samsung/exynos_tmu_data.h b/drivers/thermal/samsung/exynos_tmu_data.h
index b130b1e..a1ea19d 100644
--- a/drivers/thermal/samsung/exynos_tmu_data.h
+++ b/drivers/thermal/samsung/exynos_tmu_data.h
@@ -95,6 +95,10 @@
 
 #define EXYNOS_MAX_TRIGGER_PER_REG	4
 
+/* Exynos4412 specific */
+#define EXYNOS4412_MUX_ADDR_VALUE          6
+#define EXYNOS4412_MUX_ADDR_SHIFT          20
+
 /*exynos5440 specific registers*/
 #define EXYNOS5440_TMU_S0_7_TRIM		0x000
 #define EXYNOS5440_TMU_S0_7_CTRL		0x020
-- 
1.7.10.4
