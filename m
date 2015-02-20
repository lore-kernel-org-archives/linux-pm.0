From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH] cpufreq: exynos: allow build for !THERMAL or !CPU_THERMAL cases
Date: Fri, 20 Feb 2015 17:20:22 +0100
Message-ID: <2275232.48muFcOOQv@amdc1032>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, linux-samsung-soc@vger.kernel.org
Cc: Kukjin Kim <kgene@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Eduardo Valentin <edubezval@gmail.com>, Lukasz Majewski <l.majewski@samsung.com>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Allow driver build for !THERMAL or !CPU_THERMAL cases.

The new dependency rule is the same as the one that CPUFREQ_DT
option has (for cpufreq-dt driver which has the same issue with
using of_cpufreq_cooling_register()).

Cc: Kukjin Kim <kgene@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Eduardo Valentin <edubezval@gmail.com>
Cc: Lukasz Majewski <l.majewski@samsung.com>
Fixes: 8b2b4a4e5366 ("cpufreq: exynos: allow modular build")
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/cpufreq/Kconfig.arm | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index 1b06fc4..f4df4af3 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -28,7 +28,8 @@ config ARM_VEXPRESS_SPC_CPUFREQ
 config ARM_EXYNOS_CPUFREQ
 	tristate "SAMSUNG EXYNOS CPUfreq Driver"
 	depends on CPU_EXYNOS4210 || SOC_EXYNOS4212 || SOC_EXYNOS4412 || SOC_EXYNOS5250
-	depends on THERMAL
+	# if CPU_THERMAL is on and THERMAL=m, ARM_EXYNOS_CPUFREQ cannot be =y:
+	depends on !CPU_THERMAL || THERMAL
 	help
 	  This adds the CPUFreq driver for Samsung EXYNOS platforms.
 	  Supported SoC versions are:
-- 
1.8.2.3
