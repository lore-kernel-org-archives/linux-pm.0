From: Dmitry Osipenko <digetx@gmail.com>
Subject: [PATCH v2 09/11] cpufreq: tegra20: Check if this is Tegra20 machine
Date: Fri, 18 May 2018 23:06:40 +0300
Message-ID: <20180518200642.24815-10-digetx@gmail.com>
References: <20180518200642.24815-1-digetx@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180518200642.24815-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Geis <pgwipeout@gmail.com>
List-Id: linux-pm@vger.kernel.org

Don't even try to request the clocks during of module initialization on
non-Tegra20 machines (this is the case for a multi-platform kernel) for
consistency.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Acked-by: Thierry Reding <treding@nvidia.com>
---
 drivers/cpufreq/tegra20-cpufreq.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/cpufreq/tegra20-cpufreq.c b/drivers/cpufreq/tegra20-cpufreq.c
index 36075aee2ff2..7b425ebe81e7 100644
--- a/drivers/cpufreq/tegra20-cpufreq.c
+++ b/drivers/cpufreq/tegra20-cpufreq.c
@@ -21,6 +21,7 @@
 #include <linux/err.h>
 #include <linux/init.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/types.h>
 
 static struct cpufreq_frequency_table freq_table[] = {
@@ -158,6 +159,9 @@ static int __init tegra_cpufreq_init(void)
 {
 	int err;
 
+	if (!of_machine_is_compatible("nvidia,tegra20"))
+		return -ENODEV;
+
 	cpu_clk = clk_get_sys(NULL, "cclk");
 	if (IS_ERR(cpu_clk))
 		return PTR_ERR(cpu_clk);
-- 
2.17.0
