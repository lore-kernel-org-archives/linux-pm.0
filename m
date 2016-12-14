From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 3/4] power: supply: axp288_fuel_gauge: Read 12 bit values 2 registers at a time
Date: Wed, 14 Dec 2016 17:38:52 +0100
Message-ID: <20161214163853.454-3-hdegoede@redhat.com>
References: <20161214163853.454-1-hdegoede@redhat.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
In-Reply-To: <20161214163853.454-1-hdegoede@redhat.com>
Sender: linux-i2c-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Chen-Yu Tsai <wens@csie.org>
Cc: "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, linux-pm@vger.kernel.org, linux-i2c@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>
List-Id: linux-pm@vger.kernel.org

In order for the MSB -> LSB latching to work correctly we must read the
2 8 bit registers of a 12 bit value in one consecutive read.

This fixes voltage_ocv reporting inconsistent values on my tablet.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/power/supply/axp288_fuel_gauge.c | 40 ++++++++++++++++++--------------
 1 file changed, 22 insertions(+), 18 deletions(-)

diff --git a/drivers/power/supply/axp288_fuel_gauge.c b/drivers/power/supply/axp288_fuel_gauge.c
index 99d6d30..089056c 100644
--- a/drivers/power/supply/axp288_fuel_gauge.c
+++ b/drivers/power/supply/axp288_fuel_gauge.c
@@ -210,6 +210,22 @@ static int fuel_gauge_read_15bit_word(struct axp288_fg_info *info, int reg)
 	return ret & FG_15BIT_VAL_MASK;
 }
 
+static int fuel_gauge_read_12bit_word(struct axp288_fg_info *info, int reg)
+{
+	unsigned char buf[2];
+	int ret;
+
+	ret = regmap_bulk_read(info->regmap, reg, buf, 2);
+	if (ret < 0) {
+		dev_err(&info->pdev->dev, "Error reading reg 0x%02x err: %d\n",
+			reg, ret);
+		return ret;
+	}
+
+	/* 12-bit data values have upper 8 bits in buf[0], lower 4 in buf[1] */
+	return (buf[0] << 4) | ((buf[1] >> 4) & 0x0f);
+}
+
 static int pmic_read_adc_val(const char *name, int *raw_val,
 		struct axp288_fg_info *info)
 {
@@ -270,12 +286,9 @@ static int fuel_gauge_debug_show(struct seq_file *s, void *data)
 	seq_printf(s, "    FG_RDC0[%02x] : %02x\n",
 		AXP288_FG_RDC0_REG,
 		fuel_gauge_reg_readb(info, AXP288_FG_RDC0_REG));
-	seq_printf(s, "    FG_OCVH[%02x] : %02x\n",
+	seq_printf(s, "     FG_OCV[%02x] : %04x\n",
 		AXP288_FG_OCVH_REG,
-		fuel_gauge_reg_readb(info, AXP288_FG_OCVH_REG));
-	seq_printf(s, "    FG_OCVL[%02x] : %02x\n",
-		AXP288_FG_OCVL_REG,
-		fuel_gauge_reg_readb(info, AXP288_FG_OCVL_REG));
+		fuel_gauge_read_12bit_word(info, AXP288_FG_OCVH_REG));
 	seq_printf(s, " FG_DES_CAP[%02x] : %04x\n",
 		AXP288_FG_DES_CAP1_REG,
 		fuel_gauge_read_15bit_word(info, AXP288_FG_DES_CAP1_REG));
@@ -532,21 +545,12 @@ static int fuel_gauge_get_btemp(struct axp288_fg_info *info, int *btemp)
 
 static int fuel_gauge_get_vocv(struct axp288_fg_info *info, int *vocv)
 {
-	int ret, value;
-
-	/* 12-bit data value, upper 8 in OCVH, lower 4 in OCVL */
-	ret = fuel_gauge_reg_readb(info, AXP288_FG_OCVH_REG);
-	if (ret < 0)
-		goto vocv_read_fail;
-	value = ret << 4;
+	int ret;
 
-	ret = fuel_gauge_reg_readb(info, AXP288_FG_OCVL_REG);
-	if (ret < 0)
-		goto vocv_read_fail;
-	value |= (ret & 0xf);
+	ret = fuel_gauge_read_12bit_word(info, AXP288_FG_OCVH_REG);
+	if (ret >= 0)
+		*vocv = VOLTAGE_FROM_ADC(ret);
 
-	*vocv = VOLTAGE_FROM_ADC(value);
-vocv_read_fail:
 	return ret;
 }
 
-- 
2.9.3
