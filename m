From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 2/2] cpufreq: Select PM_OPP rather than depending on it
Date: Wed, 11 Dec 2013 22:12:27 +0000
Message-ID: <1386799947-6041-2-git-send-email-broonie@kernel.org>
References: <1386799947-6041-1-git-send-email-broonie@kernel.org>
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <1386799947-6041-1-git-send-email-broonie@kernel.org>
Sender: cpufreq-owner@vger.kernel.org
To: Rob Herring <rob.herring@calxeda.com>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>
List-Id: linux-pm@vger.kernel.org

From: Mark Brown <broonie@linaro.org>

PM_OPP is a helper library used by several of the existing cpufreq drivers.
Some of the drivers select this symbol while others depend on it and rely
on the architecture to enable it. Make this behaviour more consistent and
obvious by having all the drivers select the symbol. This will also allow
better build coverage of the affected drivers.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 drivers/cpufreq/Kconfig     | 3 ++-
 drivers/cpufreq/Kconfig.arm | 6 ++++--
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
index e26fdcd14165..6947fdfca57c 100644
--- a/drivers/cpufreq/Kconfig
+++ b/drivers/cpufreq/Kconfig
@@ -181,7 +181,8 @@ config CPU_FREQ_GOV_CONSERVATIVE
 
 config GENERIC_CPUFREQ_CPU0
 	tristate "Generic CPU0 cpufreq driver"
-	depends on HAVE_CLK && REGULATOR && PM_OPP && OF
+	depends on HAVE_CLK && REGULATOR && OF
+	select PM_OPP
 	help
 	  This adds a generic cpufreq driver for CPU0 frequency management.
 	  It supports both uniprocessor (UP) and symmetric multiprocessor (SMP)
diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index 0a141109fd29..456ba5e1781c 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -4,7 +4,8 @@
 
 config ARM_BIG_LITTLE_CPUFREQ
 	tristate "Generic ARM big LITTLE CPUfreq driver"
-	depends on ARM && ARM_CPU_TOPOLOGY && PM_OPP && HAVE_CLK
+	depends on ARM && ARM_CPU_TOPOLOGY && HAVE_CLK
+	select PM_OPP
 	help
 	  This enables the Generic CPUfreq driver for ARM big.LITTLE platforms.
 
@@ -54,7 +55,8 @@ config ARM_EXYNOS5250_CPUFREQ
 config ARM_EXYNOS5440_CPUFREQ
 	bool "SAMSUNG EXYNOS5440"
 	depends on SOC_EXYNOS5440
-	depends on HAVE_CLK && PM_OPP && OF
+	depends on HAVE_CLK && OF
+	select PM_OPP
 	default y
 	help
 	  This adds the CPUFreq driver for Samsung EXYNOS5440
-- 
1.8.5.1

