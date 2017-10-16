From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 10/14] pinctrl: sh-pfc: Add generic IOCTRL register description
Date: Mon, 16 Oct 2017 17:27:55 +0200
Message-ID: <1508167679-21155-11-git-send-email-geert+renesas@glider.be>
References: <1508167679-21155-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1508167679-21155-1-git-send-email-geert+renesas@glider.be>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Linus Walleij <linus.walleij@linaro.org>
Cc: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>, linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-pm@vger.kernel.org

Add a generic way to describe IOCTRL registers (for e.g. SD I/O voltage
and time delay control), like is already done for config, drive, and
bias registers.

This makes the sh-pfc core code aware of these registers, which will
ease introducing suspend/resume support later.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - No changes.
---
 drivers/pinctrl/sh-pfc/sh_pfc.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pinctrl/sh-pfc/sh_pfc.h b/drivers/pinctrl/sh-pfc/sh_pfc.h
index 18fd878266297dc2..b9bb56c91b6fdaf3 100644
--- a/drivers/pinctrl/sh-pfc/sh_pfc.h
+++ b/drivers/pinctrl/sh-pfc/sh_pfc.h
@@ -159,6 +159,10 @@ struct pinmux_bias_reg {
 	.pud = r2,	\
 	.pins =
 
+struct pinmux_ioctrl_reg {
+	u32 reg;
+};
+
 struct pinmux_data_reg {
 	u32 reg;
 	u8 reg_width;
@@ -251,6 +255,7 @@ struct sh_pfc_soc_info {
 	const struct pinmux_cfg_reg *cfg_regs;
 	const struct pinmux_drive_reg *drive_regs;
 	const struct pinmux_bias_reg *bias_regs;
+	const struct pinmux_ioctrl_reg *ioctrl_regs;
 	const struct pinmux_data_reg *data_regs;
 
 	const u16 *pinmux_data;
-- 
2.7.4
