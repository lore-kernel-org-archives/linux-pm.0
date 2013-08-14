From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 12/37] cpufreq: elanfreq: don't initialize part of policy that is set by core too
Date: Wed, 14 Aug 2013 19:02:01 +0530
Message-ID: <b4b51a254f4d78a59b511886d518a50bff0d3890.1376486713.git.viresh.kumar@linaro.org>
References: <cover.1376486713.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1376486713.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1376486713.git.viresh.kumar@linaro.org>
References: <cover.1376486713.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@sisk.pl
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

Many common initializations of struct policy are moved to core now and hence
this driver doesn't need to do it. This patch removes such code.

Most recent of those changes is to call ->get() in the core after calling
->init().

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/elanfreq.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/cpufreq/elanfreq.c b/drivers/cpufreq/elanfreq.c
index 0d133a7..4ab4153 100644
--- a/drivers/cpufreq/elanfreq.c
+++ b/drivers/cpufreq/elanfreq.c
@@ -179,7 +179,6 @@ static int elanfreq_cpu_init(struct cpufreq_policy *policy)
 
 	/* cpuinfo and default policy values */
 	policy->cpuinfo.transition_latency = CPUFREQ_ETERNAL;
-	policy->cur = elanfreq_get_cpu_frequency(0);
 
 	return cpufreq_table_validate_and_show(policy, elanfreq_table);
 }
-- 
1.7.12.rc2.18.g61b472e
