From: Lukasz Majewski <l.majewski@samsung.com>
Subject: [PATCH RESEND v8 5/7] cpufreq:exynos:Extend Exynos cpufreq driver to
 support boost framework
Date: Fri, 20 Sep 2013 18:01:02 +0200
Message-ID: <1379692864-4954-6-git-send-email-l.majewski@samsung.com>
References: <1370502472-7249-1-git-send-email-l.majewski@samsung.com>
 <1379692864-4954-1-git-send-email-l.majewski@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1379692864-4954-1-git-send-email-l.majewski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>
Cc: "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Jonghwa Lee <jonghwa3.lee@samsung.com>, Lukasz Majewski <l.majewski@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, linux-kernel <linux-kernel@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Myungjoo Ham <myungjoo.ham@samsung.com>, durgadoss.r@intel.com
List-Id: linux-pm@vger.kernel.org

The cpufreq_driver's boost_supported flag is true only when boost
support is explicitly enabled. Boost related attributes are exported only
under the same condition.

Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
Signed-off-by: Myungjoo Ham <myungjoo.ham@samsung.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

---
Changes for v8:
- None

Changes for v7:
- Replace CONFIG_CPU_FREQ_BOOST_SW with CONFIG_ARM_EXYNOS_CPU_FREQ_BOOST_SW
- Move boost_supported initialization to struct cpufreq_driver exynos_driver

Changes for v6:
- Replace exynos_driver.boost_supported = 1 to = true
- Protect boost attributes export with CONFIG_CPU_FREQ_BOOST_SW

Changes for v5:
- None

Changes for v4:
- None

Changes for v3:
- Remove low level boost code
- Move boost management code to cpufreq core code
- Use boost_supported flag to indicate if driver supports over clocking

Changes for v2:
- Removal of struct cpufreq_boost
- Removal of the CONFIG_CPU_FREQ_BOOST flag
- low_level_boost with valid address when boost is supported

 drivers/cpufreq/exynos-cpufreq.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/cpufreq/exynos-cpufreq.c b/drivers/cpufreq/exynos-cpufreq.c
index b9f9aee..2786aba 100644
--- a/drivers/cpufreq/exynos-cpufreq.c
+++ b/drivers/cpufreq/exynos-cpufreq.c
@@ -270,6 +270,9 @@ static int exynos_cpufreq_cpu_exit(struct cpufreq_policy *policy)
 
 static struct freq_attr *exynos_cpufreq_attr[] = {
 	&cpufreq_freq_attr_scaling_available_freqs,
+#ifdef CONFIG_ARM_EXYNOS_CPU_FREQ_BOOST_SW
+	&cpufreq_freq_attr_scaling_boost_freqs,
+#endif
 	NULL,
 };
 
@@ -282,6 +285,9 @@ static struct cpufreq_driver exynos_driver = {
 	.exit		= exynos_cpufreq_cpu_exit,
 	.name		= "exynos_cpufreq",
 	.attr		= exynos_cpufreq_attr,
+#ifdef CONFIG_ARM_EXYNOS_CPU_FREQ_BOOST_SW
+	.boost_supported = true,
+#endif
 #ifdef CONFIG_PM
 	.suspend	= exynos_cpufreq_suspend,
 	.resume		= exynos_cpufreq_resume,
-- 
1.7.10.4
