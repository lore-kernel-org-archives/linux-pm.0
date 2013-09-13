From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 100/228] cpufreq: e_powersaver: don't initialize part of policy that is set by core too
Date: Fri, 13 Sep 2013 18:30:46 +0530
Message-ID: <7d15f2a318238d6f93cee5ac92c037fda902898e.1379063063.git.viresh.kumar@linaro.org>
References: <cover.1379063063.git.viresh.kumar@linaro.org>
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <cover.1379063063.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1379063063.git.viresh.kumar@linaro.org>
References: <cover.1379063063.git.viresh.kumar@linaro.org>
Sender: cpufreq-owner@vger.kernel.org
To: rjw@sisk.pl
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

Many common initializations of struct policy are moved to core now and hence
this driver doesn't need to do it. This patch removes such code.

Most recent of those changes is to call ->get() in the core after calling
->init().

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/e_powersaver.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/cpufreq/e_powersaver.c b/drivers/cpufreq/e_powersaver.c
index a8cbbd0..2c11ce3 100644
--- a/drivers/cpufreq/e_powersaver.c
+++ b/drivers/cpufreq/e_powersaver.c
@@ -395,7 +395,6 @@ static int eps_cpu_init(struct cpufreq_policy *policy)
 	}
 
 	policy->cpuinfo.transition_latency = 140000; /* 844mV -> 700mV in ns */
-	policy->cur = fsb * current_multiplier;
 
 	ret = cpufreq_table_validate_and_show(policy, &centaur->freq_table[0]);
 	if (ret) {
-- 
1.7.12.rc2.18.g61b472e

