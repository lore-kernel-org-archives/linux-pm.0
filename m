From: Lukasz Majewski <l.majewski@samsung.com>
Subject: [PATCH v5 6/7] cpufreq:boost:Kconfig: Enable software managed BOOST
 support at Kconfig
Date: Thu, 04 Jul 2013 10:50:29 +0200
Message-ID: <1372927830-2949-7-git-send-email-l.majewski@samsung.com>
References: <1370502472-7249-1-git-send-email-l.majewski@samsung.com>
 <1372927830-2949-1-git-send-email-l.majewski@samsung.com>
Return-path: <cpufreq-owner@vger.kernel.org>
In-reply-to: <1372927830-2949-1-git-send-email-l.majewski@samsung.com>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>
Cc: "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Jonghwa Lee <jonghwa3.lee@samsung.com>, Lukasz Majewski <l.majewski@samsung.com>, l.majewski@majess.pl, linux-kernel <linux-kernel@vger.kernel.org>, Andre Przywara <andre.przywara@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>, Myungjoo Ham <myungjoo.ham@samsung.com>
List-Id: linux-pm@vger.kernel.org

For safety reasons new flag - CONFIG_CPU_FREQ_BOOST_SW has been added.
Only after selecting "CPU frequency BOOST support" Kconfig option the
software managed boost is enabled. It also selects thermal subsystem
to be compiled in. Thermal is necessary for disabling boost and cooling
down the device when overheating detected.

Boost _MUST_NOT_ be enabled without thermal subsystem with properly
defined temperatures, which indicate overheating.

This option doesn't affect x86's ACPI hardware managed boost support
(i.e. Intel, AMD). In this situation boost management is embedded at
hardware.

Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
Signed-off-by: Myungjoo Ham <myungjoo.ham@samsung.com>

---
Changes for v5:
- New patch

 drivers/cpufreq/Kconfig          |   14 ++++++++++++++
 drivers/cpufreq/exynos-cpufreq.c |    5 ++++-
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
index 534fcb8..e65a112 100644
--- a/drivers/cpufreq/Kconfig
+++ b/drivers/cpufreq/Kconfig
@@ -23,6 +23,20 @@ config CPU_FREQ_TABLE
 config CPU_FREQ_GOV_COMMON
 	bool
 
+config CPU_FREQ_BOOST_SW
+       bool "CPU frequency overclocking (BOOST)"
+       depends on ARM_EXYNOS_CPUFREQ && EXYNOS_THERMAL
+       default n
+       help
+	 This driver supports software managed overclocking (BOOST).
+         It allows usage of special frequencies for a particular processor
+         if thermal conditions are appropriate.
+
+	 It reguires, for safe operation, thermal framework with properly defined
+         trip points.
+
+	 If in doubt, say N.
+
 config CPU_FREQ_STAT
 	tristate "CPU frequency translation statistics"
 	select CPU_FREQ_TABLE
diff --git a/drivers/cpufreq/exynos-cpufreq.c b/drivers/cpufreq/exynos-cpufreq.c
index 4f42fcc..7586b28 100644
--- a/drivers/cpufreq/exynos-cpufreq.c
+++ b/drivers/cpufreq/exynos-cpufreq.c
@@ -288,7 +288,9 @@ static struct cpufreq_driver exynos_driver = {
 
 static int __init exynos_cpufreq_init(void)
 {
+#ifdef CONFIG_CPU_FREQ_BOOST_SW
 	struct device_node *node = pdev->dev.of_node;
+#endif
 	int ret = -EINVAL;
 
 	exynos_info = kzalloc(sizeof(struct exynos_dvfs_info), GFP_KERNEL);
@@ -319,9 +321,10 @@ static int __init exynos_cpufreq_init(void)
 	}
 
 	locking_frequency = exynos_getspeed(0);
+#ifdef CONFIG_CPU_FREQ_BOOST_SW
 	if (of_property_read_bool(node, "boost_mode"))
 		exynos_driver.boost_supported = 1;
-
+#endif
 	register_pm_notifier(&exynos_cpufreq_nb);
 
 	if (cpufreq_register_driver(&exynos_driver)) {
-- 
1.7.10.4

