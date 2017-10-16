From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 03/14] pinctrl: sh-pfc: Add generic bias register description
Date: Mon, 16 Oct 2017 17:27:48 +0200
Message-ID: <1508167679-21155-4-git-send-email-geert+renesas@glider.be>
References: <1508167679-21155-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1508167679-21155-1-git-send-email-geert+renesas@glider.be>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Linus Walleij <linus.walleij@linaro.org>
Cc: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>, linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-pm@vger.kernel.org

Add a generic way to describe bias registers (for pull-up/down control),
like is already done for config and drive registers.

This makes the sh-pfc core code aware of these registers, which will
ease introducing suspend/resume support later.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
v2:
  - Add Reviewed-by.
---
 drivers/pinctrl/sh-pfc/sh_pfc.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/pinctrl/sh-pfc/sh_pfc.h b/drivers/pinctrl/sh-pfc/sh_pfc.h
index 8688b405e0813ad7..1914f4b5fef569b3 100644
--- a/drivers/pinctrl/sh-pfc/sh_pfc.h
+++ b/drivers/pinctrl/sh-pfc/sh_pfc.h
@@ -148,6 +148,17 @@ struct pinmux_drive_reg {
 	.reg = r, \
 	.fields =
 
+struct pinmux_bias_reg {
+	u32 puen;		/* Pull-enable or pull-up control register */
+	u32 pud;		/* Pull-up/down control register (optional) */
+	const u16 pins[32];
+};
+
+#define PINMUX_BIAS_REG(name1, r1, name2, r2) \
+	.puen = r1,	\
+	.pud = r2,	\
+	.pins =
+
 struct pinmux_data_reg {
 	u32 reg;
 	u8 reg_width;
@@ -245,6 +256,7 @@ struct sh_pfc_soc_info {
 
 	const struct pinmux_cfg_reg *cfg_regs;
 	const struct pinmux_drive_reg *drive_regs;
+	const struct pinmux_bias_reg *bias_regs;
 	const struct pinmux_data_reg *data_regs;
 
 	const u16 *pinmux_data;
-- 
2.7.4
