From: "Andrew F. Davis" <afd@ti.com>
Subject: [PATCH v2 3/3] power_supply: bq27xxx_battery: Group register mappings into one table
Date: Fri, 17 Jun 2016 17:02:35 -0500
Message-ID: <20160617220235.24991-3-afd@ti.com>
References: <20160617220235.24991-1-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([198.47.19.11]:60444 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751162AbcFQWCk (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 17 Jun 2016 18:02:40 -0400
In-Reply-To: <20160617220235.24991-1-afd@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, "Andrew F . Davis" <afd@ti.com>

Currently for each device with a unique register map we have a named
array that we then merge into a multidimensional array. Skip this
middle step and apply the register arrays directly to the multi-array.

Signed-off-by: Andrew F. Davis <afd@ti.com>
---
 drivers/power/bq27xxx_battery.c | 284 +++++++++++++++++++---------------------
 1 file changed, 136 insertions(+), 148 deletions(-)

diff --git a/drivers/power/bq27xxx_battery.c b/drivers/power/bq27xxx_battery.c
index 01737fa..b073338 100644
--- a/drivers/power/bq27xxx_battery.c
+++ b/drivers/power/bq27xxx_battery.c
@@ -82,6 +82,7 @@
  *
  * These are indexes into a device's register mapping array.
  */
+
 enum bq27xxx_reg_index {
 	BQ27XXX_REG_CTRL = 0,	/* Control */
 	BQ27XXX_REG_TEMP,	/* Temperature */
@@ -100,157 +101,144 @@ enum bq27xxx_reg_index {
 	BQ27XXX_REG_SOC,	/* State-of-Charge */
 	BQ27XXX_REG_DCAP,	/* Design Capacity */
 	BQ27XXX_REG_AP,		/* Average Power */
+	BQ27XXX_REG_MAX,	/* sentinel */
 };
 
 /* Register mappings */
-static u8 bq27000_regs[] = {
-	[BQ27XXX_REG_CTRL] = 0x00,
-	[BQ27XXX_REG_TEMP] = 0x06,
-	[BQ27XXX_REG_INT_TEMP] = INVALID_REG_ADDR,
-	[BQ27XXX_REG_VOLT] = 0x08,
-	[BQ27XXX_REG_AI] = 0x14,
-	[BQ27XXX_REG_FLAGS] = 0x0a,
-	[BQ27XXX_REG_TTE] = 0x16,
-	[BQ27XXX_REG_TTF] = 0x18,
-	[BQ27XXX_REG_TTES] = 0x1c,
-	[BQ27XXX_REG_TTECP] = 0x26,
-	[BQ27XXX_REG_NAC] = 0x0c,
-	[BQ27XXX_REG_FCC] = 0x12,
-	[BQ27XXX_REG_CYCT] = 0x2a,
-	[BQ27XXX_REG_AE] = 0x22,
-	[BQ27XXX_REG_SOC] = 0x0b,
-	[BQ27XXX_REG_DCAP] = 0x76,
-	[BQ27XXX_REG_AP] = 0x24,
-};
-
-static u8 bq27010_regs[] = {
-	[BQ27XXX_REG_CTRL] = 0x00,
-	[BQ27XXX_REG_TEMP] = 0x06,
-	[BQ27XXX_REG_INT_TEMP] = INVALID_REG_ADDR,
-	[BQ27XXX_REG_VOLT] = 0x08,
-	[BQ27XXX_REG_AI] = 0x14,
-	[BQ27XXX_REG_FLAGS] = 0x0a,
-	[BQ27XXX_REG_TTE] = 0x16,
-	[BQ27XXX_REG_TTF] = 0x18,
-	[BQ27XXX_REG_TTES] = 0x1c,
-	[BQ27XXX_REG_TTECP] = 0x26,
-	[BQ27XXX_REG_NAC] = 0x0c,
-	[BQ27XXX_REG_FCC] = 0x12,
-	[BQ27XXX_REG_CYCT] = 0x2a,
-	[BQ27XXX_REG_AE] = INVALID_REG_ADDR,
-	[BQ27XXX_REG_SOC] = 0x0b,
-	[BQ27XXX_REG_DCAP] = 0x76,
-	[BQ27XXX_REG_AP] = INVALID_REG_ADDR,
-};
-
-static u8 bq27500_regs[] = {
-	[BQ27XXX_REG_CTRL] = 0x00,
-	[BQ27XXX_REG_TEMP] = 0x06,
-	[BQ27XXX_REG_INT_TEMP] = 0x28,
-	[BQ27XXX_REG_VOLT] = 0x08,
-	[BQ27XXX_REG_AI] = 0x14,
-	[BQ27XXX_REG_FLAGS] = 0x0a,
-	[BQ27XXX_REG_TTE] = 0x16,
-	[BQ27XXX_REG_TTF] = INVALID_REG_ADDR,
-	[BQ27XXX_REG_TTES] = 0x1a,
-	[BQ27XXX_REG_TTECP] = INVALID_REG_ADDR,
-	[BQ27XXX_REG_NAC] = 0x0c,
-	[BQ27XXX_REG_FCC] = 0x12,
-	[BQ27XXX_REG_CYCT] = 0x2a,
-	[BQ27XXX_REG_AE] = INVALID_REG_ADDR,
-	[BQ27XXX_REG_SOC] = 0x2c,
-	[BQ27XXX_REG_DCAP] = 0x3c,
-	[BQ27XXX_REG_AP] = INVALID_REG_ADDR,
-};
-
-static u8 bq27530_regs[] = {
-	[BQ27XXX_REG_CTRL] = 0x00,
-	[BQ27XXX_REG_TEMP] = 0x06,
-	[BQ27XXX_REG_INT_TEMP] = 0x32,
-	[BQ27XXX_REG_VOLT] = 0x08,
-	[BQ27XXX_REG_AI] = 0x14,
-	[BQ27XXX_REG_FLAGS] = 0x0a,
-	[BQ27XXX_REG_TTE] = 0x16,
-	[BQ27XXX_REG_TTF] = INVALID_REG_ADDR,
-	[BQ27XXX_REG_TTES] = INVALID_REG_ADDR,
-	[BQ27XXX_REG_TTECP] = INVALID_REG_ADDR,
-	[BQ27XXX_REG_NAC] = 0x0c,
-	[BQ27XXX_REG_FCC] = 0x12,
-	[BQ27XXX_REG_CYCT] = 0x2a,
-	[BQ27XXX_REG_AE] = INVALID_REG_ADDR,
-	[BQ27XXX_REG_SOC] = 0x2c,
-	[BQ27XXX_REG_DCAP] = INVALID_REG_ADDR,
-	[BQ27XXX_REG_AP] = 0x24,
-};
-
-static u8 bq27541_regs[] = {
-	[BQ27XXX_REG_CTRL] = 0x00,
-	[BQ27XXX_REG_TEMP] = 0x06,
-	[BQ27XXX_REG_INT_TEMP] = 0x28,
-	[BQ27XXX_REG_VOLT] = 0x08,
-	[BQ27XXX_REG_AI] = 0x14,
-	[BQ27XXX_REG_FLAGS] = 0x0a,
-	[BQ27XXX_REG_TTE] = 0x16,
-	[BQ27XXX_REG_TTF] = INVALID_REG_ADDR,
-	[BQ27XXX_REG_TTES] = INVALID_REG_ADDR,
-	[BQ27XXX_REG_TTECP] = INVALID_REG_ADDR,
-	[BQ27XXX_REG_NAC] = 0x0c,
-	[BQ27XXX_REG_FCC] = 0x12,
-	[BQ27XXX_REG_CYCT] = 0x2a,
-	[BQ27XXX_REG_AE] = INVALID_REG_ADDR,
-	[BQ27XXX_REG_SOC] = 0x2c,
-	[BQ27XXX_REG_DCAP] = 0x3c,
-	[BQ27XXX_REG_AP] = 0x24,
-};
-
-static u8 bq27545_regs[] = {
-	[BQ27XXX_REG_CTRL] = 0x00,
-	[BQ27XXX_REG_TEMP] = 0x06,
-	[BQ27XXX_REG_INT_TEMP] = 0x28,
-	[BQ27XXX_REG_VOLT] = 0x08,
-	[BQ27XXX_REG_AI] = 0x14,
-	[BQ27XXX_REG_FLAGS] = 0x0a,
-	[BQ27XXX_REG_TTE] = 0x16,
-	[BQ27XXX_REG_TTF] = INVALID_REG_ADDR,
-	[BQ27XXX_REG_TTES] = INVALID_REG_ADDR,
-	[BQ27XXX_REG_TTECP] = INVALID_REG_ADDR,
-	[BQ27XXX_REG_NAC] = 0x0c,
-	[BQ27XXX_REG_FCC] = 0x12,
-	[BQ27XXX_REG_CYCT] = 0x2a,
-	[BQ27XXX_REG_AE] = INVALID_REG_ADDR,
-	[BQ27XXX_REG_SOC] = 0x2c,
-	[BQ27XXX_REG_DCAP] = INVALID_REG_ADDR,
-	[BQ27XXX_REG_AP] = 0x24,
-};
-
-static u8 bq27421_regs[] = {
-	[BQ27XXX_REG_CTRL] = 0x00,
-	[BQ27XXX_REG_TEMP] = 0x02,
-	[BQ27XXX_REG_INT_TEMP] = 0x1e,
-	[BQ27XXX_REG_VOLT] = 0x04,
-	[BQ27XXX_REG_AI] = 0x10,
-	[BQ27XXX_REG_FLAGS] = 0x06,
-	[BQ27XXX_REG_TTE] = INVALID_REG_ADDR,
-	[BQ27XXX_REG_TTF] = INVALID_REG_ADDR,
-	[BQ27XXX_REG_TTES] = INVALID_REG_ADDR,
-	[BQ27XXX_REG_TTECP] = INVALID_REG_ADDR,
-	[BQ27XXX_REG_NAC] = 0x08,
-	[BQ27XXX_REG_FCC] = 0x0e,
-	[BQ27XXX_REG_CYCT] = INVALID_REG_ADDR,
-	[BQ27XXX_REG_AE] = INVALID_REG_ADDR,
-	[BQ27XXX_REG_SOC] = 0x1c,
-	[BQ27XXX_REG_DCAP] = 0x3c,
-	[BQ27XXX_REG_AP] = 0x18,
-};
-
-static u8 *bq27xxx_regs[] = {
-	[BQ27000] = bq27000_regs,
-	[BQ27010] = bq27010_regs,
-	[BQ27500] = bq27500_regs,
-	[BQ27530] = bq27530_regs,
-	[BQ27541] = bq27541_regs,
-	[BQ27545] = bq27545_regs,
-	[BQ27421] = bq27421_regs,
+static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] = {
+	[BQ27000] = {
+		[BQ27XXX_REG_CTRL] = 0x00,
+		[BQ27XXX_REG_TEMP] = 0x06,
+		[BQ27XXX_REG_INT_TEMP] = INVALID_REG_ADDR,
+		[BQ27XXX_REG_VOLT] = 0x08,
+		[BQ27XXX_REG_AI] = 0x14,
+		[BQ27XXX_REG_FLAGS] = 0x0a,
+		[BQ27XXX_REG_TTE] = 0x16,
+		[BQ27XXX_REG_TTF] = 0x18,
+		[BQ27XXX_REG_TTES] = 0x1c,
+		[BQ27XXX_REG_TTECP] = 0x26,
+		[BQ27XXX_REG_NAC] = 0x0c,
+		[BQ27XXX_REG_FCC] = 0x12,
+		[BQ27XXX_REG_CYCT] = 0x2a,
+		[BQ27XXX_REG_AE] = 0x22,
+		[BQ27XXX_REG_SOC] = 0x0b,
+		[BQ27XXX_REG_DCAP] = 0x76,
+		[BQ27XXX_REG_AP] = 0x24,
+	},
+	[BQ27010] = {
+		[BQ27XXX_REG_CTRL] = 0x00,
+		[BQ27XXX_REG_TEMP] = 0x06,
+		[BQ27XXX_REG_INT_TEMP] = INVALID_REG_ADDR,
+		[BQ27XXX_REG_VOLT] = 0x08,
+		[BQ27XXX_REG_AI] = 0x14,
+		[BQ27XXX_REG_FLAGS] = 0x0a,
+		[BQ27XXX_REG_TTE] = 0x16,
+		[BQ27XXX_REG_TTF] = 0x18,
+		[BQ27XXX_REG_TTES] = 0x1c,
+		[BQ27XXX_REG_TTECP] = 0x26,
+		[BQ27XXX_REG_NAC] = 0x0c,
+		[BQ27XXX_REG_FCC] = 0x12,
+		[BQ27XXX_REG_CYCT] = 0x2a,
+		[BQ27XXX_REG_AE] = INVALID_REG_ADDR,
+		[BQ27XXX_REG_SOC] = 0x0b,
+		[BQ27XXX_REG_DCAP] = 0x76,
+		[BQ27XXX_REG_AP] = INVALID_REG_ADDR,
+	},
+	[BQ27500] = {
+		[BQ27XXX_REG_CTRL] = 0x00,
+		[BQ27XXX_REG_TEMP] = 0x06,
+		[BQ27XXX_REG_INT_TEMP] = 0x28,
+		[BQ27XXX_REG_VOLT] = 0x08,
+		[BQ27XXX_REG_AI] = 0x14,
+		[BQ27XXX_REG_FLAGS] = 0x0a,
+		[BQ27XXX_REG_TTE] = 0x16,
+		[BQ27XXX_REG_TTF] = INVALID_REG_ADDR,
+		[BQ27XXX_REG_TTES] = 0x1a,
+		[BQ27XXX_REG_TTECP] = INVALID_REG_ADDR,
+		[BQ27XXX_REG_NAC] = 0x0c,
+		[BQ27XXX_REG_FCC] = 0x12,
+		[BQ27XXX_REG_CYCT] = 0x2a,
+		[BQ27XXX_REG_AE] = INVALID_REG_ADDR,
+		[BQ27XXX_REG_SOC] = 0x2c,
+		[BQ27XXX_REG_DCAP] = 0x3c,
+		[BQ27XXX_REG_AP] = INVALID_REG_ADDR,
+	},
+	[BQ27530] = {
+		[BQ27XXX_REG_CTRL] = 0x00,
+		[BQ27XXX_REG_TEMP] = 0x06,
+		[BQ27XXX_REG_INT_TEMP] = 0x32,
+		[BQ27XXX_REG_VOLT] = 0x08,
+		[BQ27XXX_REG_AI] = 0x14,
+		[BQ27XXX_REG_FLAGS] = 0x0a,
+		[BQ27XXX_REG_TTE] = 0x16,
+		[BQ27XXX_REG_TTF] = INVALID_REG_ADDR,
+		[BQ27XXX_REG_TTES] = INVALID_REG_ADDR,
+		[BQ27XXX_REG_TTECP] = INVALID_REG_ADDR,
+		[BQ27XXX_REG_NAC] = 0x0c,
+		[BQ27XXX_REG_FCC] = 0x12,
+		[BQ27XXX_REG_CYCT] = 0x2a,
+		[BQ27XXX_REG_AE] = INVALID_REG_ADDR,
+		[BQ27XXX_REG_SOC] = 0x2c,
+		[BQ27XXX_REG_DCAP] = INVALID_REG_ADDR,
+		[BQ27XXX_REG_AP] = 0x24,
+	},
+	[BQ27541] = {
+		[BQ27XXX_REG_CTRL] = 0x00,
+		[BQ27XXX_REG_TEMP] = 0x06,
+		[BQ27XXX_REG_INT_TEMP] = 0x28,
+		[BQ27XXX_REG_VOLT] = 0x08,
+		[BQ27XXX_REG_AI] = 0x14,
+		[BQ27XXX_REG_FLAGS] = 0x0a,
+		[BQ27XXX_REG_TTE] = 0x16,
+		[BQ27XXX_REG_TTF] = INVALID_REG_ADDR,
+		[BQ27XXX_REG_TTES] = INVALID_REG_ADDR,
+		[BQ27XXX_REG_TTECP] = INVALID_REG_ADDR,
+		[BQ27XXX_REG_NAC] = 0x0c,
+		[BQ27XXX_REG_FCC] = 0x12,
+		[BQ27XXX_REG_CYCT] = 0x2a,
+		[BQ27XXX_REG_AE] = INVALID_REG_ADDR,
+		[BQ27XXX_REG_SOC] = 0x2c,
+		[BQ27XXX_REG_DCAP] = 0x3c,
+		[BQ27XXX_REG_AP] = 0x24,
+	},
+	[BQ27545] = {
+		[BQ27XXX_REG_CTRL] = 0x00,
+		[BQ27XXX_REG_TEMP] = 0x06,
+		[BQ27XXX_REG_INT_TEMP] = 0x28,
+		[BQ27XXX_REG_VOLT] = 0x08,
+		[BQ27XXX_REG_AI] = 0x14,
+		[BQ27XXX_REG_FLAGS] = 0x0a,
+		[BQ27XXX_REG_TTE] = 0x16,
+		[BQ27XXX_REG_TTF] = INVALID_REG_ADDR,
+		[BQ27XXX_REG_TTES] = INVALID_REG_ADDR,
+		[BQ27XXX_REG_TTECP] = INVALID_REG_ADDR,
+		[BQ27XXX_REG_NAC] = 0x0c,
+		[BQ27XXX_REG_FCC] = 0x12,
+		[BQ27XXX_REG_CYCT] = 0x2a,
+		[BQ27XXX_REG_AE] = INVALID_REG_ADDR,
+		[BQ27XXX_REG_SOC] = 0x2c,
+		[BQ27XXX_REG_DCAP] = INVALID_REG_ADDR,
+		[BQ27XXX_REG_AP] = 0x24,
+	},
+	[BQ27421] = {
+		[BQ27XXX_REG_CTRL] = 0x00,
+		[BQ27XXX_REG_TEMP] = 0x02,
+		[BQ27XXX_REG_INT_TEMP] = 0x1e,
+		[BQ27XXX_REG_VOLT] = 0x04,
+		[BQ27XXX_REG_AI] = 0x10,
+		[BQ27XXX_REG_FLAGS] = 0x06,
+		[BQ27XXX_REG_TTE] = INVALID_REG_ADDR,
+		[BQ27XXX_REG_TTF] = INVALID_REG_ADDR,
+		[BQ27XXX_REG_TTES] = INVALID_REG_ADDR,
+		[BQ27XXX_REG_TTECP] = INVALID_REG_ADDR,
+		[BQ27XXX_REG_NAC] = 0x08,
+		[BQ27XXX_REG_FCC] = 0x0e,
+		[BQ27XXX_REG_CYCT] = INVALID_REG_ADDR,
+		[BQ27XXX_REG_AE] = INVALID_REG_ADDR,
+		[BQ27XXX_REG_SOC] = 0x1c,
+		[BQ27XXX_REG_DCAP] = 0x3c,
+		[BQ27XXX_REG_AP] = 0x18,
+	},
 };
 
 static enum power_supply_property bq27000_battery_props[] = {
-- 
2.9.0

