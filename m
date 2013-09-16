From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 Resend 35/44] cpufreq: spear: use cpufreq_table_validate_and_show()
Date: Mon, 16 Sep 2013 18:56:37 +0530
Message-ID: <e70f37817a6f54f07be7412a6fa4ab977db05af7.1379309339.git.viresh.kumar@linaro.org>
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

Cc: spear-devel@list.st.com
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/spear-cpufreq.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/spear-cpufreq.c b/drivers/cpufreq/spear-cpufreq.c
index 19e364fa..b86be6b 100644
--- a/drivers/cpufreq/spear-cpufreq.c
+++ b/drivers/cpufreq/spear-cpufreq.c
@@ -178,13 +178,12 @@ static int spear_cpufreq_init(struct cpufreq_policy *policy)
 {
 	int ret;
 
-	ret = cpufreq_frequency_table_cpuinfo(policy, spear_cpufreq.freq_tbl);
+	ret = cpufreq_table_validate_and_show(policy, spear_cpufreq.freq_tbl);
 	if (ret) {
-		pr_err("cpufreq_frequency_table_cpuinfo() failed");
+		pr_err("cpufreq_table_validate_and_show() failed");
 		return ret;
 	}
 
-	cpufreq_frequency_table_get_attr(spear_cpufreq.freq_tbl, policy->cpu);
 	policy->cpuinfo.transition_latency = spear_cpufreq.transition_latency;
 	policy->cur = spear_cpufreq_get(0);
 
-- 
1.7.12.rc2.18.g61b472e

