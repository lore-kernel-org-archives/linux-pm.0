From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 12/14] pinctrl: sh-pfc: r8a7795: Use generic IOCTRL register description
Date: Mon, 16 Oct 2017 17:27:57 +0200
Message-ID: <1508167679-21155-13-git-send-email-geert+renesas@glider.be>
References: <1508167679-21155-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from xavier.telenet-ops.be ([195.130.132.52]:41766 "EHLO
        xavier.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753888AbdJPP2D (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 Oct 2017 11:28:03 -0400
In-Reply-To: <1508167679-21155-1-git-send-email-geert+renesas@glider.be>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Linus Walleij <linus.walleij@linaro.org>
Cc: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>, linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Move R-Car H3 ES2.0 I/O voltage support over to the generic way to
describe IOCTRL registers, which will be needed for suspend/resume
support.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - Add a sentinel comment, to make it more explicit that a last zero
    entry is required.
---
 drivers/pinctrl/sh-pfc/pfc-r8a7795.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7795.c b/drivers/pinctrl/sh-pfc/pfc-r8a7795.c
index 0a16dea0dace628a..d1cec6d12e818cb9 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7795.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7795.c
@@ -5413,11 +5413,20 @@ static const struct pinmux_drive_reg pinmux_drive_regs[] = {
 	{ },
 };
 
+enum ioctrl_regs {
+	POCCTRL,
+};
+
+static const struct pinmux_ioctrl_reg pinmux_ioctrl_regs[] = {
+	[POCCTRL] = { 0xe6060380, },
+	{ /* sentinel */ },
+};
+
 static int r8a7795_pin_to_pocctrl(struct sh_pfc *pfc, unsigned int pin, u32 *pocctrl)
 {
 	int bit = -EINVAL;
 
-	*pocctrl = 0xe6060380;
+	*pocctrl = pinmux_ioctrl_regs[POCCTRL].reg;
 
 	if (pin >= RCAR_GP_PIN(3, 0) && pin <= RCAR_GP_PIN(3, 11))
 		bit = pin & 0x1f;
@@ -5748,6 +5757,7 @@ const struct sh_pfc_soc_info r8a7795_pinmux_info = {
 	.cfg_regs = pinmux_config_regs,
 	.drive_regs = pinmux_drive_regs,
 	.bias_regs = pinmux_bias_regs,
+	.ioctrl_regs = pinmux_ioctrl_regs,
 
 	.pinmux_data = pinmux_data,
 	.pinmux_data_size = ARRAY_SIZE(pinmux_data),
-- 
2.7.4
