From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 Resend 07/44] cpufreq: blackfin: use cpufreq_table_validate_and_show()
Date: Mon, 16 Sep 2013 18:56:09 +0530
Message-ID: <86fff8206754ca46c6820e767387aba907757449.1379309339.git.viresh.kumar@linaro.org>
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

Cc: Steven Miao <realmz6@gmail.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/blackfin-cpufreq.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/cpufreq/blackfin-cpufreq.c b/drivers/cpufreq/blackfin-cpufreq.c
index ef05978..54c0a0c 100644
--- a/drivers/cpufreq/blackfin-cpufreq.c
+++ b/drivers/cpufreq/blackfin-cpufreq.c
@@ -210,8 +210,7 @@ static int __bfin_cpu_init(struct cpufreq_policy *policy)
 	policy->cpuinfo.transition_latency = 50000; /* 50us assumed */
 
 	policy->cur = cclk;
-	cpufreq_frequency_table_get_attr(bfin_freq_table, policy->cpu);
-	return cpufreq_frequency_table_cpuinfo(policy, bfin_freq_table);
+	return cpufreq_table_validate_and_show(policy, bfin_freq_table);
 }
 
 static struct freq_attr *bfin_freq_attr[] = {
-- 
1.7.12.rc2.18.g61b472e

