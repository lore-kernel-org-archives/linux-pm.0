From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 1/2] ARM: EXYNOS: convert cpuidle driver to be a platform driver
Date: Fri, 30 Aug 2013 12:15:04 +0200
Message-ID: <86136702.IKrZfWSsO8@amdc1032>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Kukjin Kim <kgene.kim@samsung.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Tomasz Figa <t.figa@samsung.com>, Amit Daniel Kachhap <amit.daniel@samsung.com>, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

ARM EXYNOS cpuidle driver is currently not multiplatform support ready
(as it uses device_initcall() for initialization and doesn't check on
what platform it is running). Fix it by converting the driver to be
a platform driver and registering exynos_cpuidle platform device from
exynos[4,5]_dt_machine_init().

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
Cc: Tomasz Figa <t.figa@samsung.com>
Cc: Amit Daniel Kachhap <amit.daniel@samsung.com>
---
 arch/arm/mach-exynos/common.c          | 11 +++++++++++
 arch/arm/mach-exynos/common.h          |  1 +
 arch/arm/mach-exynos/cpuidle.c         | 14 ++++++++++++--
 arch/arm/mach-exynos/mach-exynos4-dt.c |  2 ++
 arch/arm/mach-exynos/mach-exynos5-dt.c |  2 ++
 5 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-exynos/common.c b/arch/arm/mach-exynos/common.c
index ba95e5d..c17407b 100644
--- a/arch/arm/mach-exynos/common.c
+++ b/arch/arm/mach-exynos/common.c
@@ -30,6 +30,7 @@
 #include <linux/clk-provider.h>
 #include <linux/irqchip/arm-gic.h>
 #include <linux/irqchip/chained_irq.h>
+#include <linux/platform_device.h>
 
 #include <asm/proc-fns.h>
 #include <asm/exception.h>
@@ -294,6 +295,16 @@ void exynos5_restart(enum reboot_mode mode, const char *cmd)
 	__raw_writel(val, addr);
 }
 
+static struct platform_device exynos_cpuidle = {
+	.name		= "exynos_cpuidle",
+	.id		= -1,
+};
+
+void __init exynos_cpuidle_init(void)
+{
+	platform_device_register(&exynos_cpuidle);
+}
+
 void __init exynos_init_late(void)
 {
 	if (of_machine_is_compatible("samsung,exynos5440"))
diff --git a/arch/arm/mach-exynos/common.h b/arch/arm/mach-exynos/common.h
index 8646a14..b2ac188 100644
--- a/arch/arm/mach-exynos/common.h
+++ b/arch/arm/mach-exynos/common.h
@@ -22,6 +22,7 @@ struct map_desc;
 void exynos_init_io(void);
 void exynos4_restart(enum reboot_mode mode, const char *cmd);
 void exynos5_restart(enum reboot_mode mode, const char *cmd);
+void exynos_cpuidle_init(void);
 void exynos_init_late(void);
 
 void exynos_firmware_init(void);
diff --git a/arch/arm/mach-exynos/cpuidle.c b/arch/arm/mach-exynos/cpuidle.c
index 225ee84..8e881e0 100644
--- a/arch/arm/mach-exynos/cpuidle.c
+++ b/arch/arm/mach-exynos/cpuidle.c
@@ -15,6 +15,7 @@
 #include <linux/io.h>
 #include <linux/export.h>
 #include <linux/time.h>
+#include <linux/platform_device.h>
 
 #include <asm/proc-fns.h>
 #include <asm/smp_scu.h>
@@ -192,7 +193,7 @@ static void __init exynos5_core_down_clk(void)
 	__raw_writel(tmp, EXYNOS5_PWR_CTRL2);
 }
 
-static int __init exynos4_init_cpuidle(void)
+static int __init exynos_cpuidle_probe(struct platform_device *pdev)
 {
 	int cpu_id, ret;
 	struct cpuidle_device *device;
@@ -223,4 +224,13 @@ static int __init exynos4_init_cpuidle(void)
 
 	return 0;
 }
-device_initcall(exynos4_init_cpuidle);
+
+static struct platform_driver exynos_cpuidle_driver = {
+	.probe	= exynos_cpuidle_probe,
+	.driver = {
+		.name = "exynos_cpuidle",
+		.owner = THIS_MODULE,
+	},
+};
+
+module_platform_driver(exynos_cpuidle_driver);
diff --git a/arch/arm/mach-exynos/mach-exynos4-dt.c b/arch/arm/mach-exynos/mach-exynos4-dt.c
index 0099c6c..53a3dc3 100644
--- a/arch/arm/mach-exynos/mach-exynos4-dt.c
+++ b/arch/arm/mach-exynos/mach-exynos4-dt.c
@@ -25,6 +25,8 @@
 
 static void __init exynos4_dt_machine_init(void)
 {
+	exynos_cpuidle_init();
+
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }
 
diff --git a/arch/arm/mach-exynos/mach-exynos5-dt.c b/arch/arm/mach-exynos/mach-exynos5-dt.c
index f874b77..c9f7dd1 100644
--- a/arch/arm/mach-exynos/mach-exynos5-dt.c
+++ b/arch/arm/mach-exynos/mach-exynos5-dt.c
@@ -47,6 +47,8 @@ static void __init exynos5_dt_machine_init(void)
 		}
 	}
 
+	exynos_cpuidle_init();
+
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }
 
-- 
1.8.2.3
