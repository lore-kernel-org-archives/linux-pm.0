From: Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH v2] cpufreq: tegra124: add missing of_node_put()
Date: Mon,  4 Feb 2019 02:48:54 -0500
Message-ID: <20190204074854.1538-1-tiny.windzz@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, viresh.kumar@linaro.org, thierry.reding@gmail.com, jonathanh@nvidia.com
Cc: linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
List-Id: linux-pm@vger.kernel.org

of_cpu_device_node_get() will increase the refcount of device_node,
it is necessary to call of_node_put() at the end to release the
refcount.

Fixes: 9eb15dbbfa1a2 ("cpufreq: Add cpufreq driver for Tegra124")
Cc: <stable@vger.kernel.org> # 4.4+
Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
v2:
- move of_node_put() to the very end
---
 drivers/cpufreq/tegra124-cpufreq.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/cpufreq/tegra124-cpufreq.c b/drivers/cpufreq/tegra124-cpufreq.c
index 43530254201a..4bb154f6c54c 100644
--- a/drivers/cpufreq/tegra124-cpufreq.c
+++ b/drivers/cpufreq/tegra124-cpufreq.c
@@ -134,6 +134,8 @@ static int tegra124_cpufreq_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, priv);
 
+	of_node_put(np);
+
 	return 0;
 
 out_switch_to_pllx:
-- 
2.17.0
