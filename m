From: Dmitry Osipenko <digetx@gmail.com>
Subject: [PATCH v1 09/11] cpufreq: tegra20: Allow cpufreq driver to be built as loadable module
Date: Thu, 17 May 2018 21:00:54 +0300
Message-ID: <20180517180056.13336-10-digetx@gmail.com>
References: <20180517180056.13336-1-digetx@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180517180056.13336-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Geis <pgwipeout@gmail.com>
List-Id: linux-pm@vger.kernel.org

Nothing prevents Tegra20 CPUFreq module to be unloaded, hence allow it to
be built as a non-builtin kernel module.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/cpufreq/Kconfig.arm | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index 96b35b8b3606..a8a2e210c624 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -264,7 +264,7 @@ config ARM_TANGO_CPUFREQ
 	default y
 
 config ARM_TEGRA20_CPUFREQ
-	bool "Tegra20 CPUFreq support"
+	tristate "Tegra20 CPUFreq support"
 	depends on ARCH_TEGRA
 	default y
 	help
-- 
2.17.0
