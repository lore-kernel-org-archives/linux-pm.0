From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 Resend 32/44] cpufreq: sc520: use cpufreq_table_validate_and_show()
Date: Mon, 16 Sep 2013 18:56:34 +0530
Message-ID: <1486bd2fd51ba9d009f36f367b0c4ed5b765d1f2.1379309339.git.viresh.kumar@linaro.org>
References: <cover.1379309339.git.viresh.kumar@linaro.org>
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <cover.1379309339.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1379309339.git.viresh.kumar@linaro.org>
References: <cover.1379309339.git.viresh.kumar@linaro.org>
Sender: cpufreq-owner@vger.kernel.org
To: rjw@sisk.pl
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org
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

