From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 02/14] pinctrl: sh-pfc: Drop width parameter of sh_pfc_{read,write}_reg()
Date: Mon, 16 Oct 2017 17:27:47 +0200
Message-ID: <1508167679-21155-3-git-send-email-geert+renesas@glider.be>
References: <1508167679-21155-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from michel.telenet-ops.be ([195.130.137.88]:52248 "EHLO
        michel.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754178AbdJPP2E (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 Oct 2017 11:28:04 -0400
In-Reply-To: <1508167679-21155-1-git-send-email-geert+renesas@glider.be>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Linus Walleij <linus.walleij@linaro.org>
Cc: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>, linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

On modern Renesas SoCs, all PFC registers are 32-bit, and all callers of
sh_pfc_{read,write}_reg() already operate on 32-bit registers only.
Hence make the 32-bit width implicit, and rename the functions to
sh_pfc_{read,write}() to shorten lines.

All accesses to 8-bit or 16-bit registers are still done using
sh_pfc_{read,write}_raw_reg().

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
v2:
  - Add Reviewed-by,
  - Shorten the function names.
---
 drivers/pinctrl/sh-pfc/core.c            |  8 ++++----
 drivers/pinctrl/sh-pfc/core.h            |  5 ++---
 drivers/pinctrl/sh-pfc/pfc-r8a7795-es1.c | 12 ++++++------
 drivers/pinctrl/sh-pfc/pfc-r8a7795.c     | 12 ++++++------
 drivers/pinctrl/sh-pfc/pfc-r8a7796.c     | 12 ++++++------
 drivers/pinctrl/sh-pfc/pinctrl.c         | 12 ++++++------
 6 files changed, 30 insertions(+), 31 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/core.c b/drivers/pinctrl/sh-pfc/core.c
index 9cdbaeab2cf10d46..8b422ac07e57263b 100644
--- a/drivers/pinctrl/sh-pfc/core.c
+++ b/drivers/pinctrl/sh-pfc/core.c
@@ -175,19 +175,19 @@ void sh_pfc_write_raw_reg(void __iomem *mapped_reg, unsigned int reg_width,
 	BUG();
 }
 
-u32 sh_pfc_read_reg(struct sh_pfc *pfc, u32 reg, unsigned int width)
+u32 sh_pfc_read(struct sh_pfc *pfc, u32 reg)
 {
-	return sh_pfc_read_raw_reg(sh_pfc_phys_to_virt(pfc, reg), width);
+	return sh_pfc_read_raw_reg(sh_pfc_phys_to_virt(pfc, reg), 32);
 }
 
-void sh_pfc_write_reg(struct sh_pfc *pfc, u32 reg, unsigned int width, u32 data)
+void sh_pfc_write(struct sh_pfc *pfc, u32 reg, u32 data)
 {
 	if (pfc->info->unlock_reg)
 		sh_pfc_write_raw_reg(
 			sh_pfc_phys_to_virt(pfc, pfc->info->unlock_reg), 32,
 			~data);
 
-	sh_pfc_write_raw_reg(sh_pfc_phys_to_virt(pfc, reg), width, data);
+	sh_pfc_write_raw_reg(sh_pfc_phys_to_virt(pfc, reg), 32, data);
 }
 
 static void sh_pfc_config_reg_helper(struct sh_pfc *pfc,
diff --git a/drivers/pinctrl/sh-pfc/core.h b/drivers/pinctrl/sh-pfc/core.h
index 6d598dd637208567..dd215d36dcc82f8a 100644
--- a/drivers/pinctrl/sh-pfc/core.h
+++ b/drivers/pinctrl/sh-pfc/core.h
@@ -26,9 +26,8 @@ int sh_pfc_register_pinctrl(struct sh_pfc *pfc);
 u32 sh_pfc_read_raw_reg(void __iomem *mapped_reg, unsigned int reg_width);
 void sh_pfc_write_raw_reg(void __iomem *mapped_reg, unsigned int reg_width,
 			  u32 data);
-u32 sh_pfc_read_reg(struct sh_pfc *pfc, u32 reg, unsigned int width);
-void sh_pfc_write_reg(struct sh_pfc *pfc, u32 reg, unsigned int width,
-		      u32 data);
+u32 sh_pfc_read(struct sh_pfc *pfc, u32 reg);
+void sh_pfc_write(struct sh_pfc *pfc, u32 reg, u32 data);
 
 int sh_pfc_get_pin_index(struct sh_pfc *pfc, unsigned int pin);
 int sh_pfc_config_mux(struct sh_pfc *pfc, unsigned mark, int pinmux_type);
diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7795-es1.c b/drivers/pinctrl/sh-pfc/pfc-r8a7795-es1.c
index 0adca6a2b08b4ccd..bd0687ad4fd81bc8 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7795-es1.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7795-es1.c
@@ -5671,9 +5671,9 @@ static unsigned int r8a7795es1_pinmux_get_bias(struct sh_pfc *pfc,
 	reg = info->reg;
 	bit = BIT(info->bit);
 
-	if (!(sh_pfc_read_reg(pfc, PUEN + reg, 32) & bit))
+	if (!(sh_pfc_read(pfc, PUEN + reg) & bit))
 		return PIN_CONFIG_BIAS_DISABLE;
-	else if (sh_pfc_read_reg(pfc, PUD + reg, 32) & bit)
+	else if (sh_pfc_read(pfc, PUD + reg) & bit)
 		return PIN_CONFIG_BIAS_PULL_UP;
 	else
 		return PIN_CONFIG_BIAS_PULL_DOWN;
@@ -5694,16 +5694,16 @@ static void r8a7795es1_pinmux_set_bias(struct sh_pfc *pfc, unsigned int pin,
 	reg = info->reg;
 	bit = BIT(info->bit);
 
-	enable = sh_pfc_read_reg(pfc, PUEN + reg, 32) & ~bit;
+	enable = sh_pfc_read(pfc, PUEN + reg) & ~bit;
 	if (bias != PIN_CONFIG_BIAS_DISABLE)
 		enable |= bit;
 
-	updown = sh_pfc_read_reg(pfc, PUD + reg, 32) & ~bit;
+	updown = sh_pfc_read(pfc, PUD + reg) & ~bit;
 	if (bias == PIN_CONFIG_BIAS_PULL_UP)
 		updown |= bit;
 
-	sh_pfc_write_reg(pfc, PUD + reg, 32, updown);
-	sh_pfc_write_reg(pfc, PUEN + reg, 32, enable);
+	sh_pfc_write(pfc, PUD + reg, updown);
+	sh_pfc_write(pfc, PUEN + reg, enable);
 }
 
 static const struct sh_pfc_soc_operations r8a7795es1_pinmux_ops = {
diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7795.c b/drivers/pinctrl/sh-pfc/pfc-r8a7795.c
index e9ee6642a53caacd..eea29ef65ec49b83 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7795.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7795.c
@@ -5660,9 +5660,9 @@ static unsigned int r8a7795_pinmux_get_bias(struct sh_pfc *pfc,
 	reg = info->reg;
 	bit = BIT(info->bit);
 
-	if (!(sh_pfc_read_reg(pfc, PUEN + reg, 32) & bit))
+	if (!(sh_pfc_read(pfc, PUEN + reg) & bit))
 		return PIN_CONFIG_BIAS_DISABLE;
-	else if (sh_pfc_read_reg(pfc, PUD + reg, 32) & bit)
+	else if (sh_pfc_read(pfc, PUD + reg) & bit)
 		return PIN_CONFIG_BIAS_PULL_UP;
 	else
 		return PIN_CONFIG_BIAS_PULL_DOWN;
@@ -5683,16 +5683,16 @@ static void r8a7795_pinmux_set_bias(struct sh_pfc *pfc, unsigned int pin,
 	reg = info->reg;
 	bit = BIT(info->bit);
 
-	enable = sh_pfc_read_reg(pfc, PUEN + reg, 32) & ~bit;
+	enable = sh_pfc_read(pfc, PUEN + reg) & ~bit;
 	if (bias != PIN_CONFIG_BIAS_DISABLE)
 		enable |= bit;
 
-	updown = sh_pfc_read_reg(pfc, PUD + reg, 32) & ~bit;
+	updown = sh_pfc_read(pfc, PUD + reg) & ~bit;
 	if (bias == PIN_CONFIG_BIAS_PULL_UP)
 		updown |= bit;
 
-	sh_pfc_write_reg(pfc, PUD + reg, 32, updown);
-	sh_pfc_write_reg(pfc, PUEN + reg, 32, enable);
+	sh_pfc_write(pfc, PUD + reg, updown);
+	sh_pfc_write(pfc, PUEN + reg, enable);
 }
 
 static const struct soc_device_attribute r8a7795es1[] = {
diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7796.c b/drivers/pinctrl/sh-pfc/pfc-r8a7796.c
index 2de5c9d5e631d64c..53c5ca721e35f78f 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7796.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7796.c
@@ -5724,9 +5724,9 @@ static unsigned int r8a7796_pinmux_get_bias(struct sh_pfc *pfc,
 	reg = info->reg;
 	bit = BIT(info->bit);
 
-	if (!(sh_pfc_read_reg(pfc, PUEN + reg, 32) & bit))
+	if (!(sh_pfc_read(pfc, PUEN + reg) & bit))
 		return PIN_CONFIG_BIAS_DISABLE;
-	else if (sh_pfc_read_reg(pfc, PUD + reg, 32) & bit)
+	else if (sh_pfc_read(pfc, PUD + reg) & bit)
 		return PIN_CONFIG_BIAS_PULL_UP;
 	else
 		return PIN_CONFIG_BIAS_PULL_DOWN;
@@ -5747,16 +5747,16 @@ static void r8a7796_pinmux_set_bias(struct sh_pfc *pfc, unsigned int pin,
 	reg = info->reg;
 	bit = BIT(info->bit);
 
-	enable = sh_pfc_read_reg(pfc, PUEN + reg, 32) & ~bit;
+	enable = sh_pfc_read(pfc, PUEN + reg) & ~bit;
 	if (bias != PIN_CONFIG_BIAS_DISABLE)
 		enable |= bit;
 
-	updown = sh_pfc_read_reg(pfc, PUD + reg, 32) & ~bit;
+	updown = sh_pfc_read(pfc, PUD + reg) & ~bit;
 	if (bias == PIN_CONFIG_BIAS_PULL_UP)
 		updown |= bit;
 
-	sh_pfc_write_reg(pfc, PUD + reg, 32, updown);
-	sh_pfc_write_reg(pfc, PUEN + reg, 32, enable);
+	sh_pfc_write(pfc, PUD + reg, updown);
+	sh_pfc_write(pfc, PUEN + reg, enable);
 }
 
 static const struct sh_pfc_soc_operations r8a7796_pinmux_ops = {
diff --git a/drivers/pinctrl/sh-pfc/pinctrl.c b/drivers/pinctrl/sh-pfc/pinctrl.c
index 5c9d79981e6d40e8..736634aee500e924 100644
--- a/drivers/pinctrl/sh-pfc/pinctrl.c
+++ b/drivers/pinctrl/sh-pfc/pinctrl.c
@@ -513,7 +513,7 @@ static int sh_pfc_pinconf_get_drive_strength(struct sh_pfc *pfc,
 		return -EINVAL;
 
 	spin_lock_irqsave(&pfc->lock, flags);
-	val = sh_pfc_read_reg(pfc, reg, 32);
+	val = sh_pfc_read(pfc, reg);
 	spin_unlock_irqrestore(&pfc->lock, flags);
 
 	val = (val >> offset) & GENMASK(size - 1, 0);
@@ -550,11 +550,11 @@ static int sh_pfc_pinconf_set_drive_strength(struct sh_pfc *pfc,
 
 	spin_lock_irqsave(&pfc->lock, flags);
 
-	val = sh_pfc_read_reg(pfc, reg, 32);
+	val = sh_pfc_read(pfc, reg);
 	val &= ~GENMASK(offset + size - 1, offset);
 	val |= strength << offset;
 
-	sh_pfc_write_reg(pfc, reg, 32, val);
+	sh_pfc_write(pfc, reg, val);
 
 	spin_unlock_irqrestore(&pfc->lock, flags);
 
@@ -645,7 +645,7 @@ static int sh_pfc_pinconf_get(struct pinctrl_dev *pctldev, unsigned _pin,
 			return bit;
 
 		spin_lock_irqsave(&pfc->lock, flags);
-		val = sh_pfc_read_reg(pfc, pocctrl, 32);
+		val = sh_pfc_read(pfc, pocctrl);
 		spin_unlock_irqrestore(&pfc->lock, flags);
 
 		arg = (val & BIT(bit)) ? 3300 : 1800;
@@ -716,12 +716,12 @@ static int sh_pfc_pinconf_set(struct pinctrl_dev *pctldev, unsigned _pin,
 				return -EINVAL;
 
 			spin_lock_irqsave(&pfc->lock, flags);
-			val = sh_pfc_read_reg(pfc, pocctrl, 32);
+			val = sh_pfc_read(pfc, pocctrl);
 			if (mV == 3300)
 				val |= BIT(bit);
 			else
 				val &= ~BIT(bit);
-			sh_pfc_write_reg(pfc, pocctrl, 32, val);
+			sh_pfc_write(pfc, pocctrl, val);
 			spin_unlock_irqrestore(&pfc->lock, flags);
 
 			break;
-- 
2.7.4
