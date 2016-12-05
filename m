From: Roger Shimizu <rogershimizu@gmail.com>
Subject: [PATCH 1/3] power: reset: make qnap-poweroff flexible on hello magic command to uart1
Date: Mon,  5 Dec 2016 21:45:26 +0900
Message-ID: <20161205124528.2999-2-rogershimizu@gmail.com>
References: <20161205124528.2999-1-rogershimizu@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:35497 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751372AbcLEMpu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 5 Dec 2016 07:45:50 -0500
Received: by mail-pg0-f66.google.com with SMTP id p66so16386570pga.2
        for <linux-pm@vger.kernel.org>; Mon, 05 Dec 2016 04:45:50 -0800 (PST)
In-Reply-To: <20161205124528.2999-1-rogershimizu@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>
Cc: Roger Shimizu <rogershimizu@gmail.com>, Ryan Tandy <ryan@nardis.ca>, Martin Michlmayr <tbm@cyrius.com>, Sylver Bruneau <sylver.bruneau@googlemail.com>, Herbert Valerio Riedel <hvr@gnu.org>

Current hello magic command sending to UART1 is fixed in
qnap_power_off().

In order to support more devices, it's necessary to make hello magic
command as an argument in device configuration.

Signed-off-by: Roger Shimizu <rogershimizu@gmail.com>
---
 drivers/power/reset/qnap-poweroff.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/power/reset/qnap-poweroff.c b/drivers/power/reset/qnap-poweroff.c
index 2789a61..47ed120 100644
--- a/drivers/power/reset/qnap-poweroff.c
+++ b/drivers/power/reset/qnap-poweroff.c
@@ -2,6 +2,7 @@
  * QNAP Turbo NAS Board power off. Can also be used on Synology devices.
  *
  * Copyright (C) 2012 Andrew Lunn <andrew@lunn.ch>
+ * Copyright (C) 2016 Roger Shimizu <rogershimizu@gmail.com>
  *
  * Based on the code from:
  *
@@ -25,18 +26,29 @@
 
 #define UART1_REG(x)	(base + ((UART_##x) << 2))
 
+/* 4-byte magic hello command to UART1-attached microcontroller */
+static const unsigned char qnap_micon_magic[] = {
+	0x03,
+	0x00,
+	0x00,
+	0x00
+};
+
 struct power_off_cfg {
 	u32 baud;
+	const unsigned char *magic;
 	char cmd;
 };
 
 static const struct power_off_cfg qnap_power_off_cfg = {
 	.baud = 19200,
+	.magic = qnap_micon_magic,
 	.cmd = 'A',
 };
 
 static const struct power_off_cfg synology_power_off_cfg = {
 	.baud = 9600,
+	.magic = qnap_micon_magic,
 	.cmd = '1',
 };
 
@@ -65,10 +77,10 @@ static void qnap_power_off(void)
 	writel(0x83, UART1_REG(LCR));
 	writel(divisor & 0xff, UART1_REG(DLL));
 	writel((divisor >> 8) & 0xff, UART1_REG(DLM));
-	writel(0x03, UART1_REG(LCR));
-	writel(0x00, UART1_REG(IER));
-	writel(0x00, UART1_REG(FCR));
-	writel(0x00, UART1_REG(MCR));
+	writel(cfg->magic[0], UART1_REG(LCR));
+	writel(cfg->magic[1], UART1_REG(IER));
+	writel(cfg->magic[2], UART1_REG(FCR));
+	writel(cfg->magic[3], UART1_REG(MCR));
 
 	/* send the power-off command to PIC */
 	writel(cfg->cmd, UART1_REG(TX));
-- 
2.10.2

