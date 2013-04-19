From: Lukasz Majewski <l.majewski@samsung.com>
Subject: [PATCH 1/6] clk:exynos4:TMU Thermal Measurement Unit clock added to
 common clock framework
Date: Fri, 19 Apr 2013 18:38:08 +0200
Message-ID: <1366389493-8239-2-git-send-email-l.majewski@samsung.com>
References: <1366389493-8239-1-git-send-email-l.majewski@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:51141 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030927Ab3DSQi1 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 19 Apr 2013 12:38:27 -0400
In-reply-to: <1366389493-8239-1-git-send-email-l.majewski@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kukjin Kim <kgene.kim@samsung.com>
Cc: Mike Turquette <mturquette@linaro.org>, Zhang Rui <rui.zhang@intel.com>, devicetree-discuss@lists.ozlabs.org, linux-samsung-soc@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>, Amit Daniel Kachhap <amit.kachhap@linaro.org>, Lukasz Majewski <l.majewski@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>

TMU is now supported with a exynos4 common clock framework.
"tmu_apbif" clock has been defined with a common clock framework.

Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
Cc: Mike Turquette <mturquette@linaro.org>
---
 Documentation/devicetree/bindings/clock/exynos4-clock.txt |    1 +
 drivers/clk/samsung/clk-exynos4.c                         |    6 +++++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/clock/exynos4-clock.txt b/Documentation/devicetree/bindings/clock/exynos4-clock.txt
index ea5e26f..9afe6cb 100644
--- a/Documentation/devicetree/bindings/clock/exynos4-clock.txt
+++ b/Documentation/devicetree/bindings/clock/exynos4-clock.txt
@@ -235,6 +235,7 @@ Exynos4 SoC and this is specified where applicable.
   spi0_isp_sclk       380     Exynos4x12
   spi1_isp_sclk       381     Exynos4x12
   uart_isp_sclk       382     Exynos4x12
+  tmu_apbif           383
 
 		[Mux Clocks]
 
diff --git a/drivers/clk/samsung/clk-exynos4.c b/drivers/clk/samsung/clk-exynos4.c
index 7104669..66c4ce4 100644
--- a/drivers/clk/samsung/clk-exynos4.c
+++ b/drivers/clk/samsung/clk-exynos4.c
@@ -170,7 +170,7 @@ enum exynos4_clks {
 	gicisp, smmu_isp, smmu_drc, smmu_fd, smmu_lite0, smmu_lite1, mcuctl_isp,
 	mpwm_isp, i2c0_isp, i2c1_isp, mtcadc_isp, pwm_isp, wdt_isp, uart_isp,
 	asyncaxim, smmu_ispcx, spi0_isp, spi1_isp, pwm_isp_sclk, spi0_isp_sclk,
-	spi1_isp_sclk, uart_isp_sclk,
+	spi1_isp_sclk, uart_isp_sclk, tmu_apbif,
 
 	/* mux clocks */
 	mout_fimc0 = 384, mout_fimc1, mout_fimc2, mout_fimc3, mout_cam0,
@@ -807,6 +807,8 @@ struct samsung_gate_clock exynos4210_gate_clks[] __initdata = {
 	GATE_A(wdt, "watchdog", "aclk100", E4210_GATE_IP_PERIR, 14, 0, 0, "watchdog"),
 	GATE_A(rtc, "rtc", "aclk100", E4210_GATE_IP_PERIR, 15, 0, 0, "rtc"),
 	GATE_A(keyif, "keyif", "aclk100", E4210_GATE_IP_PERIR, 16, 0, 0, "keypad"),
+	GATE_A(tmu_apbif, "tmu_apbif", "aclk100",
+	       E4210_GATE_IP_PERIR, 17, 0, 0, "tmu_apbif"),
 	GATE_DA(sclk_fimd1, "exynos4-fb.1", "sclk_fimd1", "div_fimd1",
 			E4210_SRC_MASK_LCD1, 0, CLK_SET_RATE_PARENT, 0, "sclk_fimd"),
 };
@@ -834,6 +836,8 @@ struct samsung_gate_clock exynos4x12_gate_clks[] __initdata = {
 	GATE_A(rtc, "rtc", "aclk100", E4X12_GATE_IP_PERIR, 15, 0, 0, "rtc"),
 	GATE_A(keyif, "keyif", "aclk100",
 			E4X12_GATE_IP_PERIR, 16, 0, 0, "keypad"),
+	GATE_A(tmu_apbif, "tmu_apbif", "aclk100",
+			E4X12_GATE_IP_PERIR, 17, 0, 0, "tmu_apbif"),
 	GATE(sclk_pwm_isp, "sclk_pwm_isp", "div_pwm_isp",
 			E4X12_SRC_MASK_ISP, 0, CLK_SET_RATE_PARENT, 0),
 	GATE(sclk_spi0_isp, "sclk_spi0_isp", "div_spi0_isp_pre",
-- 
1.7.10.4

