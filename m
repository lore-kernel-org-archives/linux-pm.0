From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 Resend 49/92] cpufreq: gx: don't initialize part of policy that is set by core too
Date: Thu,  3 Oct 2013 20:28:43 +0530
Message-ID: <a1db229d174e67a9f531325a3732589e88de1460.1380783079.git.viresh.kumar@linaro.org>
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
 drivers/cpufreq/gx-suspmod.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/cpufreq/gx-suspmod.c b/drivers/cpufreq/gx-suspmod.c
index 70442c7..d83e826 100644
--- a/drivers/cpufreq/gx-suspmod.c
+++ b/drivers/cpufreq/gx-suspmod.c
@@ -401,7 +401,7 @@ static int cpufreq_gx_target(struct cpufreq_policy *policy,
 
 static int cpufreq_gx_cpu_init(struct cpufreq_policy *policy)
 {
-	unsigned int maxfreq, curfreq;
+	unsigned int maxfreq;
 
 	if (!policy || policy->cpu != 0)
 		return -ENODEV;
@@ -415,10 +415,8 @@ static int cpufreq_gx_cpu_init(struct cpufreq_policy *policy)
 		maxfreq = 30000 * gx_freq_mult[getCx86(CX86_DIR1) & 0x0f];
 
 	stock_freq = maxfreq;
-	curfreq = gx_get_cpuspeed(0);
 
 	pr_debug("cpu max frequency is %d.\n", maxfreq);
-	pr_debug("cpu current frequency is %dkHz.\n", curfreq);
 
 	/* setup basic struct for cpufreq API */
 	policy->cpu = 0;
@@ -428,7 +426,6 @@ static int cpufreq_gx_cpu_init(struct cpufreq_policy *policy)
 	else
 		policy->min = maxfreq / POLICY_MIN_DIV;
 	policy->max = maxfreq;
-	policy->cur = curfreq;
 	policy->cpuinfo.min_freq = maxfreq / max_duration;
 	policy->cpuinfo.max_freq = maxfreq;
 	policy->cpuinfo.transition_latency = CPUFREQ_ETERNAL;
-- 
1.7.12.rc2.18.g61b472e

