From: Dmitry Torokhov <dtor@chromium.org>
Subject: [PATCH] thermal: rockchip: fix handling of invalid readings
Date: Fri, 7 Aug 2015 13:59:23 -0700
Message-ID: <20150807205923.GA33949@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:36688 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753805AbbHGU71 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 7 Aug 2015 16:59:27 -0400
Received: by pacrr5 with SMTP id rr5so60029057pac.3
        for <linux-pm@vger.kernel.org>; Fri, 07 Aug 2015 13:59:26 -0700 (PDT)
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Heiko Stuebner <heiko@sntech.de>
Cc: Eduardo Valentin <edubezval@gmail.com>, Caesar Wang <wxt@rock-chips.com>, dianders@chromium.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org

We attempted to signal invalid code by returning -EAGAIN from
rk_tsadcv2_code_to_temp(), unfortunately the return value was stuffed
directly into the temperature pointer, potentially confusing upper
layers with temperature of -EINVAL.

Let's split temperature from error/success indicator to avoid such
confusion.

Also change the way we scan the temperature table to start with the 2nd
element so that we do not need to worry that we may reference out of
bounds element while doing binary search and keep checking that we end
up with 'mid' equal to 0 (since we are looking for the temperature that
would fall into interval between the 'mid' and 'mid - 1') .

Signed-off-by: Dmitry Torokhov <dtor@chromium.org>
---
 drivers/thermal/rockchip_thermal.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
index c89ffb2..93ee307 100644
--- a/drivers/thermal/rockchip_thermal.c
+++ b/drivers/thermal/rockchip_thermal.c
@@ -124,7 +124,7 @@ struct rockchip_thermal_data {
 #define TSADCV2_AUTO_PERIOD_HT_TIME		50  /* msec */
 
 struct tsadc_table {
-	unsigned long code;
+	u32 code;
 	long temp;
 };
 
@@ -164,7 +164,6 @@ static const struct tsadc_table v2_code_table[] = {
 	{3452, 115000},
 	{3437, 120000},
 	{3421, 125000},
-	{0, 125000},
 };
 
 static u32 rk_tsadcv2_temp_to_code(long temp)
@@ -191,19 +190,21 @@ static u32 rk_tsadcv2_temp_to_code(long temp)
 	return 0;
 }
 
-static int rk_tsadcv2_code_to_temp(u32 code)
+static int rk_tsadcv2_code_to_temp(u32 code, int *temp)
 {
-	unsigned int low = 0;
+	unsigned int low = 1;
 	unsigned int high = ARRAY_SIZE(v2_code_table) - 1;
 	unsigned int mid = (low + high) / 2;
 	unsigned int num;
 	unsigned long denom;
 
-	/* Invalid code, return -EAGAIN */
-	if (code > TSADCV2_DATA_MASK)
-		return -EAGAIN;
+	BUILD_BUG_ON(ARRAY_SIZE(v2_code_table) < 2);
 
-	while (low <= high && mid) {
+	code &= TSADCV2_DATA_MASK;
+	if (code < v2_code_table[high].code)
+		return -EAGAIN;		/* Incorrect reading */
+
+	while (low <= high) {
 		if (code >= v2_code_table[mid].code &&
 		    code < v2_code_table[mid - 1].code)
 			break;
@@ -223,7 +224,9 @@ static int rk_tsadcv2_code_to_temp(u32 code)
 	num = v2_code_table[mid].temp - v2_code_table[mid - 1].temp;
 	num *= v2_code_table[mid - 1].code - code;
 	denom = v2_code_table[mid - 1].code - v2_code_table[mid].code;
-	return v2_code_table[mid - 1].temp + (num / denom);
+	*temp = v2_code_table[mid - 1].temp + (num / denom);
+
+	return 0;
 }
 
 /**
@@ -281,14 +284,9 @@ static int rk_tsadcv2_get_temp(int chn, void __iomem *regs, int *temp)
 {
 	u32 val;
 
-	/* the A/D value of the channel last conversion need some time */
 	val = readl_relaxed(regs + TSADCV2_DATA(chn));
-	if (val == 0)
-		return -EAGAIN;
-
-	*temp = rk_tsadcv2_code_to_temp(val);
 
-	return 0;
+	return rk_tsadcv2_code_to_temp(val, temp);
 }
 
 static void rk_tsadcv2_tshut_temp(int chn, void __iomem *regs, long temp)
-- 
2.5.0.rc2.392.g76e840b


-- 
Dmitry
