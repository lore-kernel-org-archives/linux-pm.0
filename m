From: Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH 1/2] cpufreq: imx6q: Register an Energy Model
Date: Wed,  6 Feb 2019 23:34:20 -0500
Message-ID: <20190207043420.3838-1-tiny.windzz@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, viresh.kumar@linaro.org, quentin.perret@arm.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
List-Id: linux-pm@vger.kernel.org

Try and register an Energy Model from imx6q-cpufreq to allow
interested subsystems like the task scheduler to use the provided
information.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/cpufreq/imx6q-cpufreq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
index 9fedf627e000..73bfd5bc3087 100644
--- a/drivers/cpufreq/imx6q-cpufreq.c
+++ b/drivers/cpufreq/imx6q-cpufreq.c
@@ -210,6 +210,7 @@ static int imx6q_cpufreq_init(struct cpufreq_policy *policy)
 	policy->clk = clks[ARM].clk;
 	ret = cpufreq_generic_init(policy, freq_table, transition_latency);
 	policy->suspend_freq = max_freq;
+	dev_pm_opp_of_register_em(policy->cpus);
 
 	return ret;
 }
-- 
2.17.0
