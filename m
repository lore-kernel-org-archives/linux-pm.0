From: Mark Langsdorf <mark.langsdorf@calxeda.com>
Subject: [PATCH] mailbox: prevent pl320-ipc code from breaking none-AMBA systems
Date: Tue, 29 Jan 2013 10:36:53 -0600
Message-ID: <1359477413-27881-1-git-send-email-mark.langsdorf@calxeda.com>
Return-path: <cpufreq-owner@vger.kernel.org>
Sender: cpufreq-owner@vger.kernel.org
To: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Mark Langsdorf <mark.langsdorf@calxeda.com>
List-Id: linux-pm@vger.kernel.org

The pl320-ipc code depends on ARM AMBA, and should have the dependency
in its Kconfig.

Signed-off-by: Mark Langsdorf <mark.langsdorf@calxeda.com>
---
 drivers/mailbox/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
index 9489554..9545c9f 100644
--- a/drivers/mailbox/Kconfig
+++ b/drivers/mailbox/Kconfig
@@ -8,6 +8,7 @@ menuconfig MAILBOX
 if MAILBOX
 config PL320_MBOX
 	bool "ARM PL320 Mailbox"
+	depends on ARM_AMBA
 	help
 	  An implementation of the ARM PL320 Interprocessor Communication
 	  Mailbox (IPCM), tailored for the Calxeda Highbank. It is used to
-- 
1.7.11.7

