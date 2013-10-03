From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 Resend 46/92] cpufreq: e_powersaver: don't initialize part of policy that is set by core too
Date: Thu,  3 Oct 2013 20:28:40 +0530
Message-ID: <c5d755070e90df1503e4623334e903c768477c82.1380783079.git.viresh.kumar@linaro.org>
References: <cover.1380783079.git.viresh.kumar@linaro.org>
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <cover.1380783079.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1380783079.git.viresh.kumar@linaro.org>
References: <cover.1380783079.git.viresh.kumar@linaro.org>
Sender: cpufreq-owner@vger.kernel.org
To: rjw@sisk.pl
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>
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

