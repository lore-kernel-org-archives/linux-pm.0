From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 111/228] cpufreq: omap: don't initialize part of policy that is set by core too
Date: Fri, 13 Sep 2013 18:30:57 +0530
Message-ID: <0e74553073a6c4a0897b17c13cdd42c69bf4dd98.1379063063.git.viresh.kumar@linaro.org>
References: <cover.1379063063.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1379063063.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1379063063.git.viresh.kumar@linaro.org>
References: <cover.1379063063.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@sisk.pl
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Viresh Kumar <viresh.kumar@linaro.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>
List-Id: linux-pm@vger.kernel.org

Many common initializations of struct policy are moved to core now and hence
this driver doesn't need to do it. This patch removes such code.

Most recent of those changes is to call ->get() in the core after calling
->init().

Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/omap-cpufreq.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/cpufreq/omap-cpufreq.c b/drivers/cpufreq/omap-cpufreq.c
index 48020b5..a8c3f90 100644
--- a/drivers/cpufreq/omap-cpufreq.c
+++ b/drivers/cpufreq/omap-cpufreq.c
@@ -171,8 +171,6 @@ static int omap_cpu_init(struct cpufreq_policy *policy)
 		goto fail_ck;
 	}
 
-	policy->cur = omap_getspeed(policy->cpu);
-
 	if (!freq_table)
 		result = opp_init_cpufreq_table(mpu_dev, &freq_table);
 
@@ -188,8 +186,6 @@ static int omap_cpu_init(struct cpufreq_policy *policy)
 	if (result)
 		goto fail_table;
 
-	policy->cur = omap_getspeed(policy->cpu);
-
 	/*
 	 * On OMAP SMP configuartion, both processors share the voltage
 	 * and clock. So both CPUs needs to be scaled together and hence
-- 
1.7.12.rc2.18.g61b472e
