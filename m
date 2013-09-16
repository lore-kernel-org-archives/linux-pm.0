From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 Resend 20/44] cpufreq: maple: use cpufreq_table_validate_and_show()
Date: Mon, 16 Sep 2013 18:56:22 +0530
Message-ID: <c870b24835d92028403616bfcc4bd5b02f86bcc9.1379309339.git.viresh.kumar@linaro.org>
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

Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/maple-cpufreq.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/cpufreq/maple-cpufreq.c b/drivers/cpufreq/maple-cpufreq.c
index 6168d77..b3fb661 100644
--- a/drivers/cpufreq/maple-cpufreq.c
+++ b/drivers/cpufreq/maple-cpufreq.c
@@ -181,10 +181,8 @@ static int maple_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	 * cpufreq core if in the secondary policy we tell it that
 	 * it actually must be one policy together with all others. */
 	cpumask_setall(policy->cpus);
-	cpufreq_frequency_table_get_attr(maple_cpu_freqs, policy->cpu);
 
-	return cpufreq_frequency_table_cpuinfo(policy,
-		maple_cpu_freqs);
+	return cpufreq_table_validate_and_show(policy, maple_cpu_freqs);
 }
 
 
-- 
1.7.12.rc2.18.g61b472e

