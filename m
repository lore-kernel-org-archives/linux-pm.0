From: "Andrew F. Davis" <afd@ti.com>
Subject: [PATCH 2/8] power: bq27x00_battery: Fix lines over 80 characters long
Date: Wed, 22 Jul 2015 16:51:54 -0500
Message-ID: <1437601920-13045-3-git-send-email-afd@ti.com>
References: <1437601920-13045-1-git-send-email-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1437601920-13045-1-git-send-email-afd@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Dan Murphy <dmurphy@ti.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, "Andrew F. Davis" <afd@ti.com>
List-Id: linux-pm@vger.kernel.org

Shorted lines over 80 characters long by reducing tab count.

Signed-off-by: Andrew F. Davis <afd@ti.com>
---
 drivers/power/bq27x00_battery.c | 74 ++++++++++++++++++++---------------------
 1 file changed, 37 insertions(+), 37 deletions(-)

diff --git a/drivers/power/bq27x00_battery.c b/drivers/power/bq27x00_battery.c
index 2257bd4..203cf61 100644
--- a/drivers/power/bq27x00_battery.c
+++ b/drivers/power/bq27x00_battery.c
@@ -39,49 +39,49 @@
 
 #include <linux/power/bq27x00_battery.h>
 
-#define DRIVER_VERSION			"1.2.0"
+#define DRIVER_VERSION		"1.2.0"
 
 #define BQ27XXX_MANUFACTURER	"Texas Instruments"
 
-#define BQ27x00_REG_TEMP		0x06
-#define BQ27x00_REG_VOLT		0x08
-#define BQ27x00_REG_AI			0x14
-#define BQ27x00_REG_FLAGS		0x0A
-#define BQ27x00_REG_TTE			0x16
-#define BQ27x00_REG_TTF			0x18
-#define BQ27x00_REG_TTECP		0x26
-#define BQ27x00_REG_NAC			0x0C /* Nominal available capacity */
-#define BQ27x00_REG_LMD			0x12 /* Last measured discharge */
-#define BQ27x00_REG_CYCT		0x2A /* Cycle count total */
-#define BQ27x00_REG_AE			0x22 /* Available energy */
-#define BQ27x00_POWER_AVG		0x24
-
-#define BQ27000_REG_RSOC		0x0B /* Relative State-of-Charge */
-#define BQ27000_REG_ILMD		0x76 /* Initial last measured discharge */
-#define BQ27000_FLAG_EDVF		BIT(0) /* Final End-of-Discharge-Voltage flag */
-#define BQ27000_FLAG_EDV1		BIT(1) /* First End-of-Discharge-Voltage flag */
-#define BQ27000_FLAG_CI			BIT(4) /* Capacity Inaccurate flag */
-#define BQ27000_FLAG_FC			BIT(5)
-#define BQ27000_FLAG_CHGS		BIT(7) /* Charge state flag */
-
-#define BQ27500_REG_SOC			0x2C
-#define BQ27500_REG_DCAP		0x3C /* Design capacity */
-#define BQ27500_FLAG_DSC		BIT(0)
-#define BQ27500_FLAG_SOCF		BIT(1) /* State-of-Charge threshold final */
-#define BQ27500_FLAG_SOC1		BIT(2) /* State-of-Charge threshold 1 */
-#define BQ27500_FLAG_FC			BIT(9)
-#define BQ27500_FLAG_OTC		BIT(15)
-
-#define BQ27742_POWER_AVG		0x76
-
-#define BQ27510_REG_SOC			0x20
-#define BQ27510_REG_DCAP		0x2E /* Design capacity */
-#define BQ27510_REG_CYCT		0x1E /* Cycle count total */
+#define BQ27x00_REG_TEMP	0x06
+#define BQ27x00_REG_VOLT	0x08
+#define BQ27x00_REG_AI		0x14
+#define BQ27x00_REG_FLAGS	0x0A
+#define BQ27x00_REG_TTE		0x16
+#define BQ27x00_REG_TTF		0x18
+#define BQ27x00_REG_TTECP	0x26
+#define BQ27x00_REG_NAC		0x0C /* Nominal available capacity */
+#define BQ27x00_REG_LMD		0x12 /* Last measured discharge */
+#define BQ27x00_REG_CYCT	0x2A /* Cycle count total */
+#define BQ27x00_REG_AE		0x22 /* Available energy */
+#define BQ27x00_POWER_AVG	0x24
+
+#define BQ27000_REG_RSOC	0x0B /* Relative State-of-Charge */
+#define BQ27000_REG_ILMD	0x76 /* Initial last measured discharge */
+#define BQ27000_FLAG_EDVF	BIT(0) /* Final End-of-Discharge-Voltage flag */
+#define BQ27000_FLAG_EDV1	BIT(1) /* First End-of-Discharge-Voltage flag */
+#define BQ27000_FLAG_CI		BIT(4) /* Capacity Inaccurate flag */
+#define BQ27000_FLAG_FC		BIT(5)
+#define BQ27000_FLAG_CHGS	BIT(7) /* Charge state flag */
+
+#define BQ27500_REG_SOC		0x2C
+#define BQ27500_REG_DCAP	0x3C /* Design capacity */
+#define BQ27500_FLAG_DSC	BIT(0)
+#define BQ27500_FLAG_SOCF	BIT(1) /* State-of-Charge threshold final */
+#define BQ27500_FLAG_SOC1	BIT(2) /* State-of-Charge threshold 1 */
+#define BQ27500_FLAG_FC		BIT(9)
+#define BQ27500_FLAG_OTC	BIT(15)
+
+#define BQ27742_POWER_AVG	0x76
+
+#define BQ27510_REG_SOC		0x20
+#define BQ27510_REG_DCAP	0x2E /* Design capacity */
+#define BQ27510_REG_CYCT	0x1E /* Cycle count total */
 
 /* bq27425 register addresses are same as bq27x00 addresses minus 4 */
-#define BQ27425_REG_OFFSET		0x04
+#define BQ27425_REG_OFFSET	0x04
 #define BQ27425_REG_SOC		(0x1C + BQ27425_REG_OFFSET)
-#define BQ27425_REG_DCAP		(0x3C + BQ27425_REG_OFFSET)
+#define BQ27425_REG_DCAP	(0x3C + BQ27425_REG_OFFSET)
 
 #define BQ27000_RS			20 /* Resistor sense */
 #define BQ27x00_POWER_CONSTANT		(256 * 29200 / 1000)
-- 
1.9.1
