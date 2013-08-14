From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 21/37] cpufreq: maple: don't initialize part of policy that is set by core too
Date: Wed, 14 Aug 2013 19:02:10 +0530
Message-ID: <396e16342e6dd98cc5867b321b1a187171a85738.1376486713.git.viresh.kumar@linaro.org>
References: <cover.1376486713.git.viresh.kumar@linaro.org>
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <cover.1376486713.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1376486713.git.viresh.kumar@linaro.org>
References: <cover.1376486713.git.viresh.kumar@linaro.org>
Sender: cpufreq-owner@vger.kernel.org
To: rjw@sisk.pl
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
List-Id: linux-pm@vger.kernel.org

Many common initializations of struct policy are moved to core now and hence
this driver doesn't need to do it. This patch removes such code.

Most recent of those changes is to call ->get() in the core after calling
->init().

Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/maple-cpufreq.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/cpufreq/maple-cpufreq.c b/drivers/cpufreq/maple-cpufreq.c
index 1c24219..b508147 100644
--- a/drivers/cpufreq/maple-cpufreq.c
+++ b/drivers/cpufreq/maple-cpufreq.c
@@ -158,7 +158,6 @@ static unsigned int maple_cpufreq_get_speed(unsigned int cpu)
 static int maple_cpufreq_cpu_init(struct cpufreq_policy *policy)
 {
 	policy->cpuinfo.transition_latency = 12000;
-	policy->cur = maple_cpu_freqs[maple_scom_query_freq()].frequency;
 	/* secondary CPUs are tied to the primary one by the
 	 * cpufreq core if in the secondary policy we tell it that
 	 * it actually must be one policy together with all others. */
-- 
1.7.12.rc2.18.g61b472e

