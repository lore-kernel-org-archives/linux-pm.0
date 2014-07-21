From: Tuomas Tynkkynen <ttynkkynen@nvidia.com>
Subject: [PATCH v2 16/16] ARM: tegra: Update defconfig for tegra124-cpufreq
Date: Mon, 21 Jul 2014 18:39:02 +0300
Message-ID: <1405957142-19416-17-git-send-email-ttynkkynen@nvidia.com>
References: <1405957142-19416-1-git-send-email-ttynkkynen@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1405957142-19416-1-git-send-email-ttynkkynen@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Cc: Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Peter De Schrijver <pdeschrijver@nvidia.com>, Prashant Gaikwad <pgaikwad@nvidia.com>, Mike Turquette <mturquette@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Paul Walmsley <pwalmsley@nvidia.com>, devicetree@vger.kernel.org, Tuomas Tynkkynen <ttynkkynen@nvidia.com>
List-Id: linux-pm@vger.kernel.org

The tegra124-cpufreq driver depends on cpufreq-cpu0, so enable
GENERIC_CPUFREQ_CPU0 to get the Tegra driver to build by default.

Signed-off-by: Tuomas Tynkkynen <ttynkkynen@nvidia.com>
---
 arch/arm/configs/tegra_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/tegra_defconfig b/arch/arm/configs/tegra_defconfig
index 285c433..afaa97c 100644
--- a/arch/arm/configs/tegra_defconfig
+++ b/arch/arm/configs/tegra_defconfig
@@ -43,6 +43,7 @@ CONFIG_KEXEC=y
 CONFIG_CPU_FREQ=y
 CONFIG_CPU_FREQ_STAT_DETAILS=y
 CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
+CONFIG_GENERIC_CPUFREQ_CPU0=y
 CONFIG_CPU_IDLE=y
 CONFIG_VFP=y
 CONFIG_NEON=y
-- 
1.8.1.5
