From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [RFC V2 5/6] cpufreq: Cap the default transition delay value to 10 ms
Date: Thu, 13 Jul 2017 11:10:56 +0530
Message-ID: <6534daba87803a0f2a14c385a20cbb416fe6cbd8.1499853492.git.viresh.kumar@linaro.org>
References: <cover.1499853492.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f47.google.com ([74.125.83.47]:35400 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750940AbdGMFlp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Jul 2017 01:41:45 -0400
Received: by mail-pg0-f47.google.com with SMTP id j186so24052235pge.2
        for <linux-pm@vger.kernel.org>; Wed, 12 Jul 2017 22:41:45 -0700 (PDT)
In-Reply-To: <cover.1499853492.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1499853492.git.viresh.kumar@linaro.org>
References: <cover.1499853492.git.viresh.kumar@linaro.org>
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
 include/linux/cpufreq.h | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 14f0ab61ed17..f691ec2793c0 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -544,7 +544,17 @@ cpufreq_policy_transition_delay_us(struct cpufreq_policy *policy)
 	if (latency)
 		delay_us *= latency;
 
-	return delay_us;
+	/*
+	 * For platforms that can change the frequency very fast (< 10 us),
+	 * the above formula gives a decent transition delay. But for platforms
+	 * where transition_latency is in milliseconds, it ends up giving
+	 * unrealistic values.
+	 *
+	 * Cap the default transition delay to 10 ms, which seems to be a
+	 * reasonable amount of time after which we should reevaluate the
+	 * frequency.
+	 */
+	return min(delay_us, (unsigned int)10000);
 }
 
 /* Governor attribute set */
-- 
2.13.0.71.gd7076ec9c9cb
