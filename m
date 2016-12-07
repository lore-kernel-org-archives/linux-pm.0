From: Roger Shimizu <rogershimizu@gmail.com>
Subject: [PATCH v1 3/3] power: reset: make qnap-poweroff support kurobox-pro
Date: Thu,  8 Dec 2016 02:24:15 +0900
Message-ID: <20161207172415.9776-4-rogershimizu@gmail.com>
References: <20161206173420.GB18817@lunn.ch>
 <20161207172415.9776-1-rogershimizu@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:32953 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753425AbcLGRZJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 7 Dec 2016 12:25:09 -0500
Received: by mail-pf0-f193.google.com with SMTP id 144so20918156pfv.0
        for <linux-pm@vger.kernel.org>; Wed, 07 Dec 2016 09:24:55 -0800 (PST)
In-Reply-To: <20161207172415.9776-1-rogershimizu@gmail.com>
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
 drivers/power/reset/Makefile                       |   2 +-
 drivers/power/reset/kuroboxpro-common.c            | 128 +++++++++++++++++++++
 drivers/power/reset/kuroboxpro-common.h            |   8 ++
 drivers/power/reset/qnap-poweroff.c                |  39 ++++++-
 5 files changed, 181 insertions(+), 4 deletions(-)
 create mode 100644 drivers/power/reset/kuroboxpro-common.c
 create mode 100644 drivers/power/reset/kuroboxpro-common.h

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
diff --git a/drivers/power/reset/Makefile b/drivers/power/reset/Makefile
index 1be307c..df48285 100644
--- a/drivers/power/reset/Makefile
+++ b/drivers/power/reset/Makefile
@@ -11,7 +11,7 @@ obj-$(CONFIG_POWER_RESET_HISI) += hisi-reboot.o
 obj-$(CONFIG_POWER_RESET_IMX) += imx-snvs-poweroff.o
 obj-$(CONFIG_POWER_RESET_MSM) += msm-poweroff.o
 obj-$(CONFIG_POWER_RESET_LTC2952) += ltc2952-poweroff.o
-obj-$(CONFIG_POWER_RESET_QNAP) += qnap-poweroff.o
+obj-$(CONFIG_POWER_RESET_QNAP) += qnap-poweroff.o kuroboxpro-common.o
 obj-$(CONFIG_POWER_RESET_RESTART) += restart-poweroff.o
 obj-$(CONFIG_POWER_RESET_ST) += st-poweroff.o
 obj-$(CONFIG_POWER_RESET_VERSATILE) += arm-versatile-reboot.o
diff --git a/drivers/power/reset/kuroboxpro-common.c b/drivers/power/reset/kuroboxpro-common.c
new file mode 100644
index 0000000..ef417e6
--- /dev/null
+++ b/drivers/power/reset/kuroboxpro-common.c
@@ -0,0 +1,128 @@
+/*
+ * Common control routine of micro-controller of KuroBox-Pro
+ * and it's variants.
+ * It can be used on following devices:
+ * - KuroBox Pro
+ * - Buffalo Linkstation Pro (LS-GL)
+ * - Buffalo Terastation Pro II/Live
+ *
+ * Copyright (C) 2016 Roger Shimizu <rogershimizu@gmail.com>
+ *
+ * Based on the code from:
+ *
+ * Copyright (C) 2008  Sylver Bruneau <sylver.bruneau@googlemail.com>
+ * Copyright (C) 2007  Herbert Valerio Riedel <hvr@gnu.org>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/serial_reg.h>
+#include <linux/io.h>
+#include <linux/delay.h>
+#include "kuroboxpro-common.h"
+
+static int uart1_micon_read(void *base, unsigned char *buf, int count)
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
+static int uart1_micon_write(void *base, const unsigned char *buf, int count)
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
+int uart1_micon_send(void *base, const unsigned char *data, int count)
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
+		uart1_micon_write(base, data, count);
+
+		/* send checksum */
+		uart1_micon_write(base, &checksum, 1);
+
+		if (uart1_micon_read(base, recv_buf, sizeof(recv_buf)) <= 3) {
+			printk(KERN_ERR ">%s: receive failed.\n", __func__);
+
+			/* send preamble to clear the receive buffer */
+			memset(&send_buf, 0xff, sizeof(send_buf));
+			uart1_micon_write(base, send_buf, sizeof(send_buf));
+
+			/* make dummy reads */
+			mdelay(100);
+			uart1_micon_read(base, recv_buf, sizeof(recv_buf));
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
diff --git a/drivers/power/reset/kuroboxpro-common.h b/drivers/power/reset/kuroboxpro-common.h
new file mode 100644
index 0000000..58d5ee6
--- /dev/null
+++ b/drivers/power/reset/kuroboxpro-common.h
@@ -0,0 +1,8 @@
+#ifndef __KUROBOXPRO_COMMON_H__
+#define __KUROBOXPRO_COMMON_H__
+
+#define UART1_REG(x)	(base + ((UART_##x) << 2))
+
+int uart1_micon_send(void *base, const unsigned char *data, int count);
+
+#endif
diff --git a/drivers/power/reset/qnap-poweroff.c b/drivers/power/reset/qnap-poweroff.c
index 644478c..5ae7f1b 100644
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
@@ -23,8 +28,8 @@
 #include <linux/of.h>
 #include <linux/io.h>
 #include <linux/clk.h>
+#include "kuroboxpro-common.h"
 
-#define UART1_REG(x)	(base + ((UART_##x) << 2))
 #define MICON_CMD_SIZE	4
 
 /* 4-byte magic hello command to UART1-attached microcontroller */
@@ -35,6 +40,13 @@ static const unsigned char qnap_micon_magic[] = {
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
@@ -46,6 +58,13 @@ static const unsigned char synology_power_off_cmd[][MICON_CMD_SIZE] = {
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
@@ -64,6 +83,12 @@ static const struct power_off_cfg synology_power_off_cfg = {
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
@@ -71,6 +96,9 @@ static const struct of_device_id qnap_power_off_of_match_table[] = {
 	{ .compatible = "synology,power-off",
 	  .data = &synology_power_off_cfg,
 	},
+	{ .compatible = "kuroboxpro,power-off",
+	  .data = &kuroboxpro_power_off_cfg,
+	},
 	{}
 };
 MODULE_DEVICE_TABLE(of, qnap_power_off_of_match_table);
@@ -99,6 +127,13 @@ static void qnap_power_off(void)
 		/* for qnap and synology, it's simply one-byte command */
 		writel(cfg->cmd[0][1], UART1_REG(TX));
 	}
+	else {
+		int i;
+		for(i = 0; cfg->cmd[i][0] > 0; i ++) {
+			/* [0] is size of the command; command starts from [1] */
+			uart1_micon_send(base, &(cfg->cmd[i][1]), cfg->cmd[i][0]);
+		}
+	}
 }
 
 static int qnap_power_off_probe(struct platform_device *pdev)
-- 
2.10.2

