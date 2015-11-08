From: Caesar Wang <wxt@rock-chips.com>
Subject: [PATCH v3 06/10] thermal: rockchip: consistently use int for temperatures
Date: Sun,  8 Nov 2015 17:26:04 +0800
Message-ID: <1446974768-25795-7-git-send-email-wxt@rock-chips.com>
References: <1446974768-25795-1-git-send-email-wxt@rock-chips.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:33476 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752957AbbKHJ0u (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 8 Nov 2015 04:26:50 -0500
In-Reply-To: <1446974768-25795-1-git-send-email-wxt@rock-chips.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Heiko Stuebner <heiko@sntech.de>, Eduardo Valentin <edubezval@gmail.com>
Cc: linux-rockchip@lists.infradead.org, Caesar Wang <wxt@rock-chips.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, linux-arm-kernel@lists.infradead.org

As Temperature is currently represented as int not long in the thermal
framework since use int intead of unsigned long/long to represent temperature
to avoid bogus overheat detection when negative temperature reported.

Signed-off-by: Caesar Wang <wxt@rock-chips.com>

---

Changes in v3:
- As the Patch v2 comments, Add a new patch to fix it.

Changes in v2: None
Changes in v1: None

 drivers/thermal/rockchip_thermal.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
index c1ab346..067ecdd 100644
--- a/drivers/thermal/rockchip_thermal.c
+++ b/drivers/thermal/rockchip_thermal.c
@@ -87,7 +87,7 @@ struct rockchip_tsadc_chip {
 	int chn_num;
 
 	/* The hardware-controlled tshut property */
-	long tshut_temp;
+	int tshut_temp;
 	enum tshut_mode tshut_mode;
 	enum tshut_polarity tshut_polarity;
 
@@ -100,7 +100,7 @@ struct rockchip_tsadc_chip {
 	int (*get_temp)(struct chip_tsadc_table table,
 			int chn, void __iomem *reg, int *temp);
 	void (*set_tshut_temp)(struct chip_tsadc_table table,
-			       int chn, void __iomem *reg, long temp);
+			       int chn, void __iomem *reg, int temp);
 	void (*set_tshut_mode)(int chn, void __iomem *reg, enum tshut_mode m);
 
 	/* Per-table methods */
@@ -125,7 +125,7 @@ struct rockchip_thermal_data {
 
 	void __iomem *regs;
 
-	long tshut_temp;
+	int tshut_temp;
 	enum tshut_mode tshut_mode;
 	enum tshut_polarity tshut_polarity;
 };
@@ -159,7 +159,7 @@ struct rockchip_thermal_data {
 
 struct tsadc_table {
 	u32 code;
-	long temp;
+	int temp;
 };
 
 static const struct tsadc_table v2_code_table[] = {
@@ -201,7 +201,7 @@ static const struct tsadc_table v2_code_table[] = {
 };
 
 static u32 rk_tsadcv2_temp_to_code(struct chip_tsadc_table table,
-				   long temp)
+				   int temp)
 {
 	int high, low, mid;
 
@@ -355,7 +355,7 @@ static int rk_tsadcv2_get_temp(struct chip_tsadc_table table,
 }
 
 static void rk_tsadcv2_tshut_temp(struct chip_tsadc_table table,
-				  int chn, void __iomem *regs, long temp)
+				  int chn, void __iomem *regs, int temp)
 {
 	u32 tshut_value, val;
 
-- 
1.9.1

