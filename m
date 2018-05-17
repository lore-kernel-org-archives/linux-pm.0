From: Dmitry Osipenko <digetx@gmail.com>
Subject: [PATCH v1 07/11] cpufreq: tegra20: Check if this is Tegra20 machine
Date: Thu, 17 May 2018 21:00:52 +0300
Message-ID: <20180517180056.13336-8-digetx@gmail.com>
References: <20180517180056.13336-1-digetx@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180517180056.13336-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Geis <pgwipeout@gmail.com>
List-Id: linux-pm@vger.kernel.org

Don't even try to request the clocks during of module initialization on
non-Tegra20 machines (this is the case for a multi-platform kernel) for
consistency.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/cpufreq/tegra20-cpufreq.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/cpufreq/tegra20-cpufreq.c b/drivers/cpufreq/tegra20-cpufreq.c
index 147ae3e14f18..797c61c74b65 100644
--- a/drivers/cpufreq/tegra20-cpufreq.c
+++ b/drivers/cpufreq/tegra20-cpufreq.c
@@ -19,6 +19,7 @@
 #include <linux/clk.h>
 #include <linux/cpufreq.h>
 #include <linux/module.h>
+#include <linux/of.h>
 
 static struct cpufreq_frequency_table freq_table[] = {
 	{ .frequency = 216000 },
@@ -155,6 +156,9 @@ static int __init tegra_cpufreq_init(void)
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
