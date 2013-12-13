From: Lukasz Majewski <l.majewski@samsung.com>
Subject: [PATCH v11 7/7] thermal:exynos:boost: Automatic enable/disable of
 BOOST feature (at Exynos4412)
Date: Fri, 13 Dec 2013 17:38:37 +0100
Message-ID: <1386952717-30947-8-git-send-email-l.majewski@samsung.com>
References: <1370502472-7249-1-git-send-email-l.majewski@samsung.com>
 <1386952717-30947-1-git-send-email-l.majewski@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1386952717-30947-1-git-send-email-l.majewski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>
Cc: "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Jonghwa Lee <jonghwa3.lee@samsung.com>, Lukasz Majewski <l.majewski@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, linux-kernel <linux-kernel@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Myungjoo Ham <myungjoo.ham@samsung.com>, durgadoss.r@intel.com, linux-samsung-soc@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

This patch provides auto disable/enable operation for boost. It uses already
present thermal infrastructure to provide boost hysteresis.
The TMU data has been modified to work properly with or without boost.

Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
Signed-off-by: Myungjoo Ham <myungjoo.ham@samsung.com>

---
Changes for v11:
    - Use only one thermal data set
    - Adjust Exynos4412 thermal data to work with or without BOOST

Changes for v10:
    - Remove boost related code from thermal_core.c
    - Use already present thermal infrastructure to provide thermal hysteresis
    - Introduce special set of TMU data for BOOST

Changes for v9:
    - None

Changes for v8:
    - Move cpufreq_boost_* stub functions definition (needed when cpufreq
      is not compiled in) to cpufreq.h at cpufreq core support commit

Changes for v7:
    - None

Changes for v6:
    - Disable boost only when supported and enabled
    - Protect boost related thermal_zone_device struct fields with mutex
    - Evaluate temperature trend during boost enable decision
    - Create separate methods to handle boost enable/disable
      (thermal_boost_{enable|disable}) operations
    - Boost is disabled at any trip point passage (not only the non critical one)
    - Add stub definitions for cpufreq boost functions used when
      CONFIG_CPU_FREQ is NOT defined.

Changes for v5:
    - Move boost disable code from cpu_cooling.c to thermal_core.c
      (to handle_non_critical_trips)
    - Extent struct thermal_zone_device by adding overheated bool flag
    - Implement auto enable of boost after device cools down
    - Introduce boost_polling flag, which indicates if thermal uses it's predefined
      pool delay or has woken up thermal workqueue only to wait until device
      cools down.

Changes for v4:
    - New patch

 drivers/thermal/samsung/exynos_tmu_data.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu_data.c b/drivers/thermal/samsung/exynos_tmu_data.c
index 073c292..476b768 100644
--- a/drivers/thermal/samsung/exynos_tmu_data.c
+++ b/drivers/thermal/samsung/exynos_tmu_data.c
@@ -131,8 +131,8 @@ static const struct exynos_tmu_registers exynos4412_tmu_registers = {
 
 #define EXYNOS4412_TMU_DATA \
 	.threshold_falling = 10, \
-	.trigger_levels[0] = 85, \
-	.trigger_levels[1] = 103, \
+	.trigger_levels[0] = 70, \
+	.trigger_levels[1] = 95, \
 	.trigger_levels[2] = 110, \
 	.trigger_levels[3] = 120, \
 	.trigger_enable[0] = true, \
@@ -155,12 +155,12 @@ static const struct exynos_tmu_registers exynos4412_tmu_registers = {
 	.second_point_trim = 85, \
 	.default_temp_offset = 50, \
 	.freq_tab[0] = { \
-		.freq_clip_max = 800 * 1000, \
-		.temp_level = 85, \
+		.freq_clip_max = 1400 * 1000, \
+		.temp_level = 70, \
 	}, \
 	.freq_tab[1] = { \
-		.freq_clip_max = 200 * 1000, \
-		.temp_level = 103, \
+		.freq_clip_max = 400 * 1000, \
+		.temp_level = 95, \
 	}, \
 	.freq_tab_count = 2, \
 	.registers = &exynos4412_tmu_registers, \
-- 
1.7.10.4
