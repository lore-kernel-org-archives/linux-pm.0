From: Petr Cvek <petr.cvek@tul.cz>
Subject: [PATCH v3 07/26] ARM: pxa: magician: Fix HTC Magician pin mux
 definitions
Date: Thu, 17 Sep 2015 06:56:45 +0200
Message-ID: <55FA480D.4030602@tul.cz>
References: <cover.1442462898.git.petr.cvek@tul.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bubo.tul.cz ([147.230.16.1]:36955 "EHLO bubo.tul.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752338AbbIQE4x (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 17 Sep 2015 00:56:53 -0400
In-Reply-To: <cover.1442462898.git.petr.cvek@tul.cz>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: robert.jarzmik@free.fr, philipp.zabel@gmail.com, daniel@zonque.org, haojian.zhuang@gmail.com, cooloney@gmail.com, rpurdie@rpsys.net, j.anaszewski@samsung.com, linux@arm.linux.org.uk, sre@kernel.org, dbaryshkov@gmail.com, lee.jones@linaro.org, sameo@linux.intel.com, dwmw2@infradead.org, arnd@arndb.de, g.liakhovetski@gmx.de
Cc: linux-leds@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org

This patch fixes a pin mux for the HTC Magician machine. Wrong and missing
definitions caused a bad LCD operation and an unavailability of several
peripherals.

Signed-off-by: Petr Cvek <petr.cvek@tul.cz>
---
 arch/arm/mach-pxa/magician.c | 77 ++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 70 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-pxa/magician.c b/arch/arm/mach-pxa/magician.c
index a93ed14..91d302b 100644
--- a/arch/arm/mach-pxa/magician.c
+++ b/arch/arm/mach-pxa/magician.c
@@ -4,8 +4,9 @@
  * and T-Mobile MDA Compact.
  *
  * Copyright (c) 2006-2007 Philipp Zabel
+ * Copyright (c) 2014-2015 Petr Cvek (massive rework)
  *
- * Based on hx4700.c, spitz.c and others.
+ * Based on hx4700.c, spitz.c, board-overo.c and others.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -56,6 +57,8 @@ static unsigned long magician_pin_config[] __initdata = {
 	GPIO79_nCS_3,	/* EGPIO CPLD */
 	GPIO80_nCS_4,
 	GPIO33_nCS_5,
+	GPIO49_nPWE,
+	GPIO18_RDY,
 
 	/* I2C UDA1380 + OV9640 */
 	GPIO117_I2C_SCL,
@@ -64,6 +67,10 @@ static unsigned long magician_pin_config[] __initdata = {
 	/* PWM 0 - LCD backlight */
 	GPIO16_PWM0_OUT,
 
+	/* Omnivision camera power and reset GPIO */
+	MFP_CFG_OUT(GPIO116, AF0, DRIVE_HIGH),	/* /Enable */
+	MFP_CFG_OUT(GPIO57, AF0, DRIVE_HIGH),	/* Reset */
+
 	/* I2S UDA1380 capture */
 	GPIO28_I2S_BITCLK_OUT,
 	GPIO29_I2S_SDATA_IN,
@@ -89,8 +96,26 @@ static unsigned long magician_pin_config[] __initdata = {
 	GPIO111_MMC_DAT_3,
 	GPIO112_MMC_CMD,
 
-	/* LCD */
-	GPIOxx_LCD_TFT_16BPP,
+	/*
+	 * LCD
+	 * NOTICE Samsung LTP280QV:
+	 * cannot use GPIOxx_LCD_TFT_16BPP, GPIO75 is LCD power,
+	 * 74 unused (AF0 by bootloader?)
+	 */
+	GPIOxx_LCD_16BPP,
+	GPIO76_LCD_PCLK,
+	GPIO77_LCD_BIAS,	/* data_valid (v/hsync) (ADS7846 sync?) */
+
+	/* NOTICE valid LCD init sequence */
+
+	/* for GPIO75_MAGICIAN_SAMSUNG_POWER */
+	MFP_CFG_OUT(GPIO75, AF0, DRIVE_HIGH),
+	/* for GPIO106_MAGICIAN_LCD_DCDC_NRESET */
+	MFP_CFG_OUT(GPIO106, AF0, DRIVE_HIGH),
+	/* for GPIO104_MAGICIAN_LCD_VOFF_EN */
+	MFP_CFG_OUT(GPIO104, AF0, DRIVE_HIGH),
+	/* for GPIO105_MAGICIAN_LCD_VON_EN */
+	MFP_CFG_OUT(GPIO105, AF0, DRIVE_HIGH),
 
 	/* QCI camera interface */
 	GPIO12_CIF_DD_7,
@@ -107,16 +132,54 @@ static unsigned long magician_pin_config[] __initdata = {
 	GPIO85_CIF_LV,
 
 	/* Magician specific input GPIOs */
-	GPIO9_GPIO,	/* unknown */
 	GPIO10_GPIO,	/* GSM_IRQ */
 	GPIO13_GPIO,	/* CPLD_IRQ */
 	GPIO107_GPIO,	/* DS1WM_IRQ */
 	GPIO108_GPIO,	/* GSM_READY */
 	GPIO115_GPIO,	/* nPEN_IRQ */
 
-	/* I2C */
-	GPIO117_I2C_SCL,
-	GPIO118_I2C_SDA,
+	/* Vibration motor */
+	MFP_CFG_OUT(GPIO22, AF0, DRIVE_LOW),
+
+	/* Keypad LEDs (red/green phone) */
+	MFP_CFG_OUT(GPIO103, AF0, DRIVE_LOW),
+
+	/* GSM pins */
+	MFP_CFG_OUT(GPIO11, AF0, DRIVE_LOW),	/* CPU is unavailable(?) */
+	MFP_CFG_OUT(GPIO26, AF0, DRIVE_LOW),	/* GSM power */
+	MFP_CFG_OUT(GPIO86, AF0, DRIVE_HIGH),	/* GSM reset */
+
+	/* USB connector */
+	MFP_CFG_OUT(GPIO27, AF0, DRIVE_LOW),	/* enable usbc pull-up */
+	MFP_CFG_OUT(GPIO30, AF0, DRIVE_LOW),	/* /charging enable */
+
+	/* FFUART, FIXME never observed to do something, GSM data? */
+	GPIO34_FFUART_RXD,
+	GPIO35_FFUART_CTS,
+	GPIO36_FFUART_DCD,
+	GPIO39_FFUART_TXD,
+	GPIO41_FFUART_RTS,
+
+	/* BTUART, AT commands/data, HTC port line discipline */
+	GPIO42_BTUART_RXD,
+	GPIO43_BTUART_TXD,
+	GPIO44_BTUART_CTS,
+	GPIO45_BTUART_RTS,
+
+	/* Power I2C, controller will overrule GPIO */
+	GPIO3_GPIO,	/* SCL */
+	GPIO4_GPIO,	/* SDA */
+
+	/* IrDA GPIOs, pxaficp will change it to correct AFx */
+	MFP_CFG_IN(GPIO46, AF0),
+	MFP_CFG_OUT(GPIO47, AF0, DRIVE_LOW),
+	/* FIXME: probably IrDA transmitter disable */
+	MFP_CFG_OUT(GPIO83, AF0, DRIVE_HIGH),
+
+	/* FIXME yet unknown exact function */
+	GPIO9_GPIO,	/* unknown */
+	MFP_CFG_OUT(GPIO40, AF0, DRIVE_LOW),	/* FIXME GSM? */
+	MFP_CFG_OUT(GPIO87, AF0, DRIVE_LOW),	/* FIXME GSM? */
 };
 
 /*
-- 
1.7.12.1

