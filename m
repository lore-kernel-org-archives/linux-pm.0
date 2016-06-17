From: "Andrew F. Davis" <afd@ti.com>
Subject: [PATCH v2 2/3] power_supply: bq27xxx_battery: Index register numbers by enum
Date: Fri, 17 Jun 2016 17:02:34 -0500
Message-ID: <20160617220235.24991-2-afd@ti.com>
References: <20160617220235.24991-1-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160617220235.24991-1-afd@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, "Andrew F . Davis" <afd@ti.com>
List-Id: linux-pm@vger.kernel.org

Currently we use tables to map from register function to register number,
these tables assume the enum used to describe the register function
and index the register number is ordered to match the enum order. Index
the register numbers by the enum instead. This also removes the need
to comment each value with its function.

Signed-off-by: Andrew F. Davis <afd@ti.com>
---
 drivers/power/bq27xxx_battery.c | 238 ++++++++++++++++++++--------------------
 1 file changed, 119 insertions(+), 119 deletions(-)

diff --git a/drivers/power/bq27xxx_battery.c b/drivers/power/bq27xxx_battery.c
index 45f6ebf..01737fa 100644
--- a/drivers/power/bq27xxx_battery.c
+++ b/drivers/power/bq27xxx_battery.c
@@ -104,143 +104,143 @@ enum bq27xxx_reg_index {
 
 /* Register mappings */
 static u8 bq27000_regs[] = {
-	0x00,	/* CONTROL	*/
-	0x06,	/* TEMP		*/
-	INVALID_REG_ADDR,	/* INT TEMP - NA*/
-	0x08,	/* VOLT		*/
-	0x14,	/* AVG CURR	*/
-	0x0a,	/* FLAGS	*/
-	0x16,	/* TTE		*/
-	0x18,	/* TTF		*/
-	0x1c,	/* TTES		*/
-	0x26,	/* TTECP	*/
-	0x0c,	/* NAC		*/
-	0x12,	/* LMD(FCC)	*/
-	0x2a,	/* CYCT		*/
-	0x22,	/* AE		*/
-	0x0b,	/* SOC(RSOC)	*/
-	0x76,	/* DCAP(ILMD)	*/
-	0x24,	/* AP		*/
+	[BQ27XXX_REG_CTRL] = 0x00,
+	[BQ27XXX_REG_TEMP] = 0x06,
+	[BQ27XXX_REG_INT_TEMP] = INVALID_REG_ADDR,
+	[BQ27XXX_REG_VOLT] = 0x08,
+	[BQ27XXX_REG_AI] = 0x14,
+	[BQ27XXX_REG_FLAGS] = 0x0a,
+	[BQ27XXX_REG_TTE] = 0x16,
+	[BQ27XXX_REG_TTF] = 0x18,
+	[BQ27XXX_REG_TTES] = 0x1c,
+	[BQ27XXX_REG_TTECP] = 0x26,
+	[BQ27XXX_REG_NAC] = 0x0c,
+	[BQ27XXX_REG_FCC] = 0x12,
+	[BQ27XXX_REG_CYCT] = 0x2a,
+	[BQ27XXX_REG_AE] = 0x22,
+	[BQ27XXX_REG_SOC] = 0x0b,
+	[BQ27XXX_REG_DCAP] = 0x76,
+	[BQ27XXX_REG_AP] = 0x24,
 };
 
 static u8 bq27010_regs[] = {
-	0x00,	/* CONTROL	*/
-	0x06,	/* TEMP		*/
-	INVALID_REG_ADDR,	/* INT TEMP - NA*/
-	0x08,	/* VOLT		*/
-	0x14,	/* AVG CURR	*/
-	0x0a,	/* FLAGS	*/
-	0x16,	/* TTE		*/
-	0x18,	/* TTF		*/
-	0x1c,	/* TTES		*/
-	0x26,	/* TTECP	*/
-	0x0c,	/* NAC		*/
-	0x12,	/* LMD(FCC)	*/
-	0x2a,	/* CYCT		*/
-	INVALID_REG_ADDR,	/* AE - NA	*/
-	0x0b,	/* SOC(RSOC)	*/
-	0x76,	/* DCAP(ILMD)	*/
-	INVALID_REG_ADDR,	/* AP - NA	*/
+	[BQ27XXX_REG_CTRL] = 0x00,
+	[BQ27XXX_REG_TEMP] = 0x06,
+	[BQ27XXX_REG_INT_TEMP] = INVALID_REG_ADDR,
+	[BQ27XXX_REG_VOLT] = 0x08,
+	[BQ27XXX_REG_AI] = 0x14,
+	[BQ27XXX_REG_FLAGS] = 0x0a,
+	[BQ27XXX_REG_TTE] = 0x16,
+	[BQ27XXX_REG_TTF] = 0x18,
+	[BQ27XXX_REG_TTES] = 0x1c,
+	[BQ27XXX_REG_TTECP] = 0x26,
+	[BQ27XXX_REG_NAC] = 0x0c,
+	[BQ27XXX_REG_FCC] = 0x12,
+	[BQ27XXX_REG_CYCT] = 0x2a,
+	[BQ27XXX_REG_AE] = INVALID_REG_ADDR,
+	[BQ27XXX_REG_SOC] = 0x0b,
+	[BQ27XXX_REG_DCAP] = 0x76,
+	[BQ27XXX_REG_AP] = INVALID_REG_ADDR,
 };
 
 static u8 bq27500_regs[] = {
-	0x00,	/* CONTROL	*/
-	0x06,	/* TEMP		*/
-	0x28,	/* INT TEMP	*/
-	0x08,	/* VOLT		*/
-	0x14,	/* AVG CURR	*/
-	0x0a,	/* FLAGS	*/
-	0x16,	/* TTE		*/
-	INVALID_REG_ADDR,	/* TTF - NA	*/
-	0x1a,	/* TTES		*/
-	INVALID_REG_ADDR,	/* TTECP - NA	*/
-	0x0c,	/* NAC		*/
-	0x12,	/* LMD(FCC)	*/
-	0x2a,	/* CYCT		*/
-	INVALID_REG_ADDR,	/* AE - NA	*/
-	0x2c,	/* SOC(RSOC)	*/
-	0x3c,	/* DCAP(ILMD)	*/
-	INVALID_REG_ADDR,	/* AP - NA	*/
+	[BQ27XXX_REG_CTRL] = 0x00,
+	[BQ27XXX_REG_TEMP] = 0x06,
+	[BQ27XXX_REG_INT_TEMP] = 0x28,
+	[BQ27XXX_REG_VOLT] = 0x08,
+	[BQ27XXX_REG_AI] = 0x14,
+	[BQ27XXX_REG_FLAGS] = 0x0a,
+	[BQ27XXX_REG_TTE] = 0x16,
+	[BQ27XXX_REG_TTF] = INVALID_REG_ADDR,
+	[BQ27XXX_REG_TTES] = 0x1a,
+	[BQ27XXX_REG_TTECP] = INVALID_REG_ADDR,
+	[BQ27XXX_REG_NAC] = 0x0c,
+	[BQ27XXX_REG_FCC] = 0x12,
+	[BQ27XXX_REG_CYCT] = 0x2a,
+	[BQ27XXX_REG_AE] = INVALID_REG_ADDR,
+	[BQ27XXX_REG_SOC] = 0x2c,
+	[BQ27XXX_REG_DCAP] = 0x3c,
+	[BQ27XXX_REG_AP] = INVALID_REG_ADDR,
 };
 
 static u8 bq27530_regs[] = {
-	0x00,	/* CONTROL	*/
-	0x06,	/* TEMP		*/
-	0x32,	/* INT TEMP	*/
-	0x08,	/* VOLT		*/
-	0x14,	/* AVG CURR	*/
-	0x0a,	/* FLAGS	*/
-	0x16,	/* TTE		*/
-	INVALID_REG_ADDR,	/* TTF - NA	*/
-	INVALID_REG_ADDR,	/* TTES - NA	*/
-	INVALID_REG_ADDR,	/* TTECP - NA	*/
-	0x0c,	/* NAC		*/
-	0x12,	/* LMD(FCC)	*/
-	0x2a,	/* CYCT		*/
-	INVALID_REG_ADDR,	/* AE - NA	*/
-	0x2c,	/* SOC(RSOC)	*/
-	INVALID_REG_ADDR,	/* DCAP - NA	*/
-	0x24,	/* AP		*/
+	[BQ27XXX_REG_CTRL] = 0x00,
+	[BQ27XXX_REG_TEMP] = 0x06,
+	[BQ27XXX_REG_INT_TEMP] = 0x32,
+	[BQ27XXX_REG_VOLT] = 0x08,
+	[BQ27XXX_REG_AI] = 0x14,
+	[BQ27XXX_REG_FLAGS] = 0x0a,
+	[BQ27XXX_REG_TTE] = 0x16,
+	[BQ27XXX_REG_TTF] = INVALID_REG_ADDR,
+	[BQ27XXX_REG_TTES] = INVALID_REG_ADDR,
+	[BQ27XXX_REG_TTECP] = INVALID_REG_ADDR,
+	[BQ27XXX_REG_NAC] = 0x0c,
+	[BQ27XXX_REG_FCC] = 0x12,
+	[BQ27XXX_REG_CYCT] = 0x2a,
+	[BQ27XXX_REG_AE] = INVALID_REG_ADDR,
+	[BQ27XXX_REG_SOC] = 0x2c,
+	[BQ27XXX_REG_DCAP] = INVALID_REG_ADDR,
+	[BQ27XXX_REG_AP] = 0x24,
 };
 
 static u8 bq27541_regs[] = {
-	0x00,	/* CONTROL	*/
-	0x06,	/* TEMP		*/
-	0x28,	/* INT TEMP	*/
-	0x08,	/* VOLT		*/
-	0x14,	/* AVG CURR	*/
-	0x0a,	/* FLAGS	*/
-	0x16,	/* TTE		*/
-	INVALID_REG_ADDR,	/* TTF - NA	*/
-	INVALID_REG_ADDR,	/* TTES - NA	*/
-	INVALID_REG_ADDR,	/* TTECP - NA	*/
-	0x0c,	/* NAC		*/
-	0x12,	/* LMD(FCC)	*/
-	0x2a,	/* CYCT		*/
-	INVALID_REG_ADDR,	/* AE - NA	*/
-	0x2c,	/* SOC(RSOC)	*/
-	0x3c,	/* DCAP		*/
-	0x24,	/* AP		*/
+	[BQ27XXX_REG_CTRL] = 0x00,
+	[BQ27XXX_REG_TEMP] = 0x06,
+	[BQ27XXX_REG_INT_TEMP] = 0x28,
+	[BQ27XXX_REG_VOLT] = 0x08,
+	[BQ27XXX_REG_AI] = 0x14,
+	[BQ27XXX_REG_FLAGS] = 0x0a,
+	[BQ27XXX_REG_TTE] = 0x16,
+	[BQ27XXX_REG_TTF] = INVALID_REG_ADDR,
+	[BQ27XXX_REG_TTES] = INVALID_REG_ADDR,
+	[BQ27XXX_REG_TTECP] = INVALID_REG_ADDR,
+	[BQ27XXX_REG_NAC] = 0x0c,
+	[BQ27XXX_REG_FCC] = 0x12,
+	[BQ27XXX_REG_CYCT] = 0x2a,
+	[BQ27XXX_REG_AE] = INVALID_REG_ADDR,
+	[BQ27XXX_REG_SOC] = 0x2c,
+	[BQ27XXX_REG_DCAP] = 0x3c,
+	[BQ27XXX_REG_AP] = 0x24,
 };
 
 static u8 bq27545_regs[] = {
-	0x00,	/* CONTROL	*/
-	0x06,	/* TEMP		*/
-	0x28,	/* INT TEMP	*/
-	0x08,	/* VOLT		*/
-	0x14,	/* AVG CURR	*/
-	0x0a,	/* FLAGS	*/
-	0x16,	/* TTE		*/
-	INVALID_REG_ADDR,	/* TTF - NA	*/
-	INVALID_REG_ADDR,	/* TTES - NA	*/
-	INVALID_REG_ADDR,	/* TTECP - NA	*/
-	0x0c,	/* NAC		*/
-	0x12,	/* LMD(FCC)	*/
-	0x2a,	/* CYCT		*/
-	INVALID_REG_ADDR,	/* AE - NA	*/
-	0x2c,	/* SOC(RSOC)	*/
-	INVALID_REG_ADDR,	/* DCAP - NA */
-	0x24,	/* AP		*/
+	[BQ27XXX_REG_CTRL] = 0x00,
+	[BQ27XXX_REG_TEMP] = 0x06,
+	[BQ27XXX_REG_INT_TEMP] = 0x28,
+	[BQ27XXX_REG_VOLT] = 0x08,
+	[BQ27XXX_REG_AI] = 0x14,
+	[BQ27XXX_REG_FLAGS] = 0x0a,
+	[BQ27XXX_REG_TTE] = 0x16,
+	[BQ27XXX_REG_TTF] = INVALID_REG_ADDR,
+	[BQ27XXX_REG_TTES] = INVALID_REG_ADDR,
+	[BQ27XXX_REG_TTECP] = INVALID_REG_ADDR,
+	[BQ27XXX_REG_NAC] = 0x0c,
+	[BQ27XXX_REG_FCC] = 0x12,
+	[BQ27XXX_REG_CYCT] = 0x2a,
+	[BQ27XXX_REG_AE] = INVALID_REG_ADDR,
+	[BQ27XXX_REG_SOC] = 0x2c,
+	[BQ27XXX_REG_DCAP] = INVALID_REG_ADDR,
+	[BQ27XXX_REG_AP] = 0x24,
 };
 
 static u8 bq27421_regs[] = {
-	0x00,	/* CONTROL	*/
-	0x02,	/* TEMP		*/
-	0x1e,	/* INT TEMP	*/
-	0x04,	/* VOLT		*/
-	0x10,	/* AVG CURR	*/
-	0x06,	/* FLAGS	*/
-	INVALID_REG_ADDR,	/* TTE - NA	*/
-	INVALID_REG_ADDR,	/* TTF - NA	*/
-	INVALID_REG_ADDR,	/* TTES - NA	*/
-	INVALID_REG_ADDR,	/* TTECP - NA	*/
-	0x08,	/* NAC		*/
-	0x0e,	/* FCC		*/
-	INVALID_REG_ADDR,	/* CYCT - NA	*/
-	INVALID_REG_ADDR,	/* AE - NA	*/
-	0x1c,	/* SOC		*/
-	0x3c,	/* DCAP		*/
-	0x18,	/* AP		*/
+	[BQ27XXX_REG_CTRL] = 0x00,
+	[BQ27XXX_REG_TEMP] = 0x02,
+	[BQ27XXX_REG_INT_TEMP] = 0x1e,
+	[BQ27XXX_REG_VOLT] = 0x04,
+	[BQ27XXX_REG_AI] = 0x10,
+	[BQ27XXX_REG_FLAGS] = 0x06,
+	[BQ27XXX_REG_TTE] = INVALID_REG_ADDR,
+	[BQ27XXX_REG_TTF] = INVALID_REG_ADDR,
+	[BQ27XXX_REG_TTES] = INVALID_REG_ADDR,
+	[BQ27XXX_REG_TTECP] = INVALID_REG_ADDR,
+	[BQ27XXX_REG_NAC] = 0x08,
+	[BQ27XXX_REG_FCC] = 0x0e,
+	[BQ27XXX_REG_CYCT] = INVALID_REG_ADDR,
+	[BQ27XXX_REG_AE] = INVALID_REG_ADDR,
+	[BQ27XXX_REG_SOC] = 0x1c,
+	[BQ27XXX_REG_DCAP] = 0x3c,
+	[BQ27XXX_REG_AP] = 0x18,
 };
 
 static u8 *bq27xxx_regs[] = {
-- 
2.9.0
