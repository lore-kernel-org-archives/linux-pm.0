From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 4/6] ARM: Tegra: defconfig: select cpufreq-cpu0 driver
Date: Wed,  7 Aug 2013 20:16:46 +0530
Message-ID: <4b07346ff53328e93939d03e5eac0ce4c3b3d176.1375886595.git.viresh.kumar@linaro.org>
References: <cover.1375886595.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1375886595.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1375886595.git.viresh.kumar@linaro.org>
References: <cover.1375886595.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@sisk.pl, swarren@nvidia.com
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, mturquette@linaro.org, linux-arm-kernel@lists.infradead.org, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

Tegra requires cpufreq-cpu0 driver to be compiled in and hence we select it from
the defconfig.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/arm/configs/tegra_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/tegra_defconfig b/arch/arm/configs/tegra_defconfig
index 1effb43..3fcec8f 100644
--- a/arch/arm/configs/tegra_defconfig
+++ b/arch/arm/configs/tegra_defconfig
@@ -38,6 +38,7 @@ CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_KEXEC=y
 CONFIG_CPU_FREQ=y
 CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
+CONFIG_GENERIC_CPUFREQ_CPU0=y
 CONFIG_CPU_IDLE=y
 CONFIG_VFP=y
 CONFIG_PM_RUNTIME=y
-- 
1.7.12.rc2.18.g61b472e
