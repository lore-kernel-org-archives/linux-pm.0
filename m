From: Rickard Andersson <rickard.andersson@stericsson.com>
Subject: [RFC PATCH 2/8] ARM: ux500: Add platform suspend ops
Date: Fri, 22 Mar 2013 17:20:06 +0100
Message-ID: <1363969212-14864-3-git-send-email-rickard.andersson@stericsson.com>
References: <1363969212-14864-1-git-send-email-rickard.andersson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from eu1sys200aog115.obsmtp.com ([207.126.144.139]:53426 "EHLO
	eu1sys200aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933769Ab3CVQU2 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 22 Mar 2013 12:20:28 -0400
In-Reply-To: <1363969212-14864-1-git-send-email-rickard.andersson@stericsson.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl, linux-pm@vger.kernel.org
Cc: daniel.lezcano@linaro.org, hongbo.zhang@linaro.org, khilman@linaro.org, ulf.hansson@linaro.org, linus.walleij@stericsson.com, rickard.andersson@stericsson.com

Support for platform suspend operation
WFI (Wait For Interrupt) is added.

Signed-off-by: Rickard Andersson <rickard.andersson@stericsson.com>
---
 arch/arm/mach-ux500/Makefile  |  1 +
 arch/arm/mach-ux500/suspend.c | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+)
 create mode 100644 arch/arm/mach-ux500/suspend.c

diff --git a/arch/arm/mach-ux500/Makefile b/arch/arm/mach-ux500/Makefile
index f24710d..f182cc21 100644
--- a/arch/arm/mach-ux500/Makefile
+++ b/arch/arm/mach-ux500/Makefile
@@ -5,6 +5,7 @@
 obj-y				:= cpu.o devices.o devices-common.o \
 				   id.o usb.o timer.o
 obj-$(CONFIG_CPU_IDLE)          += cpuidle.o
+obj-$(CONFIG_SUSPEND)          += suspend.o
 obj-$(CONFIG_CACHE_L2X0)	+= cache-l2x0.o
 obj-$(CONFIG_UX500_SOC_DB8500)	+= cpu-db8500.o devices-db8500.o
 obj-$(CONFIG_MACH_MOP500)	+= board-mop500.o board-mop500-sdi.o \
diff --git a/arch/arm/mach-ux500/suspend.c b/arch/arm/mach-ux500/suspend.c
new file mode 100644
index 0000000..d1ac203
--- /dev/null
+++ b/arch/arm/mach-ux500/suspend.c
@@ -0,0 +1,35 @@
+/*
+ * Copyright (C) STMicroelectronics 2009
+ * Copyright (C) ST-Ericsson SA 2010-2013
+ *
+ * License Terms: GNU General Public License v2
+ *
+ * Authors: Rickard Andersson <rickard.andersson@stericsson.com>,
+ *	    Jonas Aaberg <jonas.aberg@stericsson.com>,
+ *	    Sundar Iyer for ST-Ericsson.
+ */
+
+#include <linux/suspend.h>
+
+static int ux500_suspend_enter(suspend_state_t state)
+{
+	cpu_do_idle();
+	return 0;
+}
+
+static int ux500_suspend_valid(suspend_state_t state)
+{
+	return state == PM_SUSPEND_MEM || state == PM_SUSPEND_STANDBY;
+}
+
+static const struct platform_suspend_ops ux500_suspend_ops = {
+	.enter	      = ux500_suspend_enter,
+	.valid	      = ux500_suspend_valid,
+};
+
+static __init int ux500_suspend_init(void)
+{
+	suspend_set_ops(&ux500_suspend_ops);
+	return 0;
+}
+device_initcall(ux500_suspend_init);
-- 
1.8.2

