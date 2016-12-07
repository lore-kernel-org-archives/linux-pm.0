From: Roger Shimizu <rogershimizu@gmail.com>
Subject: [PATCH v1 2/3] power: reset: make qnap-poweroff flexible on length of power-off command
Date: Thu,  8 Dec 2016 02:24:14 +0900
Message-ID: <20161207172415.9776-3-rogershimizu@gmail.com>
References: <20161206173420.GB18817@lunn.ch>
 <20161207172415.9776-1-rogershimizu@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:34806 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753415AbcLGRZJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 7 Dec 2016 12:25:09 -0500
Received: by mail-pg0-f68.google.com with SMTP id e9so24023945pgc.1
        for <linux-pm@vger.kernel.org>; Wed, 07 Dec 2016 09:24:52 -0800 (PST)
In-Reply-To: <20161207172415.9776-1-rogershimizu@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>
Cc: Roger Shimizu <rogershimizu@gmail.com>, Ryan Tandy <ryan@nardis.ca>, Martin Michlmayr <tbm@cyrius.com>, Sylver Bruneau <sylver.bruneau@googlemail.com>, Herbert Valerio Riedel <hvr@gnu.org>

Current power-off command sending to UART1 is fixed to one-byte.
In order to support more devices, it's necessary to make power-off
command as 2-D array argument of device configuration.

By using 2-D array, power-off command may consist a few commands, each
of which may consist a few bytes.

Signed-off-by: Roger Shimizu <rogershimizu@gmail.com>
---
 drivers/power/reset/qnap-poweroff.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/power/reset/qnap-poweroff.c b/drivers/power/reset/qnap-poweroff.c
index 47ed120..644478c 100644
--- a/drivers/power/reset/qnap-poweroff.c
+++ b/drivers/power/reset/qnap-poweroff.c
@@ -25,6 +25,7 @@
 #include <linux/clk.h>
 
 #define UART1_REG(x)	(base + ((UART_##x) << 2))
+#define MICON_CMD_SIZE	4
 
 /* 4-byte magic hello command to UART1-attached microcontroller */
 static const unsigned char qnap_micon_magic[] = {
@@ -34,22 +35,33 @@ static const unsigned char qnap_micon_magic[] = {
 	0x00
 };
 
+// for each row, first byte is the size of command
+static const unsigned char qnap_power_off_cmd[][MICON_CMD_SIZE] = {
+	{ 1, 'A'},
+	{}
+};
+
+static const unsigned char synology_power_off_cmd[][MICON_CMD_SIZE] = {
+	{ 1, '1'},
+	{}
+};
+
 struct power_off_cfg {
 	u32 baud;
 	const unsigned char *magic;
-	char cmd;
+	const unsigned char (*cmd)[MICON_CMD_SIZE];
 };
 
 static const struct power_off_cfg qnap_power_off_cfg = {
 	.baud = 19200,
 	.magic = qnap_micon_magic,
-	.cmd = 'A',
+	.cmd = qnap_power_off_cmd,
 };
 
 static const struct power_off_cfg synology_power_off_cfg = {
 	.baud = 9600,
 	.magic = qnap_micon_magic,
-	.cmd = '1',
+	.cmd = synology_power_off_cmd,
 };
 
 static const struct of_device_id qnap_power_off_of_match_table[] = {
@@ -83,7 +95,10 @@ static void qnap_power_off(void)
 	writel(cfg->magic[3], UART1_REG(MCR));
 
 	/* send the power-off command to PIC */
-	writel(cfg->cmd, UART1_REG(TX));
+	if(cfg->cmd[0][0] == 1 && cfg->cmd[1][0] == 0) {
+		/* for qnap and synology, it's simply one-byte command */
+		writel(cfg->cmd[0][1], UART1_REG(TX));
+	}
 }
 
 static int qnap_power_off_probe(struct platform_device *pdev)
-- 
2.10.2

