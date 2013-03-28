From: Rickard Andersson <rickard.andersson@stericsson.com>
Subject: [PATCH V2 02/12] ARM: ux500: Add platform suspend ops
Date: Thu, 28 Mar 2013 17:11:28 +0100
Message-ID: <1364487098-10319-3-git-send-email-rickard.andersson@stericsson.com>
References: <1364487098-10319-1-git-send-email-rickard.andersson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1364487098-10319-1-git-send-email-rickard.andersson@stericsson.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: rjw@sisk.pl, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: hongbo.zhang@linaro.org, ulf.hansson@linaro.org, khilman@linaro.org, linus.walleij@stericsson.com, daniel.lezcano@linaro.org, rickard.andersson@stericsson.com
List-Id: linux-pm@vger.kernel.org

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
