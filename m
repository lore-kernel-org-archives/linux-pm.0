From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 Resend 41/44] cpufreq: blackfin: call cpufreq_frequency_table_put_attr()
Date: Mon, 16 Sep 2013 18:56:43 +0530
Message-ID: <0f8655802b96f84a7495f4bf4e795d72f3f40407.1379309339.git.viresh.kumar@linaro.org>
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

Cc: Steven Miao <realmz6@gmail.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/blackfin-cpufreq.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/cpufreq/blackfin-cpufreq.c b/drivers/cpufreq/blackfin-cpufreq.c
index 54c0a0c..0e76c09 100644
--- a/drivers/cpufreq/blackfin-cpufreq.c
+++ b/drivers/cpufreq/blackfin-cpufreq.c
@@ -213,6 +213,13 @@ static int __bfin_cpu_init(struct cpufreq_policy *policy)
 	return cpufreq_table_validate_and_show(policy, bfin_freq_table);
 }
 
+static int __bfin_cpu_exit(struct cpufreq_policy *policy)
+{
+
+	cpufreq_frequency_table_put_attr(policy->cpu);
+	return 0;
+}
+
 static struct freq_attr *bfin_freq_attr[] = {
 	&cpufreq_freq_attr_scaling_available_freqs,
 	NULL,
@@ -223,6 +230,7 @@ static struct cpufreq_driver bfin_driver = {
 	.target = bfin_target,
 	.get = bfin_getfreq_khz,
 	.init = __bfin_cpu_init,
+	.exit = __bfin_cpu_exit,
 	.name = "bfin cpufreq",
 	.attr = bfin_freq_attr,
 };
-- 
1.7.12.rc2.18.g61b472e

