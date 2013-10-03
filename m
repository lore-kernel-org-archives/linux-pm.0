From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 Resend 63/92] cpufreq: pxa: don't initialize part of policy that is set by core too
Date: Thu,  3 Oct 2013 20:28:57 +0530
Message-ID: <48f83e6db5013a0b4a021075c9f603886772957a.1380783079.git.viresh.kumar@linaro.org>
References: <cover.1380783079.git.viresh.kumar@linaro.org>
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <cover.1380783079.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1380783079.git.viresh.kumar@linaro.org>
References: <cover.1380783079.git.viresh.kumar@linaro.org>
Sender: cpufreq-owner@vger.kernel.org
To: rjw@sisk.pl
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, Eric Miao <eric.y.miao@gmail.com>
List-Id: linux-pm@vger.kernel.org

Many common initializations of struct policy are moved to core now and hence
this driver doesn't need to do it. This patch removes such code.

Most recent of those changes is to call ->get() in the core after calling
->init().

Cc: Eric Miao <eric.y.miao@gmail.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/pxa2xx-cpufreq.c | 2 --
 drivers/cpufreq/pxa3xx-cpufreq.c | 7 +++----
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/cpufreq/pxa2xx-cpufreq.c b/drivers/cpufreq/pxa2xx-cpufreq.c
index 82905fe..29aca57 100644
--- a/drivers/cpufreq/pxa2xx-cpufreq.c
+++ b/drivers/cpufreq/pxa2xx-cpufreq.c
@@ -397,8 +397,6 @@ static int pxa_cpufreq_init(struct cpufreq_policy *policy)
 
 	/* set default policy and cpuinfo */
 	policy->cpuinfo.transition_latency = 1000; /* FIXME: 1 ms, assumed */
-	policy->cur = get_clk_frequency_khz(0);	   /* current freq */
-	policy->min = policy->max = policy->cur;
 
 	/* Generate pxa25x the run cpufreq_frequency_table struct */
 	for (i = 0; i < NUM_PXA25x_RUN_FREQS; i++) {
diff --git a/drivers/cpufreq/pxa3xx-cpufreq.c b/drivers/cpufreq/pxa3xx-cpufreq.c
index ae3ac08..47fbee4 100644
--- a/drivers/cpufreq/pxa3xx-cpufreq.c
+++ b/drivers/cpufreq/pxa3xx-cpufreq.c
@@ -201,11 +201,10 @@ static int pxa3xx_cpufreq_init(struct cpufreq_policy *policy)
 	int ret = -EINVAL;
 
 	/* set default policy and cpuinfo */
-	policy->cpuinfo.min_freq = 104000;
-	policy->cpuinfo.max_freq = (cpu_is_pxa320()) ? 806000 : 624000;
+	policy->min = policy->cpuinfo.min_freq = 104000;
+	policy->max = policy->cpuinfo.max_freq =
+		(cpu_is_pxa320()) ? 806000 : 624000;
 	policy->cpuinfo.transition_latency = 1000; /* FIXME: 1 ms, assumed */
-	policy->max = pxa3xx_get_clk_frequency_khz(0);
-	policy->cur = policy->min = policy->max;
 
 	if (cpu_is_pxa300() || cpu_is_pxa310())
 		ret = setup_freqs_table(policy, pxa300_freqs,
-- 
1.7.12.rc2.18.g61b472e

