From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 04/14] pinctrl: sh-pfc: Add sh_pfc_pin_to_bias_reg() helper
Date: Mon, 16 Oct 2017 17:27:49 +0200
Message-ID: <1508167679-21155-5-git-send-email-geert+renesas@glider.be>
References: <1508167679-21155-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from baptiste.telenet-ops.be ([195.130.132.51]:56546 "EHLO
        baptiste.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753837AbdJPP2D (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 Oct 2017 11:28:03 -0400
In-Reply-To: <1508167679-21155-1-git-send-email-geert+renesas@glider.be>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Linus Walleij <linus.walleij@linaro.org>
Cc: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>, linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Add a helper to look up bias registers and bit number for a specific
pin, using the generic bias register description.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - Use ARRAY_SIZE() instead of hardcoded constant 32,
  - Add curly braces to nested for statements.
---
 drivers/pinctrl/sh-pfc/core.c | 20 ++++++++++++++++++++
 drivers/pinctrl/sh-pfc/core.h |  3 +++
 2 files changed, 23 insertions(+)

diff --git a/drivers/pinctrl/sh-pfc/core.c b/drivers/pinctrl/sh-pfc/core.c
index 8b422ac07e57263b..01c408a3dee478f2 100644
--- a/drivers/pinctrl/sh-pfc/core.c
+++ b/drivers/pinctrl/sh-pfc/core.c
@@ -404,6 +404,26 @@ sh_pfc_pin_to_bias_info(const struct sh_pfc_bias_info *info,
 	return NULL;
 }
 
+const struct pinmux_bias_reg *
+sh_pfc_pin_to_bias_reg(const struct sh_pfc *pfc, unsigned int pin,
+		       unsigned int *bit)
+{
+	unsigned int i, j;
+
+	for (i = 0; pfc->info->bias_regs[i].puen; i++) {
+		for (j = 0; j < ARRAY_SIZE(pfc->info->bias_regs[i].pins); j++) {
+			if (pfc->info->bias_regs[i].pins[j] == pin) {
+				*bit = j;
+				return &pfc->info->bias_regs[i];
+			}
+		}
+	}
+
+	WARN_ONCE(1, "Pin %u is not in bias info list\n", pin);
+
+	return NULL;
+}
+
 static int sh_pfc_init_ranges(struct sh_pfc *pfc)
 {
 	struct sh_pfc_pin_range *range;
diff --git a/drivers/pinctrl/sh-pfc/core.h b/drivers/pinctrl/sh-pfc/core.h
index dd215d36dcc82f8a..460d996513acea26 100644
--- a/drivers/pinctrl/sh-pfc/core.h
+++ b/drivers/pinctrl/sh-pfc/core.h
@@ -35,5 +35,8 @@ int sh_pfc_config_mux(struct sh_pfc *pfc, unsigned mark, int pinmux_type);
 const struct sh_pfc_bias_info *
 sh_pfc_pin_to_bias_info(const struct sh_pfc_bias_info *info,
 			unsigned int num, unsigned int pin);
+const struct pinmux_bias_reg *
+sh_pfc_pin_to_bias_reg(const struct sh_pfc *pfc, unsigned int pin,
+		       unsigned int *bit);
 
 #endif /* __SH_PFC_CORE_H__ */
-- 
2.7.4
