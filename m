From: Priit Laes <plaes@plaes.org>
Subject: [PATCH 14/14] power: supply: axp288: use the BIT() macro
Date: Mon, 26 Nov 2018 17:27:55 +0200
Message-ID: <c500c452040428a2a5fae32c48c9ba778df9fb17.1543245984.git-series.plaes@plaes.org>
References: <cover.156212c9c5df493e098556cad9793a07dcab5e32.1543245984.git-series.plaes@plaes.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.156212c9c5df493e098556cad9793a07dcab5e32.1543245984.git-series.plaes@plaes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <maxime.ripard@bootlin.com>, Sebastian Reichel <sre@kernel.org>, Hans de Goede <hdegoede@redhat.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Cc: Priit Laes <plaes@plaes.org>, Olliver Schinagl <oliver@schinagl.nl>
List-Id: linux-pm@vger.kernel.org

From: Olliver Schinagl <oliver@schinagl.nl>

Make use of the recommended BIT() macro for bit defines.

Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
Signed-off-by: Priit Laes <plaes@plaes.org>
---
 drivers/power/supply/axp288_charger.c | 35 ++++++++++++++--------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/drivers/power/supply/axp288_charger.c b/drivers/power/supply/axp288_charger.c
index 735658e..f8c6da9 100644
--- a/drivers/power/supply/axp288_charger.c
+++ b/drivers/power/supply/axp288_charger.c
@@ -16,6 +16,7 @@
  */
 
 #include <linux/acpi.h>
+#include <linux/bitops.h>
 #include <linux/module.h>
 #include <linux/device.h>
 #include <linux/regmap.h>
@@ -29,17 +30,17 @@
 #include <linux/mfd/axp20x.h>
 #include <linux/extcon.h>
 
-#define PS_STAT_VBUS_TRIGGER		(1 << 0)
-#define PS_STAT_BAT_CHRG_DIR		(1 << 2)
-#define PS_STAT_VBAT_ABOVE_VHOLD	(1 << 3)
-#define PS_STAT_VBUS_VALID		(1 << 4)
-#define PS_STAT_VBUS_PRESENT		(1 << 5)
+#define PS_STAT_VBUS_TRIGGER		BIT(0)
+#define PS_STAT_BAT_CHRG_DIR		BIT(2)
+#define PS_STAT_VBAT_ABOVE_VHOLD	BIT(3)
+#define PS_STAT_VBUS_VALID		BIT(4)
+#define PS_STAT_VBUS_PRESENT		BIT(5)
 
-#define CHRG_STAT_BAT_SAFE_MODE		(1 << 3)
-#define CHRG_STAT_BAT_VALID		(1 << 4)
-#define CHRG_STAT_BAT_PRESENT		(1 << 5)
-#define CHRG_STAT_CHARGING		(1 << 6)
-#define CHRG_STAT_PMIC_OTP		(1 << 7)
+#define CHRG_STAT_BAT_SAFE_MODE		BIT(3)
+#define CHRG_STAT_BAT_VALID		BIT(4)
+#define CHRG_STAT_BAT_PRESENT		BIT(5)
+#define CHRG_STAT_CHARGING		BIT(6)
+#define CHRG_STAT_PMIC_OTP		BIT(7)
 
 #define VBUS_ISPOUT_CUR_LIM_MASK	0x03
 #define VBUS_ISPOUT_CUR_LIM_BIT_POS	0
@@ -52,33 +53,33 @@
 #define VBUS_ISPOUT_VHOLD_SET_OFFSET	4000	/* 4000mV */
 #define VBUS_ISPOUT_VHOLD_SET_LSB_RES	100	/* 100mV */
 #define VBUS_ISPOUT_VHOLD_SET_4300MV	0x3	/* 4300mV */
-#define VBUS_ISPOUT_VBUS_PATH_DIS	(1 << 7)
+#define VBUS_ISPOUT_VBUS_PATH_DIS	BIT(7)
 
 #define CHRG_CCCV_CC_MASK		0xf		/* 4 bits */
 #define CHRG_CCCV_CC_BIT_POS		0
 #define CHRG_CCCV_CC_OFFSET		200		/* 200mA */
 #define CHRG_CCCV_CC_LSB_RES		200		/* 200mA */
-#define CHRG_CCCV_ITERM_20P		(1 << 4)	/* 20% of CC */
+#define CHRG_CCCV_ITERM_20P		BIT(4)		/* 20% of CC */
 #define CHRG_CCCV_CV_MASK		0x60		/* 2 bits */
 #define CHRG_CCCV_CV_BIT_POS		5
 #define CHRG_CCCV_CV_4100MV		0x0		/* 4.10V */
 #define CHRG_CCCV_CV_4150MV		0x1		/* 4.15V */
 #define CHRG_CCCV_CV_4200MV		0x2		/* 4.20V */
 #define CHRG_CCCV_CV_4350MV		0x3		/* 4.35V */
-#define CHRG_CCCV_CHG_EN		(1 << 7)
+#define CHRG_CCCV_CHG_EN		BIT(7)
 
 #define CNTL2_CC_TIMEOUT_MASK		0x3	/* 2 bits */
 #define CNTL2_CC_TIMEOUT_OFFSET		6	/* 6 Hrs */
 #define CNTL2_CC_TIMEOUT_LSB_RES	2	/* 2 Hrs */
 #define CNTL2_CC_TIMEOUT_12HRS		0x3	/* 12 Hrs */
-#define CNTL2_CHGLED_TYPEB		(1 << 4)
-#define CNTL2_CHG_OUT_TURNON		(1 << 5)
+#define CNTL2_CHGLED_TYPEB		BIT(4)
+#define CNTL2_CHG_OUT_TURNON		BIT(5)
 #define CNTL2_PC_TIMEOUT_MASK		0xC0
 #define CNTL2_PC_TIMEOUT_OFFSET		40	/* 40 mins */
 #define CNTL2_PC_TIMEOUT_LSB_RES	10	/* 10 mins */
 #define CNTL2_PC_TIMEOUT_70MINS		0x3
 
-#define CHRG_ILIM_TEMP_LOOP_EN		(1 << 3)
+#define CHRG_ILIM_TEMP_LOOP_EN		BIT(3)
 #define CHRG_VBUS_ILIM_MASK		0xf0
 #define CHRG_VBUS_ILIM_BIT_POS		4
 #define CHRG_VBUS_ILIM_100MA		0x0	/* 100mA */
@@ -94,7 +95,7 @@
 #define CHRG_VLTFC_0C			0xA5	/* 0 DegC */
 #define CHRG_VHTFC_45C			0x1F	/* 45 DegC */
 
-#define FG_CNTL_OCV_ADJ_EN		(1 << 3)
+#define FG_CNTL_OCV_ADJ_EN		BIT(3)
 
 #define CV_4100MV			4100	/* 4100mV */
 #define CV_4150MV			4150	/* 4150mV */
-- 
git-series 0.9.1
