From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 2/5] cpufreq: send new set of notification for transition failures
Date: Sat, 30 Nov 2013 21:26:20 +0530
Message-ID: <4834ba7f5ae3838515f7b85102987cc3ec066627.1385826776.git.viresh.kumar@linaro.org>
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

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index a862aa9..557bb49 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1764,17 +1764,8 @@ int __cpufreq_driver_target(struct cpufreq_policy *policy,
 			pr_err("%s: Failed to change cpu frequency: %d\n",
 					__func__, retval);
 
-		if (notify) {
-			/*
-			 * Notify with old freq in case we failed to change
-			 * frequency
-			 */
-			if (retval)
-				freqs.new = freqs.old;
-
-			cpufreq_notify_transition(policy, &freqs,
-					CPUFREQ_POSTCHANGE);
-		}
+		if (notify)
+			cpufreq_notify_post_transition(policy, &freqs, retval);
 	}
 
 out:
-- 
1.7.12.rc2.18.g61b472e

