From: Paulius Zaleckas <paulius.zaleckas@teltonika.lt>
Subject: [PATCH] Add i.MX1/L power management driver
Date: Mon, 02 Jun 2008 14:47:56 +0300
Message-ID: <4843DDEC.9080200__21489.5974183039$1212417759$gmane$org@teltonika.lt>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------080908010200050202000009"
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

This is a multi-part message in MIME format.
--------------080908010200050202000009
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


--------------080908010200050202000009
Content-Type: text/plain;
 name="patch-pm-imx"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-pm-imx"

Add power management support for i.MX1/L

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
@@ -0,0 +1,53 @@
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
+	if (state == PM_SUSPEND_STANDBY)
+		return 1;
+
+	return 0;
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
+	pr_info("i.MX: Power Management\n");
+
+	suspend_set_ops(&imx_pm_ops);
+
+	return 0;
+}
+
+arch_initcall(imx_pm_init);

--------------080908010200050202000009
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------080908010200050202000009--
