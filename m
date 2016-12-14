From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 2/4] power: supply: axp288_fuel_gauge: Read 15 bit values 2 registers at a time
Date: Wed, 14 Dec 2016 17:38:51 +0100
Message-ID: <20161214163853.454-2-hdegoede@redhat.com>
References: <20161214163853.454-1-hdegoede@redhat.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:32926 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932979AbcLNQjE (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 14 Dec 2016 11:39:04 -0500
In-Reply-To: <20161214163853.454-1-hdegoede@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Chen-Yu Tsai <wens@csie.org>
Cc: "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, linux-pm@vger.kernel.org, linux-i2c@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>

In order for the MSB -> LSB latching to work correctly we must read the
2 8 bit registers of a 15 bit value in one consecutive read.

This fixes charge_full reporting 3498768 on some reads and 3354624 one
other reads on my tablet (for the 3354624 value the raw LSB is 0x00).

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/power/supply/axp288_fuel_gauge.c | 63 +++++++++++++++++---------------
 1 file changed, 34 insertions(+), 29 deletions(-)

diff --git a/drivers/power/supply/axp288_fuel_gauge.c b/drivers/power/supply/axp288_fuel_gauge.c
index f62f9df..99d6d30 100644
--- a/drivers/power/supply/axp288_fuel_gauge.c
+++ b/drivers/power/supply/axp288_fuel_gauge.c
@@ -29,6 +29,7 @@
 #include <linux/iio/consumer.h>
 #include <linux/debugfs.h>
 #include <linux/seq_file.h>
+#include <asm/unaligned.h>
 
 #define CHRG_STAT_BAT_SAFE_MODE		(1 << 3)
 #define CHRG_STAT_BAT_VALID			(1 << 4)
@@ -73,17 +74,15 @@
 #define FG_CNTL_CC_EN				(1 << 6)
 #define FG_CNTL_GAUGE_EN			(1 << 7)
 
+#define FG_15BIT_WORD_VALID			(1 << 15)
+#define FG_15BIT_VAL_MASK			0x7fff
+
 #define FG_REP_CAP_VALID			(1 << 7)
 #define FG_REP_CAP_VAL_MASK			0x7F
 
 #define FG_DES_CAP1_VALID			(1 << 7)
-#define FG_DES_CAP1_VAL_MASK		0x7F
-#define FG_DES_CAP0_VAL_MASK		0xFF
 #define FG_DES_CAP_RES_LSB			1456    /* 1.456mAhr */
 
-#define FG_CC_MTR1_VALID			(1 << 7)
-#define FG_CC_MTR1_VAL_MASK			0x7F
-#define FG_CC_MTR0_VAL_MASK			0xFF
 #define FG_DES_CC_RES_LSB			1456    /* 1.456mAhr */
 
 #define FG_OCV_CAP_VALID			(1 << 7)
@@ -189,6 +188,28 @@ static int fuel_gauge_reg_writeb(struct axp288_fg_info *info, int reg, u8 val)
 	return ret;
 }
 
+static int fuel_gauge_read_15bit_word(struct axp288_fg_info *info, int reg)
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
+	ret = get_unaligned_be16(buf);
+	if (!(ret & FG_15BIT_WORD_VALID)) {
+		dev_err(&info->pdev->dev, "Error reg 0x%02x contents not valid\n",
+			reg);
+		return -ENXIO;
+	}
+
+	return ret & FG_15BIT_VAL_MASK;
+}
+
 static int pmic_read_adc_val(const char *name, int *raw_val,
 		struct axp288_fg_info *info)
 {
@@ -255,18 +276,12 @@ static int fuel_gauge_debug_show(struct seq_file *s, void *data)
 	seq_printf(s, "    FG_OCVL[%02x] : %02x\n",
 		AXP288_FG_OCVL_REG,
 		fuel_gauge_reg_readb(info, AXP288_FG_OCVL_REG));
-	seq_printf(s, "FG_DES_CAP1[%02x] : %02x\n",
+	seq_printf(s, " FG_DES_CAP[%02x] : %04x\n",
 		AXP288_FG_DES_CAP1_REG,
-		fuel_gauge_reg_readb(info, AXP288_FG_DES_CAP1_REG));
-	seq_printf(s, "FG_DES_CAP0[%02x] : %02x\n",
-		AXP288_FG_DES_CAP0_REG,
-		fuel_gauge_reg_readb(info, AXP288_FG_DES_CAP0_REG));
-	seq_printf(s, " FG_CC_MTR1[%02x] : %02x\n",
+		fuel_gauge_read_15bit_word(info, AXP288_FG_DES_CAP1_REG));
+	seq_printf(s, "  FG_CC_MTR[%02x] : %04x\n",
 		AXP288_FG_CC_MTR1_REG,
-		fuel_gauge_reg_readb(info, AXP288_FG_CC_MTR1_REG));
-	seq_printf(s, " FG_CC_MTR0[%02x] : %02x\n",
-		AXP288_FG_CC_MTR0_REG,
-		fuel_gauge_reg_readb(info, AXP288_FG_CC_MTR0_REG));
+		fuel_gauge_read_15bit_word(info, AXP288_FG_CC_MTR1_REG));
 	seq_printf(s, " FG_OCV_CAP[%02x] : %02x\n",
 		AXP288_FG_OCV_CAP_REG,
 		fuel_gauge_reg_readb(info, AXP288_FG_OCV_CAP_REG));
@@ -663,28 +678,18 @@ static int fuel_gauge_get_property(struct power_supply *ps,
 		val->intval = POWER_SUPPLY_TECHNOLOGY_LION;
 		break;
 	case POWER_SUPPLY_PROP_CHARGE_NOW:
-		ret = fuel_gauge_reg_readb(info, AXP288_FG_CC_MTR1_REG);
+		ret = fuel_gauge_read_15bit_word(info, AXP288_FG_CC_MTR1_REG);
 		if (ret < 0)
 			goto fuel_gauge_read_err;
 
-		value = (ret & FG_CC_MTR1_VAL_MASK) << 8;
-		ret = fuel_gauge_reg_readb(info, AXP288_FG_CC_MTR0_REG);
-		if (ret < 0)
-			goto fuel_gauge_read_err;
-		value |= (ret & FG_CC_MTR0_VAL_MASK);
-		val->intval = value * FG_DES_CAP_RES_LSB;
+		val->intval = ret * FG_DES_CAP_RES_LSB;
 		break;
 	case POWER_SUPPLY_PROP_CHARGE_FULL:
-		ret = fuel_gauge_reg_readb(info, AXP288_FG_DES_CAP1_REG);
+		ret = fuel_gauge_read_15bit_word(info, AXP288_FG_DES_CAP1_REG);
 		if (ret < 0)
 			goto fuel_gauge_read_err;
 
-		value = (ret & FG_DES_CAP1_VAL_MASK) << 8;
-		ret = fuel_gauge_reg_readb(info, AXP288_FG_DES_CAP0_REG);
-		if (ret < 0)
-			goto fuel_gauge_read_err;
-		value |= (ret & FG_DES_CAP0_VAL_MASK);
-		val->intval = value * FG_DES_CAP_RES_LSB;
+		val->intval = ret * FG_DES_CAP_RES_LSB;
 		break;
 	case POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN:
 		val->intval = PROP_CURR(info->pdata->design_cap);
-- 
2.9.3

