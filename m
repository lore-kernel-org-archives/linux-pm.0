From: Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH] power: reset: ocelot: switch the SI to boot mode
Date: Fri,  9 Nov 2018 20:57:00 +0100
Message-ID: <20181109195700.28321-1-alexandre.belloni@bootlin.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: UNGLinuxDriver@microchip.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Alexandre Belloni <alexandre.belloni@bootlin.com>
List-Id: linux-pm@vger.kernel.org

Switch the SI to boot mode so on a warm reboot, the SI is able to access
the flash.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/power/reset/ocelot-reset.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/power/reset/ocelot-reset.c b/drivers/power/reset/ocelot-reset.c
index 5a13a5cc8188..419952c61fd0 100644
--- a/drivers/power/reset/ocelot-reset.c
+++ b/drivers/power/reset/ocelot-reset.c
@@ -26,6 +26,13 @@ struct ocelot_reset_context {
 
 #define SOFT_CHIP_RST BIT(0)
 
+#define ICPU_CFG_CPU_SYSTEM_CTRL_GENERAL_CTRL	0x24
+#define IF_SI_OWNER_MASK			GENMASK(1, 0)
+#define IF_SI_OWNER_SISL			0
+#define IF_SI_OWNER_SIBM			1
+#define IF_SI_OWNER_SIMC			2
+#define IF_SI_OWNER_OFFSET			4
+
 static int ocelot_restart_handle(struct notifier_block *this,
 				 unsigned long mode, void *cmd)
 {
@@ -37,6 +44,11 @@ static int ocelot_restart_handle(struct notifier_block *this,
 	regmap_update_bits(ctx->cpu_ctrl, ICPU_CFG_CPU_SYSTEM_CTRL_RESET,
 			   CORE_RST_PROTECT, 0);
 
+	/* Make the SI back to boot mode */
+	regmap_update_bits(ctx->cpu_ctrl, ICPU_CFG_CPU_SYSTEM_CTRL_GENERAL_CTRL,
+			   IF_SI_OWNER_MASK << IF_SI_OWNER_OFFSET,
+			   IF_SI_OWNER_SIBM << IF_SI_OWNER_OFFSET);
+
 	writel(SOFT_CHIP_RST, ctx->base);
 
 	pr_emerg("Unable to restart system\n");
-- 
2.19.1
