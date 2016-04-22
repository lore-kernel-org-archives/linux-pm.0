From: Caesar Wang <wxt@rock-chips.com>
Subject: [RESEND PATCH 3/8] thermal: rockchip: update the tsadc table for rk3399
Date: Fri, 22 Apr 2016 18:02:49 +0800
Message-ID: <1461319374-10024-4-git-send-email-wxt@rock-chips.com>
References: <1461319374-10024-1-git-send-email-wxt@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1461319374-10024-1-git-send-email-wxt@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: edubezval@gmail.com, Heiko Stuebner <heiko@sntech.de>
Cc: dianders@chromium.org, briannorris@google.com, smbarber@google.com, linux-rockchip@lists.infradead.org, Caesar Wang <wxt@rock-chips.com>, Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

This patch fixes the incorrect conversion table.
The Code to Temperature mapping is updated based on sillcon results.

Fixes commit b0d70338bca22cb14
("thermal: rockchip: Support the RK3399 SoCs in thermal driver").

Signed-off-by: Caesar Wang <wxt@rock-chips.com>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <edubezval@gmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>
---

 drivers/thermal/rockchip_thermal.c | 68 +++++++++++++++++++-------------------
 1 file changed, 34 insertions(+), 34 deletions(-)

diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
index 658772f..e5064d7 100644
--- a/drivers/thermal/rockchip_thermal.c
+++ b/drivers/thermal/rockchip_thermal.c
@@ -308,40 +308,40 @@ static const struct tsadc_table rk3368_code_table[] = {
 
 static const struct tsadc_table rk3399_code_table[] = {
 	{0, -40000},
-	{593, -40000},
-	{598, -35000},
-	{603, -30000},
-	{609, -25000},
-	{614, -20000},
-	{619, -15000},
-	{625, -10000},
-	{630, -5000},
-	{635, 0},
-	{641, 5000},
-	{646, 10000},
-	{651, 15000},
-	{657, 20000},
-	{662, 25000},
-	{667, 30000},
-	{673, 35000},
-	{678, 40000},
-	{684, 45000},
-	{689, 50000},
-	{694, 55000},
-	{700, 60000},
-	{705, 65000},
-	{711, 70000},
-	{716, 75000},
-	{722, 80000},
-	{727, 85000},
-	{733, 90000},
-	{738, 95000},
-	{743, 100000},
-	{749, 105000},
-	{754, 110000},
-	{760, 115000},
-	{765, 120000},
-	{771, 125000},
+	{402, -40000},
+	{410, -35000},
+	{419, -30000},
+	{427, -25000},
+	{436, -20000},
+	{444, -15000},
+	{453, -10000},
+	{461, -5000},
+	{470, 0},
+	{478, 5000},
+	{487, 10000},
+	{496, 15000},
+	{504, 20000},
+	{513, 25000},
+	{521, 30000},
+	{530, 35000},
+	{538, 40000},
+	{547, 45000},
+	{555, 50000},
+	{564, 55000},
+	{573, 60000},
+	{581, 65000},
+	{590, 70000},
+	{599, 75000},
+	{607, 80000},
+	{616, 85000},
+	{624, 90000},
+	{633, 95000},
+	{642, 100000},
+	{650, 105000},
+	{659, 110000},
+	{668, 115000},
+	{677, 120000},
+	{685, 125000},
 	{TSADCV3_DATA_MASK, 125000},
 };
 
-- 
1.9.1
