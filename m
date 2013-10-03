From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 Resend 53/92] cpufreq: kirkwood: don't initialize part of policy that is set by core too
Date: Thu,  3 Oct 2013 20:28:47 +0530
Message-ID: <f7b89aa5047d41f90864e5eb8b618ea19f2b7bb0.1380783079.git.viresh.kumar@linaro.org>
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

Tested-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/kirkwood-cpufreq.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/cpufreq/kirkwood-cpufreq.c b/drivers/cpufreq/kirkwood-cpufreq.c
index 1a4e4f4..dc434c4 100644
--- a/drivers/cpufreq/kirkwood-cpufreq.c
+++ b/drivers/cpufreq/kirkwood-cpufreq.c
@@ -122,7 +122,6 @@ static int kirkwood_cpufreq_cpu_init(struct cpufreq_policy *policy)
 {
 	/* cpuinfo and default policy values */
 	policy->cpuinfo.transition_latency = 5000; /* 5uS */
-	policy->cur = kirkwood_cpufreq_get_cpu_frequency(0);
 
 	return cpufreq_table_validate_and_show(policy, kirkwood_freq_table);
 }
-- 
1.7.12.rc2.18.g61b472e

