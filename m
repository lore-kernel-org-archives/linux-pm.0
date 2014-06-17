From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH v2 8/9] thermal: exynos: remove redundant pdata checks from
 exynos_tmu_control()
Date: Tue, 17 Jun 2014 19:27:24 +0200
Message-ID: <1403026045-16024-9-git-send-email-b.zolnierkie@samsung.com>
References: <1403026045-16024-1-git-send-email-b.zolnierkie@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:25874 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964772AbaFQRbJ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 17 Jun 2014 13:31:09 -0400
In-reply-to: <1403026045-16024-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <eduardo.valentin@ti.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Amit Daniel Kachhap <amit.daniel@samsung.com>, Tomasz Figa <t.figa@samsung.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kyungmin Park <kyungmin.park@samsung.com>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com

pdata->reference_voltage and pdata->gain are always defined
to non-zero values so remove the redundant checks from
exynos_tmu_control().

There should be no functional changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/thermal/samsung/exynos_tmu.c | 12 ++++--------
 drivers/thermal/samsung/exynos_tmu.h |  4 ++--
 2 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 9455b23..b22f358 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -229,15 +229,11 @@ static void exynos_tmu_control(struct platform_device *pdev, bool on)
 	if (pdata->test_mux)
 		con |= (pdata->test_mux << reg->test_mux_addr_shift);
 
-	if (pdata->reference_voltage) {
-		con &= ~(reg->buf_vref_sel_mask << reg->buf_vref_sel_shift);
-		con |= pdata->reference_voltage << reg->buf_vref_sel_shift;
-	}
+	con &= ~(reg->buf_vref_sel_mask << reg->buf_vref_sel_shift);
+	con |= pdata->reference_voltage << reg->buf_vref_sel_shift;
 
-	if (pdata->gain) {
-		con &= ~(reg->buf_slope_sel_mask << reg->buf_slope_sel_shift);
-		con |= (pdata->gain << reg->buf_slope_sel_shift);
-	}
+	con &= ~(reg->buf_slope_sel_mask << reg->buf_slope_sel_shift);
+	con |= (pdata->gain << reg->buf_slope_sel_shift);
 
 	if (pdata->noise_cancel_mode) {
 		con &= ~(reg->therm_trip_mode_mask <<
diff --git a/drivers/thermal/samsung/exynos_tmu.h b/drivers/thermal/samsung/exynos_tmu.h
index b1c9f8d..5d36708 100644
--- a/drivers/thermal/samsung/exynos_tmu.h
+++ b/drivers/thermal/samsung/exynos_tmu.h
@@ -188,10 +188,10 @@ struct exynos_tmu_registers {
  * @max_trigger_level: max trigger level supported by the TMU
  * @non_hw_trigger_levels: number of defined non-hardware trigger levels
  * @gain: gain of amplifier in the positive-TC generator block
- *	0 <= gain <= 15
+ *	0 < gain <= 15
  * @reference_voltage: reference voltage of amplifier
  *	in the positive-TC generator block
- *	0 <= reference_voltage <= 31
+ *	0 < reference_voltage <= 31
  * @noise_cancel_mode: noise cancellation mode
  *	000, 100, 101, 110 and 111 can be different modes
  * @type: determines the type of SOC
-- 
1.8.2.3

