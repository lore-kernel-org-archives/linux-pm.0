From: Caesar Wang <wxt@rock-chips.com>
Subject: [PATCH v4 06/10] thermal: rockchip: consistently use int for temperatures
Date: Mon,  9 Nov 2015 12:48:58 +0800
Message-ID: <1447044542-30859-7-git-send-email-wxt@rock-chips.com>
References: <1447044542-30859-1-git-send-email-wxt@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1447044542-30859-1-git-send-email-wxt@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Heiko Stuebner <heiko@sntech.de>, Eduardo Valentin <edubezval@gmail.com>
Cc: linux-rockchip@lists.infradead.org, lkp@intel.com, Caesar Wang <wxt@rock-chips.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

As Temperature is currently represented as int not long in the thermal
framework since use int intead of unsigned long/long to represent
temperature to avoid bogus overheat detection when negative temperature
reported.

Signed-off-by: Caesar Wang <wxt@rock-chips.com>

---

Changes in v4:
- fix the warning from the print message.

Changes in v3:
- As the Patch v2 comments, Add a new patch to fix it.

Changes in v2: None
Changes in v1: None

 drivers/thermal/rockchip_thermal.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
index 7c5b784..73d47f8 100644
--- a/drivers/thermal/rockchip_thermal.c
+++ b/drivers/thermal/rockchip_thermal.c
@@ -88,7 +88,7 @@ struct rockchip_tsadc_chip {
 	int chn_num;
 
 	/* The hardware-controlled tshut property */
-	long tshut_temp;
+	int tshut_temp;
 	enum tshut_mode tshut_mode;
 	enum tshut_polarity tshut_polarity;
 
@@ -101,7 +101,7 @@ struct rockchip_tsadc_chip {
 	int (*get_temp)(struct chip_tsadc_table table,
 			int chn, void __iomem *reg, int *temp);
 	void (*set_tshut_temp)(struct chip_tsadc_table table,
-			       int chn, void __iomem *reg, long temp);
+			       int chn, void __iomem *reg, int temp);
 	void (*set_tshut_mode)(int chn, void __iomem *reg, enum tshut_mode m);
 
 	/* Per-table methods */
@@ -126,7 +126,7 @@ struct rockchip_thermal_data {
 
 	void __iomem *regs;
 
-	long tshut_temp;
+	int tshut_temp;
 	enum tshut_mode tshut_mode;
 	enum tshut_polarity tshut_polarity;
 };
@@ -160,7 +160,7 @@ struct rockchip_thermal_data {
 
 struct tsadc_table {
 	u32 code;
-	long temp;
+	int temp;
 };
 
 static const struct tsadc_table v2_code_table[] = {
@@ -202,7 +202,7 @@ static const struct tsadc_table v2_code_table[] = {
 };
 
 static u32 rk_tsadcv2_temp_to_code(struct chip_tsadc_table table,
-				   long temp)
+				   int temp)
 {
 	int high, low, mid;
 
@@ -356,7 +356,7 @@ static int rk_tsadcv2_get_temp(struct chip_tsadc_table table,
 }
 
 static void rk_tsadcv2_tshut_temp(struct chip_tsadc_table table,
-				  int chn, void __iomem *regs, long temp)
+				  int chn, void __iomem *regs, int temp)
 {
 	u32 tshut_value, val;
 
@@ -469,7 +469,7 @@ static int rockchip_configure_from_dt(struct device *dev,
 
 	if (of_property_read_u32(np, "rockchip,hw-tshut-temp", &shut_temp)) {
 		dev_warn(dev,
-			 "Missing tshut temp property, using default %ld\n",
+			 "Missing tshut temp property, using default %d\n",
 			 thermal->chip->tshut_temp);
 		thermal->tshut_temp = thermal->chip->tshut_temp;
 	} else {
@@ -477,7 +477,7 @@ static int rockchip_configure_from_dt(struct device *dev,
 	}
 
 	if (thermal->tshut_temp > INT_MAX) {
-		dev_err(dev, "Invalid tshut temperature specified: %ld\n",
+		dev_err(dev, "Invalid tshut temperature specified: %d\n",
 			thermal->tshut_temp);
 		return -ERANGE;
 	}
-- 
1.9.1
