From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 5/6] cpufreq: Cap the default transition delay value to 10 ms
Date: Thu, 29 Jun 2017 16:29:08 +0530
Message-ID: <1626e6781865d68bd0e666ec941048a9a6166156.1498733506.git.viresh.kumar@linaro.org>
References: <cover.1498733506.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1498733506.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1498733506.git.viresh.kumar@linaro.org>
References: <cover.1498733506.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

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
index dee6fe3d8af0..cf1faba29113 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -541,7 +541,17 @@ cpufreq_policy_transition_delay_us(struct cpufreq_policy *policy)
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
