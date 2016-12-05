From: Roger Shimizu <rogershimizu@gmail.com>
Subject: [PATCH 3/3] power: reset: make qnap-poweroff support kurobox-pro
Date: Mon,  5 Dec 2016 21:45:28 +0900
Message-ID: <20161205124528.2999-4-rogershimizu@gmail.com>
References: <20161205124528.2999-1-rogershimizu@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:35917 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751580AbcLEMqB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 5 Dec 2016 07:46:01 -0500
Received: by mail-pg0-f67.google.com with SMTP id x23so16386428pgx.3
        for <linux-pm@vger.kernel.org>; Mon, 05 Dec 2016 04:45:55 -0800 (PST)
In-Reply-To: <20161205124528.2999-1-rogershimizu@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>
Cc: Roger Shimizu <rogershimizu@gmail.com>, Ryan Tandy <ryan@nardis.ca>, Martin Michlmayr <tbm@cyrius.com>, Sylver Bruneau <sylver.bruneau@googlemail.com>, Herbert Valerio Riedel <hvr@gnu.org>

Add KuroBox-Pro and Terastation Pro II/Live support on qnap-poweroff

The magic command and function of sending multi-byte command come
from files listed below:
  - arch/arm/mach-orion5x/kurobox_pro-setup.c
  - arch/arm/mach-orion5x/terastation_pro2-setup.c

Reported-by: Ryan Tandy <ryan@nardis.ca>
Signed-off-by: Roger Shimizu <rogershimizu@gmail.com>
---
 .../bindings/power/reset/qnap-poweroff.txt         |   8 +-
 drivers/power/reset/qnap-poweroff.c                | 143 ++++++++++++++++++++-
 2 files changed, 149 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/reset/qnap-poweroff.txt b/Documentation/devicetree/bindings/power/reset/qnap-poweroff.txt
index af25e77..410993d 100644
--- a/Documentation/devicetree/bindings/power/reset/qnap-poweroff.txt
+++ b/Documentation/devicetree/bindings/power/reset/qnap-poweroff.txt
@@ -9,8 +9,14 @@ pm_power_off which is called to turn the power off.
 Synology NAS devices use a similar scheme, but a different baud rate,
 9600, and a different character, '1'.
 
+KuroBox Pro, Buffalo Linkstation LS-GL (also known as
+Buffalo Linkstation Pro/Live) and Buffalo Terastation Pro II/Live
+are similar, however it has even higher baud rate and need more
+commands to feed the UART1 before power off.
+
 Required Properties:
-- compatible: Should be "qnap,power-off" or "synology,power-off"
+- compatible: Should be "qnap,power-off", "synology,power-off"
+  or "kuroboxpro,power-off"
 
 - reg: Address and length of the register set for UART1
 - clocks: tclk clock
diff --git a/drivers/power/reset/qnap-poweroff.c b/drivers/power/reset/qnap-poweroff.c
index 644478c..8adc887 100644
--- a/drivers/power/reset/qnap-poweroff.c
+++ b/drivers/power/reset/qnap-poweroff.c
@@ -1,5 +1,10 @@
 /*
- * QNAP Turbo NAS Board power off. Can also be used on Synology devices.
+ * QNAP Turbo NAS Board power off.
+ * It can also be used on following devices:
+ * - Synology devices
+ * - KuroBox Pro
+ * - Buffalo Linkstation Pro (LS-GL)
+ * - Buffalo Terastation Pro II/Live
  *
  * Copyright (C) 2012 Andrew Lunn <andrew@lunn.ch>
  * Copyright (C) 2016 Roger Shimizu <rogershimizu@gmail.com>
@@ -8,6 +13,8 @@
  *
  * Copyright (C) 2009  Martin Michlmayr <tbm@cyrius.com>
  * Copyright (C) 2008  Byron Bradley <byron.bbradley@gmail.com>
+ * Copyright (C) 2008  Sylver Bruneau <sylver.bruneau@googlemail.com>
+ * Copyright (C) 2007  Herbert Valerio Riedel <hvr@gnu.org>
  *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License
@@ -23,6 +30,7 @@
 #include <linux/of.h>
 #include <linux/io.h>
 #include <linux/clk.h>
+#include <linux/delay.h>
 
 #define UART1_REG(x)	(base + ((UART_##x) << 2))
 #define MICON_CMD_SIZE	4
@@ -35,6 +43,13 @@ static const unsigned char qnap_micon_magic[] = {
 	0x00
 };
 
+static const unsigned char kuroboxpro_micon_magic[] = {
+	0x1b,
+	0x00,
+	0x07,
+	0x00
+};
+
 // for each row, first byte is the size of command
 static const unsigned char qnap_power_off_cmd[][MICON_CMD_SIZE] = {
 	{ 1, 'A'},
@@ -46,6 +61,13 @@ static const unsigned char synology_power_off_cmd[][MICON_CMD_SIZE] = {
 	{}
 };
 
+static const unsigned char kuroboxpro_power_off_cmd[][MICON_CMD_SIZE] = {
+	{ 3, 0x01, 0x35, 0x00},
+	{ 2, 0x00, 0x0c},
+	{ 2, 0x00, 0x06},
+	{}
+};
+
 struct power_off_cfg {
 	u32 baud;
 	const unsigned char *magic;
@@ -64,6 +86,12 @@ static const struct power_off_cfg synology_power_off_cfg = {
 	.cmd = synology_power_off_cmd,
 };
 
+static const struct power_off_cfg kuroboxpro_power_off_cfg = {
+	.baud = 38400,
+	.magic = kuroboxpro_micon_magic,
+	.cmd = kuroboxpro_power_off_cmd,
+};
+
 static const struct of_device_id qnap_power_off_of_match_table[] = {
 	{ .compatible = "qnap,power-off",
 	  .data = &qnap_power_off_cfg,
@@ -71,6 +99,9 @@ static const struct of_device_id qnap_power_off_of_match_table[] = {
 	{ .compatible = "synology,power-off",
 	  .data = &synology_power_off_cfg,
 	},
+	{ .compatible = "kuroboxpro,power-off",
+	  .data = &kuroboxpro_power_off_cfg,
+	},
 	{}
 };
 MODULE_DEVICE_TABLE(of, qnap_power_off_of_match_table);
@@ -79,6 +110,109 @@ static void __iomem *base;
 static unsigned long tclk;
 static const struct power_off_cfg *cfg;
 
+static int uart1_miconread(unsigned char *buf, int count)
+{
+	int i;
+	int timeout;
+
+	for (i = 0; i < count; i++) {
+		timeout = 10;
+
+		while (!(readl(UART1_REG(LSR)) & UART_LSR_DR)) {
+			if (--timeout == 0)
+				break;
+			udelay(1000);
+		}
+
+		if (timeout == 0)
+			break;
+		buf[i] = readl(UART1_REG(RX));
+	}
+
+	/* return read bytes */
+	return i;
+}
+
+static int uart1_miconwrite(const unsigned char *buf, int count)
+{
+	int i = 0;
+
+	while (count--) {
+		while (!(readl(UART1_REG(LSR)) & UART_LSR_THRE))
+			barrier();
+		writel(buf[i++], UART1_REG(TX));
+	}
+
+	return 0;
+}
+
+static int uart1_miconsend(const unsigned char *data, int count)
+{
+	int i;
+	unsigned char checksum = 0;
+	unsigned char recv_buf[40];
+	unsigned char send_buf[40];
+	unsigned char correct_ack[3];
+	int retry = 2;
+
+	/* Generate checksum */
+	for (i = 0; i < count; i++)
+		checksum -=  data[i];
+
+	do {
+		/* Send data */
+		uart1_miconwrite(data, count);
+
+		/* send checksum */
+		uart1_miconwrite(&checksum, 1);
+
+		if (uart1_miconread(recv_buf, sizeof(recv_buf)) <= 3) {
+			printk(KERN_ERR ">%s: receive failed.\n", __func__);
+
+			/* send preamble to clear the receive buffer */
+			memset(&send_buf, 0xff, sizeof(send_buf));
+			uart1_miconwrite(send_buf, sizeof(send_buf));
+
+			/* make dummy reads */
+			mdelay(100);
+			uart1_miconread(recv_buf, sizeof(recv_buf));
+		} else {
+			/* Generate expected ack */
+			correct_ack[0] = 0x01;
+			correct_ack[1] = data[1];
+			correct_ack[2] = 0x00;
+
+			/* checksum Check */
+			if ((recv_buf[0] + recv_buf[1] + recv_buf[2] +
+			     recv_buf[3]) & 0xFF) {
+				printk(KERN_ERR ">%s: Checksum Error : "
+					"Received data[%02x, %02x, %02x, %02x]"
+					"\n", __func__, recv_buf[0],
+					recv_buf[1], recv_buf[2], recv_buf[3]);
+			} else {
+				/* Check Received Data */
+				if (correct_ack[0] == recv_buf[0] &&
+				    correct_ack[1] == recv_buf[1] &&
+				    correct_ack[2] == recv_buf[2]) {
+					/* Interval for next command */
+					mdelay(10);
+
+					/* Receive ACK */
+					return 0;
+				}
+			}
+			/* Received NAK or illegal Data */
+			printk(KERN_ERR ">%s: Error : NAK or Illegal Data "
+					"Received\n", __func__);
+		}
+	} while (retry--);
+
+	/* Interval for next command */
+	mdelay(10);
+
+	return -1;
+}
+
 static void qnap_power_off(void)
 {
 	const unsigned divisor = ((tclk + (8 * cfg->baud)) / (16 * cfg->baud));
@@ -99,6 +233,13 @@ static void qnap_power_off(void)
 		/* for qnap and synology, it's simply one-byte command */
 		writel(cfg->cmd[0][1], UART1_REG(TX));
 	}
+	else {
+		int i;
+		for(i = 0; cfg->cmd[i][0] > 0; i ++) {
+			/* [0] is size of the command; command starts from [1] */
+			uart1_miconsend(&(cfg->cmd[i][1]), cfg->cmd[i][0]);
+		}
+	}
 }
 
 static int qnap_power_off_probe(struct platform_device *pdev)
-- 
2.10.2

