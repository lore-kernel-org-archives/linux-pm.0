From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V3 09/16] cpufreq: dt: Rename 'need_update' to 'opp_v1'
Date: Tue,  9 Feb 2016 10:30:41 +0530
Message-ID: <0c0134371c6750bb3e85caa973ce6bcf33ac5d7a.1454992187.git.viresh.kumar@linaro.org>
References: <cover.1454992186.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1454992186.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1454992186.git.viresh.kumar@linaro.org>
References: <cover.1454992186.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>, nm@ti.com, Viresh Kumar <viresh.kumar@linaro.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

That's the real purpose of this field, i.e. to take special care of old
OPP V1 bindings. Lets name it accordingly, so that it can be used
elsewhere.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/cpufreq/cpufreq-dt.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index ace0168274d4..0047d20803db 100644
--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -199,7 +199,7 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 	struct dev_pm_opp *suspend_opp;
 	unsigned long min_uV = ~0, max_uV = 0;
 	unsigned int transition_latency;
-	bool need_update = false;
+	bool opp_v1 = false;
 	int ret;
 
 	ret = allocate_resources(policy->cpu, &cpu_dev, &cpu_reg, &cpu_clk);
@@ -223,7 +223,7 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 		 * finding shared-OPPs for backward compatibility.
 		 */
 		if (ret == -ENOENT)
-			need_update = true;
+			opp_v1 = true;
 		else
 			goto out_node_put;
 	}
@@ -251,7 +251,7 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 		goto out_free_opp;
 	}
 
-	if (need_update) {
+	if (opp_v1) {
 		struct cpufreq_dt_platform_data *pd = cpufreq_get_driver_data();
 
 		if (!pd || !pd->independent_clocks)
-- 
2.7.1.370.gb2aa7f8
