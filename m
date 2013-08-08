From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 19/35] cpufreq: loongson2: use cpufreq_table_validate_and_show()
Date: Thu,  8 Aug 2013 19:18:21 +0530
Message-ID: <cf13095eb15c28e5fb4ab90277833aceb301f0b2.1375964117.git.viresh.kumar@linaro.org>
References: <cover.1375964117.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1375964117.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1375964117.git.viresh.kumar@linaro.org>
References: <cover.1375964117.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@sisk.pl
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Viresh Kumar <viresh.kumar@linaro.org>, John Crispin <blogic@openwrt.org>
List-Id: linux-pm@vger.kernel.org

Lets use cpufreq_table_validate_and_show() instead of calling
cpufreq_frequency_table_cpuinfo() and cpufreq_frequency_table_get_attr().

Cc: John Crispin <blogic@openwrt.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/loongson2_cpufreq.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/cpufreq/loongson2_cpufreq.c b/drivers/cpufreq/loongson2_cpufreq.c
index 7bc3c44..5dd3692 100644
--- a/drivers/cpufreq/loongson2_cpufreq.c
+++ b/drivers/cpufreq/loongson2_cpufreq.c
@@ -133,10 +133,7 @@ static int loongson2_cpufreq_cpu_init(struct cpufreq_policy *policy)
 
 	policy->cur = loongson2_cpufreq_get(policy->cpu);
 
-	cpufreq_frequency_table_get_attr(&loongson2_clockmod_table[0],
-					 policy->cpu);
-
-	return cpufreq_frequency_table_cpuinfo(policy,
+	return cpufreq_table_validate_and_show(policy,
 					    &loongson2_clockmod_table[0]);
 }
 
-- 
1.7.12.rc2.18.g61b472e
