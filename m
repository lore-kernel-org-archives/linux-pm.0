From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 09/14] pinctrl: sh-pfc: Remove obsolete sh_pfc_pin_to_bias_info()
Date: Wed,  4 Oct 2017 11:07:08 +0200
Message-ID: <1507108033-8606-10-git-send-email-geert+renesas@glider.be>
References: <1507108033-8606-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1507108033-8606-1-git-send-email-geert+renesas@glider.be>
Sender: linux-gpio-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Linus Walleij <linus.walleij@linaro.org>
Cc: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>, linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-pm@vger.kernel.org

All users of sh_pfc_pin_to_bias_info() and the related data structures
have been converted to sh_pfc_pin_to_bias_reg(), so those can be
removed.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/pinctrl/sh-pfc/core.c   | 15 ---------------
 drivers/pinctrl/sh-pfc/core.h   |  3 ---
 drivers/pinctrl/sh-pfc/sh_pfc.h |  6 ------
 3 files changed, 24 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/core.c b/drivers/pinctrl/sh-pfc/core.c
index 54fae18c32bce3f3..97be79b5be4dfb25 100644
--- a/drivers/pinctrl/sh-pfc/core.c
+++ b/drivers/pinctrl/sh-pfc/core.c
@@ -389,21 +389,6 @@ int sh_pfc_config_mux(struct sh_pfc *pfc, unsigned mark, int pinmux_type)
 	return 0;
 }
 
-const struct sh_pfc_bias_info *
-sh_pfc_pin_to_bias_info(const struct sh_pfc_bias_info *info,
-			unsigned int num, unsigned int pin)
-{
-	unsigned int i;
-
-	for (i = 0; i < num; i++)
-		if (info[i].pin == pin)
-			return &info[i];
-
-	WARN_ONCE(1, "Pin %u is not in bias info list\n", pin);
-
-	return NULL;
-}
-
 const struct pinmux_bias_reg *
 sh_pfc_pin_to_bias_reg(const struct sh_pfc *pfc, unsigned int pin,
 		       unsigned int *bit)
diff --git a/drivers/pinctrl/sh-pfc/core.h b/drivers/pinctrl/sh-pfc/core.h
index d3e3e92601ce1945..782c7556f6999b91 100644
--- a/drivers/pinctrl/sh-pfc/core.h
+++ b/drivers/pinctrl/sh-pfc/core.h
@@ -32,9 +32,6 @@ void sh_pfc_write_reg(struct sh_pfc *pfc, u32 reg, u32 data);
 int sh_pfc_get_pin_index(struct sh_pfc *pfc, unsigned int pin);
 int sh_pfc_config_mux(struct sh_pfc *pfc, unsigned mark, int pinmux_type);
 
-const struct sh_pfc_bias_info *
-sh_pfc_pin_to_bias_info(const struct sh_pfc_bias_info *info,
-			unsigned int num, unsigned int pin);
 const struct pinmux_bias_reg *
 sh_pfc_pin_to_bias_reg(const struct sh_pfc *pfc, unsigned int pin,
 		       unsigned int *bit);
diff --git a/drivers/pinctrl/sh-pfc/sh_pfc.h b/drivers/pinctrl/sh-pfc/sh_pfc.h
index 1914f4b5fef569b3..18fd878266297dc2 100644
--- a/drivers/pinctrl/sh-pfc/sh_pfc.h
+++ b/drivers/pinctrl/sh-pfc/sh_pfc.h
@@ -200,12 +200,6 @@ struct sh_pfc_window {
 	unsigned long size;
 };
 
-struct sh_pfc_bias_info {
-	u16 pin;
-	u16 reg : 11;
-	u16 bit : 5;
-};
-
 struct sh_pfc_pin_range;
 
 struct sh_pfc {
-- 
2.7.4

