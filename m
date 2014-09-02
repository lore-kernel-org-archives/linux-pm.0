From: Soren Brinkmann <soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v2 4/9] ARM: zynq: PM: Enable DDR clock stop
Date: Tue,  2 Sep 2014 14:19:09 -0700
Message-ID: <1409692754-13437-5-git-send-email-soren.brinkmann@xilinx.com>
References: <1409692754-13437-1-git-send-email-soren.brinkmann@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1409692754-13437-1-git-send-email-soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, =?UTF-8?q?S=C3=B6ren=20Brinkmann?= <soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

The DDR controller can detect idle periods and leverage low power
features clock stop. When new requests occur, the DDRC resumes
normal operation.

Signed-off-by: Soren Brinkmann <soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
---
v2:
 - properly document return value for zynq_pm_ioremap
 - change zynq_pm_late_init signature to return void
 - add kernel doc to late_init()
 - fix kernel doc
 - only enable clock-stop during boot and leave out self-refresh. The
   self-refresh penalty is apparently not-negligible
---
 arch/arm/mach-zynq/Makefile |  2 +-
 arch/arm/mach-zynq/common.c |  1 +
 arch/arm/mach-zynq/common.h |  2 ++
 arch/arm/mach-zynq/pm.c     | 83 +++++++++++++++++++++++++++++++++++++=
++++++++
 4 files changed, 87 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/mach-zynq/pm.c

diff --git a/arch/arm/mach-zynq/Makefile b/arch/arm/mach-zynq/Makefile
index 1b25d92ebf22..820dff6e1eba 100644
--- a/arch/arm/mach-zynq/Makefile
+++ b/arch/arm/mach-zynq/Makefile
@@ -3,7 +3,7 @@
 #
=20
 # Common support
-obj-y				:=3D common.o slcr.o
+obj-y				:=3D common.o slcr.o pm.o
 CFLAGS_REMOVE_hotplug.o		=3D-march=3Darmv6k
 CFLAGS_hotplug.o 		=3D-Wa,-march=3Darmv7-a -mcpu=3Dcortex-a9
 obj-$(CONFIG_HOTPLUG_CPU)	+=3D hotplug.o
diff --git a/arch/arm/mach-zynq/common.c b/arch/arm/mach-zynq/common.c
index 3cb7c198615a..6bd13e5ce6b7 100644
--- a/arch/arm/mach-zynq/common.c
+++ b/arch/arm/mach-zynq/common.c
@@ -101,6 +101,7 @@ static int __init zynq_get_revision(void)
 static void __init zynq_init_late(void)
 {
 	zynq_core_pm_init();
+	zynq_pm_late_init();
 }
=20
 /**
diff --git a/arch/arm/mach-zynq/common.h b/arch/arm/mach-zynq/common.h
index 596ef0b5067c..0edbb6997b1c 100644
--- a/arch/arm/mach-zynq/common.h
+++ b/arch/arm/mach-zynq/common.h
@@ -40,6 +40,8 @@ extern void __iomem *zynq_scu_base;
 /* Hotplug */
 extern void zynq_platform_cpu_die(unsigned int cpu);
=20
+void zynq_pm_late_init(void);
+
 static inline void zynq_core_pm_init(void)
 {
 	/* A9 clock gating */
diff --git a/arch/arm/mach-zynq/pm.c b/arch/arm/mach-zynq/pm.c
new file mode 100644
index 000000000000..911fcf865be8
--- /dev/null
+++ b/arch/arm/mach-zynq/pm.c
@@ -0,0 +1,83 @@
+/*
+ * Zynq power management
+ *
+ *  Copyright (C) 2012 - 2014 Xilinx
+ *
+ *  S=C3=B6ren Brinkmann <soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
+ *
+ * This program is free software: you can redistribute it and/or modif=
y
+ * it under the terms of the GNU General Public License as published b=
y
+ * the Free Software Foundation, either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/=
>.
+ */
+
+#include <linux/io.h>
+#include <linux/of_address.h>
+#include <linux/of_device.h>
+#include "common.h"
+
+/* register offsets */
+#define DDRC_CTRL_REG1_OFFS		0x60
+#define DDRC_DRAM_PARAM_REG3_OFFS	0x20
+
+/* bitfields */
+#define DDRC_CLOCKSTOP_MASK	BIT(23)
+#define DDRC_SELFREFRESH_MASK	BIT(12)
+
+static void __iomem *ddrc_base;
+
+/**
+ * zynq_pm_ioremap() - Create IO mappings
+ * @comp:	DT compatible string
+ * Return: Pointer to the mapped memory or NULL.
+ *
+ * Remap the memory region for a compatible DT node.
+ */
+static void __iomem *zynq_pm_ioremap(const char *comp)
+{
+	struct device_node *np;
+	void __iomem *base =3D NULL;
+
+	np =3D of_find_compatible_node(NULL, NULL, comp);
+	if (np) {
+		base =3D of_iomap(np, 0);
+		of_node_put(np);
+	} else {
+		pr_warn("%s: no compatible node found for '%s'\n", __func__,
+				comp);
+	}
+
+	return base;
+}
+
+/**
+ * zynq_pm_late_init() - Power management init
+ *
+ * Initialization of power management related featurs and infrastructu=
re.
+ */
+void __init zynq_pm_late_init(void)
+{
+	u32 reg;
+
+	ddrc_base =3D zynq_pm_ioremap("xlnx,zynq-ddrc-a05");
+	if (!ddrc_base) {
+		pr_warn("%s: Unable to map DDRC IO memory.\n", __func__);
+	} else {
+		/*
+		 * Enable DDRC clock stop feature. The HW takes care of
+		 * entering/exiting the correct mode depending
+		 * on activity state.
+		 */
+		reg =3D readl(ddrc_base + DDRC_DRAM_PARAM_REG3_OFFS);
+		reg |=3D DDRC_CLOCKSTOP_MASK;
+		writel(reg, ddrc_base + DDRC_DRAM_PARAM_REG3_OFFS);
+	}
+}
--=20
2.1.0.1.g27b9230

--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
