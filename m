From: Dmitry Torokhov <dtor@chromium.org>
Subject: [PATCH] thermal: rockhip: fix setting thermal shutdown polarity
Date: Fri, 7 Aug 2015 14:00:52 -0700
Message-ID: <20150807210052.GA34032@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:34569 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753837AbbHGVA4 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 7 Aug 2015 17:00:56 -0400
Received: by pawu10 with SMTP id u10so96233601paw.1
        for <linux-pm@vger.kernel.org>; Fri, 07 Aug 2015 14:00:54 -0700 (PDT)
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Heiko Stuebner <heiko@sntech.de>
Cc: Eduardo Valentin <edubezval@gmail.com>, Caesar Wang <wxt@rock-chips.com>, dianders@chromium.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org

When requested thermal shutdown signal polarity is low we need to make
sure that the bit representing high level of signal is reset, and not
set all other bits in that register.

Also rename TSADCV2_INT_PD_CLEAR to TSADCV2_INT_PD_CLEAR_MASK to better
reflect its nature.

Signed-off-by: Dmitry Torokhov <dtor@chromium.org>
---
 drivers/thermal/rockchip_thermal.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
index 93ee307..4d5b7d4 100644
--- a/drivers/thermal/rockchip_thermal.c
+++ b/drivers/thermal/rockchip_thermal.c
@@ -106,16 +106,14 @@ struct rockchip_thermal_data {
 #define TSADCV2_AUTO_PERIOD_HT			0x6c
 
 #define TSADCV2_AUTO_EN				BIT(0)
-#define TSADCV2_AUTO_DISABLE			~BIT(0)
 #define TSADCV2_AUTO_SRC_EN(chn)		BIT(4 + (chn))
 #define TSADCV2_AUTO_TSHUT_POLARITY_HIGH	BIT(8)
-#define TSADCV2_AUTO_TSHUT_POLARITY_LOW		~BIT(8)
 
 #define TSADCV2_INT_SRC_EN(chn)			BIT(chn)
 #define TSADCV2_SHUT_2GPIO_SRC_EN(chn)		BIT(4 + (chn))
 #define TSADCV2_SHUT_2CRU_SRC_EN(chn)		BIT(8 + (chn))
 
-#define TSADCV2_INT_PD_CLEAR			~BIT(8)
+#define TSADCV2_INT_PD_CLEAR_MASK		~BIT(8)
 
 #define TSADCV2_DATA_MASK			0xfff
 #define TSADCV2_HIGHT_INT_DEBOUNCE_COUNT	4
@@ -244,10 +242,10 @@ static void rk_tsadcv2_initialize(void __iomem *regs,
 				  enum tshut_polarity tshut_polarity)
 {
 	if (tshut_polarity == TSHUT_HIGH_ACTIVE)
-		writel_relaxed(0 | (TSADCV2_AUTO_TSHUT_POLARITY_HIGH),
+		writel_relaxed(0U | TSADCV2_AUTO_TSHUT_POLARITY_HIGH,
 			       regs + TSADCV2_AUTO_CON);
 	else
-		writel_relaxed(0 | (TSADCV2_AUTO_TSHUT_POLARITY_LOW),
+		writel_relaxed(0U & ~TSADCV2_AUTO_TSHUT_POLARITY_HIGH,
 			       regs + TSADCV2_AUTO_CON);
 
 	writel_relaxed(TSADCV2_AUTO_PERIOD_TIME, regs + TSADCV2_AUTO_PERIOD);
@@ -264,7 +262,7 @@ static void rk_tsadcv2_irq_ack(void __iomem *regs)
 	u32 val;
 
 	val = readl_relaxed(regs + TSADCV2_INT_PD);
-	writel_relaxed(val & TSADCV2_INT_PD_CLEAR, regs + TSADCV2_INT_PD);
+	writel_relaxed(val & TSADCV2_INT_PD_CLEAR_MASK, regs + TSADCV2_INT_PD);
 }
 
 static void rk_tsadcv2_control(void __iomem *regs, bool enable)
-- 
2.5.0.rc2.392.g76e840b


-- 
Dmitry
