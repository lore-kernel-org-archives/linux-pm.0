From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 Resend 43/44] cpufreq: loongson2: call cpufreq_frequency_table_put_attr()
Date: Mon, 16 Sep 2013 18:56:45 +0530
Message-ID: <b71fc27f6b014a9222952e686c1041d429c5a845.1379309339.git.viresh.kumar@linaro.org>
References: <cover.1379309339.git.viresh.kumar@linaro.org>
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <cover.1379309339.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1379309339.git.viresh.kumar@linaro.org>
References: <cover.1379309339.git.viresh.kumar@linaro.org>
Sender: cpufreq-owner@vger.kernel.org
To: rjw@sisk.pl
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Drivers which have an exit path must call cpufreq_frequency_table_put_attr() if
they have called cpufreq_frequency_table_get_attr() in their init path.

This driver was missing this part and is fixed with this patch.

Cc: John Crispin <blogic@openwrt.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/loongson2_cpufreq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/loongson2_cpufreq.c b/drivers/cpufreq/loongson2_cpufreq.c
index 5dd3692..cec4e72 100644
--- a/drivers/cpufreq/loongson2_cpufreq.c
+++ b/drivers/cpufreq/loongson2_cpufreq.c
@@ -145,6 +145,7 @@ static int loongson2_cpufreq_verify(struct cpufreq_policy *policy)
 
 static int loongson2_cpufreq_exit(struct cpufreq_policy *policy)
 {
+	cpufreq_frequency_table_put_attr(policy->cpu);
 	clk_put(cpuclk);
 	return 0;
 }
-- 
1.7.12.rc2.18.g61b472e

