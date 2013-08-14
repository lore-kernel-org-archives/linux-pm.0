From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 27/37] cpufreq: ppc: don't initialize part of policy that is set by core too
Date: Wed, 14 Aug 2013 19:02:16 +0530
Message-ID: <6d1a3aaecc51dddffbad4dbf792df4ad238a9c5d.1376486713.git.viresh.kumar@linaro.org>
References: <cover.1376486713.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1376486713.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1376486713.git.viresh.kumar@linaro.org>
References: <cover.1376486713.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@sisk.pl
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

Many common initializations of struct policy are moved to core now and hence
this driver doesn't need to do it. This patch removes such code.

Most recent of those changes is to call ->get() in the core after calling
->init().

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/ppc-corenet-cpufreq.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/cpufreq/ppc-corenet-cpufreq.c b/drivers/cpufreq/ppc-corenet-cpufreq.c
index 243a396..79d8e9c 100644
--- a/drivers/cpufreq/ppc-corenet-cpufreq.c
+++ b/drivers/cpufreq/ppc-corenet-cpufreq.c
@@ -217,8 +217,6 @@ static int corenet_cpufreq_cpu_init(struct cpufreq_policy *policy)
 		per_cpu(cpu_data, i) = data;
 
 	policy->cpuinfo.transition_latency = CPUFREQ_ETERNAL;
-	policy->cur = corenet_cpufreq_get_speed(policy->cpu);
-
 	of_node_put(np);
 
 	return 0;
-- 
1.7.12.rc2.18.g61b472e
