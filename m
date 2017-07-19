From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V3 3/9] cpufreq: Cap the default transition delay value to 10 ms
Date: Wed, 19 Jul 2017 15:42:43 +0530
Message-ID: <1b93c94cb8b4914314e4f50304c3cb11c53d8b14.1500373914.git.viresh.kumar@linaro.org>
References: <cover.1500373914.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f170.google.com ([209.85.192.170]:33585 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754078AbdGSKNV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 Jul 2017 06:13:21 -0400
Received: by mail-pf0-f170.google.com with SMTP id s70so16176198pfs.0
        for <linux-pm@vger.kernel.org>; Wed, 19 Jul 2017 03:13:20 -0700 (PDT)
In-Reply-To: <cover.1500373914.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1500373914.git.viresh.kumar@linaro.org>
References: <cover.1500373914.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, linux@dominikbrodowski.net, linux-kernel@vger.kernel.org

If transition_delay_us isn't defined by the cpufreq driver, the default
value of transition delay (time after which the cpufreq governor will
try updating the frequency again) is currently calculated by multiplying
transition_latency (nsec) with LATENCY_MULTIPLIER (1000) and then
converting this time to usec. That gives the exact same value as
transition_latency, just that the time unit is usec instead of nsec.

With acpi-cpufreq for example, transition_latency is set to around 10
usec and we get transition delay as 10 ms. Which seems to be a
reasonable amount of time to reevaluate the frequency again.

But for platforms where frequency switching isn't that fast (like ARM),
the transition_latency varies from 500 usec to 3 ms, and the transition
delay becomes 500 ms to 3 seconds. Of course, that is a pretty bad
default value to start with.

We can try to come across a better formula (instead of multiplying with
LATENCY_MULTIPLIER) to solve this problem, but will that be worth it ?

This patch tries a simple approach and caps the maximum value of default
transition delay to 10 ms. Of course, userspace can still come in and
change this value anytime or individual drivers can rather provide
transition_delay_us instead.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index c426d21822f7..d00cde871c15 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -532,8 +532,19 @@ unsigned int cpufreq_policy_transition_delay_us(struct cpufreq_policy *policy)
 		return policy->transition_delay_us;
 
 	latency = policy->cpuinfo.transition_latency / NSEC_PER_USEC;
-	if (latency)
-		return latency * LATENCY_MULTIPLIER;
+	if (latency) {
+		/*
+		 * For platforms that can change the frequency very fast (< 10
+		 * us), the above formula gives a decent transition delay. But
+		 * for platforms where transition_latency is in milliseconds, it
+		 * ends up giving unrealistic values.
+		 *
+		 * Cap the default transition delay to 10 ms, which seems to be
+		 * a reasonable amount of time after which we should reevaluate
+		 * the frequency.
+		 */
+		return min(latency * LATENCY_MULTIPLIER, (unsigned int)10000);
+	}
 
 	return LATENCY_MULTIPLIER;
 }
-- 
2.13.0.71.gd7076ec9c9cb
