From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 131/228] cpufreq: davinci: use cpufreq_generic_init() routine
Date: Fri, 13 Sep 2013 18:31:17 +0530
Message-ID: <a324c5d31baeda64af96ce09f612bb14c3f8dbff.1379063063.git.viresh.kumar@linaro.org>
References: <cover.1379063063.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1379063063.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1379063063.git.viresh.kumar@linaro.org>
References: <cover.1379063063.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@sisk.pl
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Viresh Kumar <viresh.kumar@linaro.org>, Sekhar Nori <nsekhar@ti.com>
List-Id: linux-pm@vger.kernel.org

Use generic cpufreq_generic_init() routine instead of replicating the same code
here.

Cc: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/davinci-cpufreq.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/cpufreq/davinci-cpufreq.c b/drivers/cpufreq/davinci-cpufreq.c
index 55cf094..972583b 100644
--- a/drivers/cpufreq/davinci-cpufreq.c
+++ b/drivers/cpufreq/davinci-cpufreq.c
@@ -136,21 +136,13 @@ static int davinci_cpu_init(struct cpufreq_policy *policy)
 			return result;
 	}
 
-	result = cpufreq_table_validate_and_show(policy, freq_table);
-	if (result) {
-		pr_err("%s: cpufreq_table_validate_and_show() failed",
-				__func__);
-		return result;
-	}
-
 	/*
 	 * Time measurement across the target() function yields ~1500-1800us
 	 * time taken with no drivers on notification list.
 	 * Setting the latency to 2000 us to accommodate addition of drivers
 	 * to pre/post change notification list.
 	 */
-	policy->cpuinfo.transition_latency = 2000 * 1000;
-	return 0;
+	return cpufreq_generic_init(policy, freq_table, 2000 * 1000);
 }
 
 static struct cpufreq_driver davinci_driver = {
-- 
1.7.12.rc2.18.g61b472e
