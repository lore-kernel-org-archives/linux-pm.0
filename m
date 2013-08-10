From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 06/44] cpufreq: pxa: call cpufreq_frequency_table_put_attr()
Date: Sat, 10 Aug 2013 12:14:02 +0530
Message-ID: <7c7aeda55d9ea8f37de016fd2fd0c78d901082d9.1376116345.git.viresh.kumar@linaro.org>
References: <cover.1376116344.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1376116344.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1376116344.git.viresh.kumar@linaro.org>
References: <cover.1376116344.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@sisk.pl
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, Eric Miao <eric.y.miao@gmail.com>
List-Id: linux-pm@vger.kernel.org

Drivers which have an exit path must call cpufreq_frequency_table_put_attr() if
they have called cpufreq_frequency_table_get_attr() in their init path.

This driver was missing this part and is fixed with this patch.

Cc: Eric Miao <eric.y.miao@gmail.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/pxa2xx-cpufreq.c | 6 ++++++
 drivers/cpufreq/pxa3xx-cpufreq.c | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/cpufreq/pxa2xx-cpufreq.c b/drivers/cpufreq/pxa2xx-cpufreq.c
index a429d7c..06af29c 100644
--- a/drivers/cpufreq/pxa2xx-cpufreq.c
+++ b/drivers/cpufreq/pxa2xx-cpufreq.c
@@ -465,10 +465,16 @@ static int pxa_cpufreq_init(struct cpufreq_policy *policy)
 	return 0;
 }
 
+static int pxa_cpufreq_exit(struct cpufreq_policy *policy)
+{
+	cpufreq_frequency_table_put_attr(policy->cpu);
+}
+
 static struct cpufreq_driver pxa_cpufreq_driver = {
 	.verify	= pxa_verify_policy,
 	.target	= pxa_set_target,
 	.init	= pxa_cpufreq_init,
+	.exit	= pxa_cpufreq_exit,
 	.get	= pxa_cpufreq_get,
 	.name	= "PXA2xx",
 };
diff --git a/drivers/cpufreq/pxa3xx-cpufreq.c b/drivers/cpufreq/pxa3xx-cpufreq.c
index 89841f5..1cc145a 100644
--- a/drivers/cpufreq/pxa3xx-cpufreq.c
+++ b/drivers/cpufreq/pxa3xx-cpufreq.c
@@ -227,10 +227,16 @@ static int pxa3xx_cpufreq_init(struct cpufreq_policy *policy)
 	return 0;
 }
 
+static int pxa3xx_cpufreq_exit(struct cpufreq_policy *policy)
+{
+	cpufreq_frequency_table_put_attr(policy->cpu);
+}
+
 static struct cpufreq_driver pxa3xx_cpufreq_driver = {
 	.verify		= pxa3xx_cpufreq_verify,
 	.target		= pxa3xx_cpufreq_set,
 	.init		= pxa3xx_cpufreq_init,
+	.exit		= pxa3xx_cpufreq_exit,
 	.get		= pxa3xx_cpufreq_get,
 	.name		= "pxa3xx-cpufreq",
 };
-- 
1.7.12.rc2.18.g61b472e
