From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 06/37] cpufreq: cpu0: don't initialize part of policy that is set by core too
Date: Wed, 14 Aug 2013 19:01:55 +0530
Message-ID: <a696e50d20d7f062c94783d063085ef78bdd29dc.1376486713.git.viresh.kumar@linaro.org>
References: <cover.1376486713.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1376486713.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1376486713.git.viresh.kumar@linaro.org>
References: <cover.1376486713.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@sisk.pl
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, Shawn Guo <shawn.guo@linaro.org>
List-Id: linux-pm@vger.kernel.org

Many common initializations of struct policy are moved to core now and hence
this driver doesn't need to do it. This patch removes such code.

Most recent of those changes is to call ->get() in the core after calling
->init().

Cc: Shawn Guo <shawn.guo@linaro.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq-cpu0.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq-cpu0.c b/drivers/cpufreq/cpufreq-cpu0.c
index 000da22..4014925 100644
--- a/drivers/cpufreq/cpufreq-cpu0.c
+++ b/drivers/cpufreq/cpufreq-cpu0.c
@@ -117,7 +117,6 @@ static int cpu0_cpufreq_init(struct cpufreq_policy *policy)
 	}
 
 	policy->cpuinfo.transition_latency = transition_latency;
-	policy->cur = clk_get_rate(cpu_clk) / 1000;
 
 	/*
 	 * The driver only supports the SMP configuartion where all processors
-- 
1.7.12.rc2.18.g61b472e
