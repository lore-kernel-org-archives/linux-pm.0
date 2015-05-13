From: Mikko Perttunen <mikko.perttunen@kapsi.fi>
Subject: [PATCH v9 13/17] cpufreq: tegra: Rename tegra-cpufreq to tegra20-cpufreq
Date: Wed, 13 May 2015 17:58:47 +0300
Message-ID: <1431529131-16710-14-git-send-email-mikko.perttunen@kapsi.fi>
References: <1431529131-16710-1-git-send-email-mikko.perttunen@kapsi.fi>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1431529131-16710-1-git-send-email-mikko.perttunen@kapsi.fi>
Sender: linux-kernel-owner@vger.kernel.org
To: swarren@wwwdotorg.org, thierry.reding@gmail.com, gnurou@gmail.com, pdeschrijver@nvidia.com, rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc: mturquette@linaro.org, pwalmsley@nvidia.com, vinceh@nvidia.com, pgaikwad@nvidia.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tuomas.tynkkynen@iki.fi, Tuomas Tynkkynen <ttynkkynen@nvidia.com>, Mikko Perttunen <mikko.perttunen@kapsi.fi>
List-Id: linux-pm@vger.kernel.org

From: Tuomas Tynkkynen <ttynkkynen@nvidia.com>

The Tegra124 will use a different driver for frequency scaling, so
rename the old driver (which handles only Tegra20) appropriately.

Signed-off-by: Tuomas Tynkkynen <ttynkkynen@nvidia.com>
Signed-off-by: Mikko Perttunen <mikko.perttunen@kapsi.fi>
---
 drivers/cpufreq/Kconfig.arm                            | 6 +++---
 drivers/cpufreq/Makefile                               | 2 +-
 drivers/cpufreq/{tegra-cpufreq.c => tegra20-cpufreq.c} | 0
 3 files changed, 4 insertions(+), 4 deletions(-)
 rename drivers/cpufreq/{tegra-cpufreq.c => tegra20-cpufreq.c} (100%)

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index 4f3dbc8..4674299 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -258,12 +258,12 @@ config ARM_SPEAR_CPUFREQ
 	help
 	  This adds the CPUFreq driver support for SPEAr SOCs.
 
-config ARM_TEGRA_CPUFREQ
-	bool "TEGRA CPUFreq support"
+config ARM_TEGRA20_CPUFREQ
+	bool "Tegra20 CPUFreq support"
 	depends on ARCH_TEGRA
 	default y
 	help
-	  This adds the CPUFreq driver support for TEGRA SOCs.
+	  This adds the CPUFreq driver support for Tegra20 SOCs.
 
 config ARM_PXA2xx_CPUFREQ
 	tristate "Intel PXA2xx CPUfreq driver"
diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
index cdce92a..92391c0 100644
--- a/drivers/cpufreq/Makefile
+++ b/drivers/cpufreq/Makefile
@@ -77,7 +77,7 @@ obj-$(CONFIG_ARM_S5PV210_CPUFREQ)	+= s5pv210-cpufreq.o
 obj-$(CONFIG_ARM_SA1100_CPUFREQ)	+= sa1100-cpufreq.o
 obj-$(CONFIG_ARM_SA1110_CPUFREQ)	+= sa1110-cpufreq.o
 obj-$(CONFIG_ARM_SPEAR_CPUFREQ)		+= spear-cpufreq.o
-obj-$(CONFIG_ARM_TEGRA_CPUFREQ)		+= tegra-cpufreq.o
+obj-$(CONFIG_ARM_TEGRA20_CPUFREQ)	+= tegra20-cpufreq.o
 obj-$(CONFIG_ARM_VEXPRESS_SPC_CPUFREQ)	+= vexpress-spc-cpufreq.o
 
 ##################################################################################
diff --git a/drivers/cpufreq/tegra-cpufreq.c b/drivers/cpufreq/tegra20-cpufreq.c
similarity index 100%
rename from drivers/cpufreq/tegra-cpufreq.c
rename to drivers/cpufreq/tegra20-cpufreq.c
-- 
2.3.0
