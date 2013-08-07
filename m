From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 5/6] ARM: Tegra: start using cpufreq-cpu0 driver
Date: Wed,  7 Aug 2013 20:16:47 +0530
Message-ID: <6610c86618b781b00eba446ca19035e077d99691.1375886595.git.viresh.kumar@linaro.org>
References: <cover.1375886595.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1375886595.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1375886595.git.viresh.kumar@linaro.org>
References: <cover.1375886595.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@sisk.pl, swarren@nvidia.com
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, mturquette@linaro.org, linux-arm-kernel@lists.infradead.org, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

cpufreq-cpu0 driver can be probed over DT only if a corresponding device node is
created for the SoC which wants to use it. Lets create a platform device for
cpufreq-cpu0 driver for Tegra.

Also it removes the Kconfig entry responsible to compiling tegra-cpufreq driver
and hence there will not be any conflicts between two cpufreq drivers.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/arm/mach-tegra/tegra.c | 2 ++
 drivers/cpufreq/Kconfig.arm | 8 --------
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-tegra/tegra.c b/arch/arm/mach-tegra/tegra.c
index 0d1e412..6ab3f69 100644
--- a/arch/arm/mach-tegra/tegra.c
+++ b/arch/arm/mach-tegra/tegra.c
@@ -82,11 +82,13 @@ static struct of_dev_auxdata tegra20_auxdata_lookup[] __initdata = {
 
 static void __init tegra_dt_init(void)
 {
+	struct platform_device_info devinfo = { .name = "cpufreq-cpu0", };
 	struct soc_device_attribute *soc_dev_attr;
 	struct soc_device *soc_dev;
 	struct device *parent = NULL;
 
 	tegra_clocks_apply_init_table();
+	platform_device_register_full(&devinfo);
 
 	soc_dev_attr = kzalloc(sizeof(*soc_dev_attr), GFP_KERNEL);
 	if (!soc_dev_attr)
diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index de4d5d9..9472160 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -215,11 +215,3 @@ config ARM_SPEAR_CPUFREQ
 	default y
 	help
 	  This adds the CPUFreq driver support for SPEAr SOCs.
-
-config ARM_TEGRA_CPUFREQ
-	bool "TEGRA CPUFreq support"
-	depends on ARCH_TEGRA
-	select CPU_FREQ_TABLE
-	default y
-	help
-	  This adds the CPUFreq driver support for TEGRA SOCs.
-- 
1.7.12.rc2.18.g61b472e
