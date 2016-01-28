From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 08/16] cpufreq: dt: Convert few pr_debug/err() calls to dev_dbg/err()
Date: Thu, 28 Jan 2016 13:50:37 +0530
Message-ID: <c42cdb571813168c9b553af56e4308dcf95f196a.1453965717.git.viresh.kumar@linaro.org>
References: <cover.1453965717.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1453965717.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1453965717.git.viresh.kumar@linaro.org>
References: <cover.1453965717.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>, nm@ti.com, Viresh Kumar <viresh.kumar@linaro.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

We have the device structure available now, lets use it for better print
messages.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/cpufreq/cpufreq-dt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index 0ca74d070058..ace0168274d4 100644
--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -246,7 +246,7 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 	 */
 	ret = dev_pm_opp_get_opp_count(cpu_dev);
 	if (ret <= 0) {
-		pr_debug("OPP table is not ready, deferring probe\n");
+		dev_dbg(cpu_dev, "OPP table is not ready, deferring probe\n");
 		ret = -EPROBE_DEFER;
 		goto out_free_opp;
 	}
@@ -325,7 +325,7 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 
 	ret = dev_pm_opp_init_cpufreq_table(cpu_dev, &freq_table);
 	if (ret) {
-		pr_err("failed to init cpufreq table: %d\n", ret);
+		dev_err(cpu_dev, "failed to init cpufreq table: %d\n", ret);
 		goto out_free_priv;
 	}
 
-- 
2.7.0.79.gdc08a19
