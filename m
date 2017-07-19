From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V3 9/9] cpufreq: Allow dynamic switching with CPUFREQ_ETERNAL latency
Date: Wed, 19 Jul 2017 15:42:49 +0530
Message-ID: <a23708f8ff62f55ef6b8e67792224655c39b9786.1500373914.git.viresh.kumar@linaro.org>
References: <cover.1500373914.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1500373914.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1500373914.git.viresh.kumar@linaro.org>
References: <cover.1500373914.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, linux@dominikbrodowski.net, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

With the recent updates, CPUFREQ_ETERNAL is only used by the drivers
which don't know their transition latency but want to use dynamic
switching.

Anyway, the routine cpufreq_policy_transition_delay_us() caps the value
of transition latency to 10 ms now and that can be used safely with such
platforms.

Remove the check from cpufreq_init_governor() and allow dynamic
switching for such configurations as well.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index a4d9b47c4af4..c7ae67d6886d 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2016,8 +2016,7 @@ static int cpufreq_init_governor(struct cpufreq_policy *policy)
 
 	/* Platform doesn't want dynamic frequency switching ? */
 	if (policy->governor->dynamic_switching &&
-	    (cpufreq_driver->flags & CPUFREQ_NO_AUTO_DYNAMIC_SWITCHING ||
-	    policy->cpuinfo.transition_latency == CPUFREQ_ETERNAL)) {
+	    cpufreq_driver->flags & CPUFREQ_NO_AUTO_DYNAMIC_SWITCHING) {
 		struct cpufreq_governor *gov = cpufreq_fallback_governor();
 
 		if (gov) {
-- 
2.13.0.71.gd7076ec9c9cb
