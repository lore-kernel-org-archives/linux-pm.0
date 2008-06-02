From: Paulius Zaleckas <paulius.zaleckas@teltonika.lt>
Subject: [PATCH v2] Add i.MX1/L power management driver
Date: Mon, 02 Jun 2008 19:36:18 +0300
Message-ID: <g217ik$h3j$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
Content-Disposition: inline;
 filename="patch-pm-imx"
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/lurker/list/linux-arm-kernel.html>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.arm.linux.org.uk
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

Add power management support for i.MX1/L

v2:
- simplified imx_pm_valid_state()
- removed not needed info message from imx_pm_init()

Signed-off-by: Paulius Zaleckas <paulius.zaleckas@teltonika.lt>

Index: linux-2.6.26-rc1/arch/arm/mach-imx/Makefile
===================================================================
--- linux-2.6.26-rc1.orig/arch/arm/mach-imx/Makefile
+++ linux-2.6.26-rc1/arch/arm/mach-imx/Makefile
@@ -6,8 +6,14 @@
 
 obj-y			+= irq.o time.o dma.o generic.o
 
+# Power management
+obj-$(CONFIG_PM)		+= pm.o
 obj-$(CONFIG_CPU_FREQ_IMX)	+= cpufreq.o
 
+ifeq ($(CONFIG_PM_DEBUG),y)
+CFLAGS_pm.o += -DDEBUG
+endif
+
 # Specific board support
 obj-$(CONFIG_ARCH_MX1ADS) += mx1ads.o
 
Index: linux-2.6.26-rc1/arch/arm/mach-imx/pm.c
===================================================================
--- /dev/null
+++ linux-2.6.26-rc1/arch/arm/mach-imx/pm.c
@@ -0,0 +1,48 @@
+/*
+ * i.MX Power Management
+ *
+ * Copyright (c) 2008 Paulius Zaleckas <paulius.zaleckas@teltonika.lt>
+ *
+ * This file may be distributed under the terms of the GNU General
+ * Public License, version 2.
+ */
+
+#include <linux/suspend.h>
+#include <asm/arch/hardware.h>
+
+static int imx_pm_valid_state(suspend_state_t state)
+{
+	return state == PM_SUSPEND_STANDBY;
+}
+
+static int imx_pm_enter(suspend_state_t state)
+{
+	switch (state) {
+	case PM_SUSPEND_STANDBY:
+		/* disable System PLL and MCU PLL */
+		CSCR &= ~(CSCR_SPEN | CSCR_MPEN);
+		break;
+	default:
+		pr_debug("i.MX: PM - bogus suspend state %d\n", state);
+		goto exit;
+	}
+
+	pr_debug("i.MX: PM - wakeup\n");
+
+exit:
+	return 0;
+}
+
+static struct platform_suspend_ops imx_pm_ops ={
+	.valid	= imx_pm_valid_state,
+	.enter	= imx_pm_enter,
+};
+
+static int __init imx_pm_init(void)
+{
+	suspend_set_ops(&imx_pm_ops);
+
+	return 0;
+}
+
+arch_initcall(imx_pm_init);
-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
