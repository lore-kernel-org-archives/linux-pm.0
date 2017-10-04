From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 03/14] pinctrl: sh-pfc: Add generic bias register description
Date: Wed,  4 Oct 2017 11:07:02 +0200
Message-ID: <1507108033-8606-4-git-send-email-geert+renesas@glider.be>
References: <1507108033-8606-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from andre.telenet-ops.be ([195.130.132.53]:51612 "EHLO
        andre.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752189AbdJDJHW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Oct 2017 05:07:22 -0400
In-Reply-To: <1507108033-8606-1-git-send-email-geert+renesas@glider.be>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Linus Walleij <linus.walleij@linaro.org>
Cc: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>, linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Add a generic way to describe bias registers (for pull-up/down control),
like is already done for config and drive registers.

This makes the sh-pfc core code aware of these registers, which will
ease introducing suspend/resume support later.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
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
