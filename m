From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 04/14] pinctrl: sh-pfc: Add sh_pfc_pin_to_bias_reg() helper
Date: Wed,  4 Oct 2017 11:07:03 +0200
Message-ID: <1507108033-8606-5-git-send-email-geert+renesas@glider.be>
References: <1507108033-8606-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1507108033-8606-1-git-send-email-geert+renesas@glider.be>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Linus Walleij <linus.walleij@linaro.org>
Cc: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>, linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-pm@vger.kernel.org

Add a helper to look up bias registers and bit number for a specific
pin, using the generic bias register description.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/pinctrl/sh-pfc/core.c | 18 ++++++++++++++++++
 drivers/pinctrl/sh-pfc/core.h |  3 +++
 2 files changed, 21 insertions(+)

diff --git a/drivers/pinctrl/sh-pfc/core.c b/drivers/pinctrl/sh-pfc/core.c
index 1eee3b71cc87ca72..54fae18c32bce3f3 100644
--- a/drivers/pinctrl/sh-pfc/core.c
+++ b/drivers/pinctrl/sh-pfc/core.c
@@ -404,6 +404,24 @@ sh_pfc_pin_to_bias_info(const struct sh_pfc_bias_info *info,
 	return NULL;
 }
 
+const struct pinmux_bias_reg *
+sh_pfc_pin_to_bias_reg(const struct sh_pfc *pfc, unsigned int pin,
+		       unsigned int *bit)
+{
+	unsigned int i, j;
+
+	for (i = 0; pfc->info->bias_regs[i].puen; i++)
+		for (j = 0; j < 32; j++)
+			if (pfc->info->bias_regs[i].pins[j] == pin) {
+				*bit = j;
+				return &pfc->info->bias_regs[i];
+			}
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
index b9645a2b22895938..d3e3e92601ce1945 100644
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
