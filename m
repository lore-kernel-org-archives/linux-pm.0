From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 Resend 41/92] cpufreq: cpu0: don't initialize part of policy that is set by core too
Date: Thu,  3 Oct 2013 20:28:35 +0530
Message-ID: <fbb20ba98d8b17473c34e6798f1ab0ac8d9b5c0d.1380783079.git.viresh.kumar@linaro.org>
References: <cover.1380783079.git.viresh.kumar@linaro.org>
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <cover.1380783079.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1380783079.git.viresh.kumar@linaro.org>
References: <cover.1380783079.git.viresh.kumar@linaro.org>
Sender: cpufreq-owner@vger.kernel.org
To: rjw@sisk.pl
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, Shawn Guo <shawn.guo@linaro.org>
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
index ecea8fc..69c880f 100644
--- a/drivers/cpufreq/cpufreq-cpu0.c
+++ b/drivers/cpufreq/cpufreq-cpu0.c
@@ -131,7 +131,6 @@ static int cpu0_cpufreq_init(struct cpufreq_policy *policy)
 	}
 
 	policy->cpuinfo.transition_latency = transition_latency;
-	policy->cur = clk_get_rate(cpu_clk) / 1000;
 
 	/*
 	 * The driver only supports the SMP configuartion where all processors
-- 
1.7.12.rc2.18.g61b472e

