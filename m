From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH 2/4] ARM: EXYNOS4: Support for generic Clock
 manipulation PM callbacks
Date: Thu, 11 Aug 2011 13:55:17 +0900
Message-ID: <4E4360B5.3050203__49756.8109458827$1313038640$gmane$org@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
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
To: Kukjin Kim <kgene.kim@samsung.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Kyungmin Park <kyungmin.park@samsung.com>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, linux-pm@lists.linux-foundation.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-exynos4/Makefile     |    2 +-
 arch/arm/mach-exynos4/pm-runtime.c |   56 ++++++++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/mach-exynos4/pm-runtime.c

diff --git a/arch/arm/mach-exynos4/Makefile b/arch/arm/mach-exynos4/Makefile
index 97c31ce..28cdb8b 100644
--- a/arch/arm/mach-exynos4/Makefile
+++ b/arch/arm/mach-exynos4/Makefile
@@ -5,7 +5,7 @@
 #
 # Licensed under GPLv2
 
-obj-y				:=
+obj-y				:= pm-runtime.o
 obj-m				:=
 obj-n				:=
 obj-				:=
diff --git a/arch/arm/mach-exynos4/pm-runtime.c b/arch/arm/mach-exynos4/pm-runtime.c
new file mode 100644
index 0000000..4fe9f73
--- /dev/null
+++ b/arch/arm/mach-exynos4/pm-runtime.c
@@ -0,0 +1,56 @@
+/* linux/arch/arm/mach-exynos4/pm-runtime.c
+
+ * Exynos4210 Power management support
+ *
+ * Copyright (c) 2011 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/io.h>
+#include <linux/pm_runtime.h>
+#include <linux/platform_device.h>
+#include <linux/clk.h>
+#include <linux/bitmap.h>
+#include <linux/slab.h>
+
+#ifdef CONFIG_PM_RUNTIME
+
+static int default_platform_runtime_idle(struct device *dev)
+{
+	return pm_runtime_suspend(dev);
+}
+
+static struct dev_pm_domain default_pm_domain = {
+	.ops = {
+		.runtime_suspend = pm_clk_suspend,
+		.runtime_resume = pm_clk_resume,
+		.runtime_idle = default_platform_runtime_idle,
+		USE_PLATFORM_PM_SLEEP_OPS
+	},
+};
+
+#define DEFAULT_PM_DOMAIN_PTR	(&default_pm_domain)
+
+#else
+
+#define DEFAULT_PM_DOMAIN_PTR	NULL
+
+#endif /* CONFIG_PM_RUNTIME */
+
+static struct pm_clk_notifier_block platform_bus_notifier = {
+	.pm_domain = DEFAULT_PM_DOMAIN_PTR,
+	.con_ids = { NULL, },
+};
+
+static int __init exynos4_pm_runtime_init(void)
+{
+	pm_clk_add_notifier(&platform_bus_type, &platform_bus_notifier);
+	return 0;
+}
+core_initcall(exynos4_pm_runtime_init);
-- 
1.7.0.4
