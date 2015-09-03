From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH] cpufreq: staticize cpufreq_cpu_get_raw()
Date: Thu,  3 Sep 2015 12:15:21 +0530
Message-ID: <f0d2bc91e14b0960e131d93fbfa4750bfbb07151.1441262710.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

cpufreq_cpu_get_raw() isn't used by any external users, staticize it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index b3d9368339af..a23c641a0239 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -239,7 +239,7 @@ int cpufreq_generic_init(struct cpufreq_policy *policy,
 EXPORT_SYMBOL_GPL(cpufreq_generic_init);
 
 /* Only for cpufreq core internal use */
-struct cpufreq_policy *cpufreq_cpu_get_raw(unsigned int cpu)
+static struct cpufreq_policy *cpufreq_cpu_get_raw(unsigned int cpu)
 {
 	struct cpufreq_policy *policy = per_cpu(cpufreq_cpu_data, cpu);
 
-- 
2.4.0
