From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 30/35] cpufreq: sc520: use cpufreq_table_validate_and_show()
Date: Thu,  8 Aug 2013 19:18:32 +0530
Message-ID: <8d7ce27a8756d11c8aeefc9f106436a01b8b8289.1375964117.git.viresh.kumar@linaro.org>
References: <cover.1375964117.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1375964117.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1375964117.git.viresh.kumar@linaro.org>
References: <cover.1375964117.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@sisk.pl
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

Lets use cpufreq_table_validate_and_show() instead of calling
cpufreq_frequency_table_cpuinfo() and cpufreq_frequency_table_get_attr().

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/sc520_freq.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/cpufreq/sc520_freq.c b/drivers/cpufreq/sc520_freq.c
index d6f6c6f..bb9c0de 100644
--- a/drivers/cpufreq/sc520_freq.c
+++ b/drivers/cpufreq/sc520_freq.c
@@ -106,7 +106,6 @@ static int sc520_freq_target(struct cpufreq_policy *policy,
 static int sc520_freq_cpu_init(struct cpufreq_policy *policy)
 {
 	struct cpuinfo_x86 *c = &cpu_data(0);
-	int result;
 
 	/* capability check */
 	if (c->x86_vendor != X86_VENDOR_AMD ||
@@ -117,13 +116,7 @@ static int sc520_freq_cpu_init(struct cpufreq_policy *policy)
 	policy->cpuinfo.transition_latency = 1000000; /* 1ms */
 	policy->cur = sc520_freq_get_cpu_frequency(0);
 
-	result = cpufreq_frequency_table_cpuinfo(policy, sc520_freq_table);
-	if (result)
-		return result;
-
-	cpufreq_frequency_table_get_attr(sc520_freq_table, policy->cpu);
-
-	return 0;
+	return cpufreq_table_validate_and_show(policy, sc520_freq_table);
 }
 
 
-- 
1.7.12.rc2.18.g61b472e
