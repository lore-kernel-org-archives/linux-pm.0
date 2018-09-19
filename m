From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 08/12] cpufreq: mvebu: Remove OPPs using dev_pm_opp_remove()
Date: Wed, 19 Sep 2018 15:20:27 -0700
Message-ID: <883071c4bd9a6e45bf0b5e45575d110eaeb2e6d0.1537394233.git.viresh.kumar@linaro.org>
References: <cover.1537394233.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1537394233.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1537394233.git.viresh.kumar@linaro.org>
References: <cover.1537394233.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@bootlin.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>, Vincent Guittot <vincent.guittot@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

dev_pm_opp_cpumask_remove_table() is going to change in the next commit
and will not remove dynamic OPPs automatically. They must be removed
with a call to dev_pm_opp_remove().

Reviewed-by: Gregory CLEMENT <gregory.clement@bootlin.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/mvebu-cpufreq.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/cpufreq/mvebu-cpufreq.c b/drivers/cpufreq/mvebu-cpufreq.c
index 31513bd42705..6d33a639f902 100644
--- a/drivers/cpufreq/mvebu-cpufreq.c
+++ b/drivers/cpufreq/mvebu-cpufreq.c
@@ -84,9 +84,10 @@ static int __init armada_xp_pmsu_cpufreq_init(void)
 
 		ret = dev_pm_opp_add(cpu_dev, clk_get_rate(clk) / 2, 0);
 		if (ret) {
+			dev_pm_opp_remove(cpu_dev, clk_get_rate(clk));
 			clk_put(clk);
 			dev_err(cpu_dev, "Failed to register OPPs\n");
-			goto opp_register_failed;
+			return ret;
 		}
 
 		ret = dev_pm_opp_set_sharing_cpus(cpu_dev,
@@ -99,11 +100,5 @@ static int __init armada_xp_pmsu_cpufreq_init(void)
 
 	platform_device_register_simple("cpufreq-dt", -1, NULL, 0);
 	return 0;
-
-opp_register_failed:
-	/* As registering has failed remove all the opp for all cpus */
-	dev_pm_opp_cpumask_remove_table(cpu_possible_mask);
-
-	return ret;
 }
 device_initcall(armada_xp_pmsu_cpufreq_init);
-- 
2.14.1
