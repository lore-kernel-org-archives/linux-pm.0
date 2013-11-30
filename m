From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 5/5] cpufreq: unicore2: send new set of notification for transition failures
Date: Sat, 30 Nov 2013 21:26:23 +0530
Message-ID: <c7a31a2ec1769e69c94b5713a317e58ef73ceab1.1385826776.git.viresh.kumar@linaro.org>
References: <0d635c6701654a75f6d25dd435705dc1ede3e19c.1385826776.git.viresh.kumar@linaro.org>
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <0d635c6701654a75f6d25dd435705dc1ede3e19c.1385826776.git.viresh.kumar@linaro.org>
In-Reply-To: <0d635c6701654a75f6d25dd435705dc1ede3e19c.1385826776.git.viresh.kumar@linaro.org>
References: <0d635c6701654a75f6d25dd435705dc1ede3e19c.1385826776.git.viresh.kumar@linaro.org>
Sender: cpufreq-owner@vger.kernel.org
To: rjw@rjwysocki.net
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

In the current code, if we fail during a frequency transition we simply send the
POSTCHANGE notification with old frequency. This isn't enough.

One of the core user of these notifications is the code responsible for keeping
loops_per_jiffy aligned with frequency change. And mostly it is written as:

	if ((val == CPUFREQ_PRECHANGE  && freq->old < freq->new) ||
	    (val == CPUFREQ_POSTCHANGE && freq->old > freq->new)) {
		update-loops-per-jiffy...
	}

So, suppose we are changing to a higher frequency and failed during transition,
then following will happen:
- CPUFREQ_PRECHANGE notification with freq-new > freq-old
- CPUFREQ_POSTCHANGE notification with freq-new == freq-old

The first one will update loops_per_jiffy and second one will do nothing. Even
if we send the 2nd notification by exchanging values of freq-new and old, some
users of these notifications might get unstable.

This can be fixed by simply calling cpufreq_notify_post_transition() with error
code and this routine will take care of sending notifications in correct order.

Also it returns a proper error message in case frequency transition failed.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/unicore2-cpufreq.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/cpufreq/unicore2-cpufreq.c b/drivers/cpufreq/unicore2-cpufreq.c
index 653ae29..3e79dae 100644
--- a/drivers/cpufreq/unicore2-cpufreq.c
+++ b/drivers/cpufreq/unicore2-cpufreq.c
@@ -49,17 +49,16 @@ static int ucv2_target(struct cpufreq_policy *policy,
 	unsigned int cur = ucv2_getspeed(0);
 	struct cpufreq_freqs freqs;
 	struct clk *mclk = clk_get(NULL, "MAIN_CLK");
+	int ret;
 
-	cpufreq_notify_transition(policy, &freqs, CPUFREQ_PRECHANGE);
-
-	if (!clk_set_rate(mclk, target_freq * 1000)) {
-		freqs.old = cur;
-		freqs.new = target_freq;
-	}
+	freqs.old = cur;
+	freqs.new = target_freq;
 
-	cpufreq_notify_transition(policy, &freqs, CPUFREQ_POSTCHANGE);
+	cpufreq_notify_transition(policy, &freqs, CPUFREQ_PRECHANGE);
+	ret = clk_set_rate(mclk, target_freq * 1000);
+	cpufreq_notify_post_transition(policy, &freqs, ret);
 
-	return 0;
+	return ret;
 }
 
 static int __init ucv2_cpu_init(struct cpufreq_policy *policy)
-- 
1.7.12.rc2.18.g61b472e

