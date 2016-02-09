From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V3 12/16] cpufreq: dt: Unsupported OPPs are already disabled
Date: Tue,  9 Feb 2016 10:30:44 +0530
Message-ID: <8289810f97c9350ccb49bbb5b1736d4a5ce1b5fd.1454992187.git.viresh.kumar@linaro.org>
References: <cover.1454992186.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1454992186.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1454992186.git.viresh.kumar@linaro.org>
References: <cover.1454992186.git.viresh.kumar@linaro.org>
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
index 2af75f8088bb..c3fe89461ff4 100644
--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -349,8 +349,6 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 					min_uV = opp_uV;
 				if (opp_uV > max_uV)
 					max_uV = opp_uV;
-			} else {
-				dev_pm_opp_disable(cpu_dev, opp_freq);
 			}
 
 			opp_freq++;
-- 
2.7.1.370.gb2aa7f8
