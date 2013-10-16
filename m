From: Tomasz Figa <t.figa@samsung.com>
Subject: [PATCH] cpufreq: exynos: Convert exynos-cpufreq to platform driver
Date: Wed, 16 Oct 2013 18:00:38 +0200
Message-ID: <1381939238-30398-1-git-send-email-t.figa@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.w1.samsung.com ([210.118.77.12]:10857 "EHLO
	mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756018Ab3JPQA4 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 16 Oct 2013 12:00:56 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-samsung-soc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, Kukjin Kim <kgene.kim@samsung.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lukasz Majewski <l.majewski@samsung.com>, Tomasz Figa <t.figa@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>

From: Lukasz Majewski <l.majewski@samsung.com>

To make the driver multiplatform-friendly, unconditional initialization
in an initcall is replaced with a platform driver probed only if
respective platform device is registered.

Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-exynos/common.c          |  5 +++++
 arch/arm/mach-exynos/common.h          |  1 +
 arch/arm/mach-exynos/mach-exynos4-dt.c |  1 +
 arch/arm/mach-exynos/mach-exynos5-dt.c |  1 +
 drivers/cpufreq/exynos-cpufreq.c       | 11 ++++++++++-
 5 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-exynos/common.c b/arch/arm/mach-exynos/common.c
index c17407b..4414d70 100644
--- a/arch/arm/mach-exynos/common.c
+++ b/arch/arm/mach-exynos/common.c
@@ -305,6 +305,11 @@ void __init exynos_cpuidle_init(void)
 	platform_device_register(&exynos_cpuidle);
 }
 
+void __init exynos_cpufreq_init(void)
+{
+	platform_device_register_simple("exynos-cpufreq", -1, NULL, 0);
+}
+
 void __init exynos_init_late(void)
 {
 	if (of_machine_is_compatible("samsung,exynos5440"))
diff --git a/arch/arm/mach-exynos/common.h b/arch/arm/mach-exynos/common.h
index b2ac188..61e5f3a 100644
--- a/arch/arm/mach-exynos/common.h
+++ b/arch/arm/mach-exynos/common.h
@@ -23,6 +23,7 @@ void exynos_init_io(void);
 void exynos4_restart(enum reboot_mode mode, const char *cmd);
 void exynos5_restart(enum reboot_mode mode, const char *cmd);
 void exynos_cpuidle_init(void);
+void exynos_cpufreq_init(void);
 void exynos_init_late(void);
 
 void exynos_firmware_init(void);
diff --git a/arch/arm/mach-exynos/mach-exynos4-dt.c b/arch/arm/mach-exynos/mach-exynos4-dt.c
index 53a3dc3..2cbaf63 100644
--- a/arch/arm/mach-exynos/mach-exynos4-dt.c
+++ b/arch/arm/mach-exynos/mach-exynos4-dt.c
@@ -26,6 +26,7 @@
 static void __init exynos4_dt_machine_init(void)
 {
 	exynos_cpuidle_init();
+	exynos_cpufreq_init();
 
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }
diff --git a/arch/arm/mach-exynos/mach-exynos5-dt.c b/arch/arm/mach-exynos/mach-exynos5-dt.c
index c9f7dd1..9144549 100644
--- a/arch/arm/mach-exynos/mach-exynos5-dt.c
+++ b/arch/arm/mach-exynos/mach-exynos5-dt.c
@@ -48,6 +48,7 @@ static void __init exynos5_dt_machine_init(void)
 	}
 
 	exynos_cpuidle_init();
+	exynos_cpufreq_init();
 
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }
diff --git a/drivers/cpufreq/exynos-cpufreq.c b/drivers/cpufreq/exynos-cpufreq.c
index 0ef13e8..706570e 100644
--- a/drivers/cpufreq/exynos-cpufreq.c
+++ b/drivers/cpufreq/exynos-cpufreq.c
@@ -17,6 +17,7 @@
 #include <linux/regulator/consumer.h>
 #include <linux/cpufreq.h>
 #include <linux/suspend.h>
+#include <linux/platform_device.h>
 
 #include <plat/cpu.h>
 
@@ -277,4 +278,12 @@ err_vdd_arm:
 	kfree(exynos_info);
 	return -EINVAL;
 }
-late_initcall(exynos_cpufreq_init);
+
+static struct platform_driver exynos_cpufreq_platdrv = {
+	.driver = {
+		.name	= "exynos-cpufreq",
+		.owner	= THIS_MODULE,
+	},
+	.probe = exynos_cpufreq_init,
+};
+module_platform_driver(exynos_cpufreq_platdrv);
-- 
1.8.3.2

