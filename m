From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 12/16] cpufreq: dt: Unsupported OPPs are already disabled
Date: Thu, 28 Jan 2016 13:50:41 +0530
Message-ID: <7da08f86234eacc6bd15025500537302ce736fc9.1453965717.git.viresh.kumar@linaro.org>
References: <cover.1453965717.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1453965717.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1453965717.git.viresh.kumar@linaro.org>
References: <cover.1453965717.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>, nm@ti.com, Viresh Kumar <viresh.kumar@linaro.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

The core already have a valid regulator set for the device opp and the
unsupported OPPs are already disabled by the core. There is no need to
repeat that in the user drivers, get rid of it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/cpufreq/cpufreq-dt.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index 15637734986a..ca7a930ea283 100644
--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -373,8 +373,6 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 					min_uV = opp_uV;
 				if (opp_uV > max_uV)
 					max_uV = opp_uV;
-			} else {
-				dev_pm_opp_disable(cpu_dev, opp_freq);
 			}
 
 			opp_freq++;
-- 
2.7.0.79.gdc08a19
