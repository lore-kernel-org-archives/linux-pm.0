From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 Resend 10/44] cpufreq: davinci: use cpufreq_table_validate_and_show()
Date: Mon, 16 Sep 2013 18:56:12 +0530
Message-ID: <98f52eca19183cd96014dd4c011f2442d55458d3.1379309339.git.viresh.kumar@linaro.org>
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

Cc: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/davinci-cpufreq.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/davinci-cpufreq.c b/drivers/cpufreq/davinci-cpufreq.c
index 551dd65..f67196e 100644
--- a/drivers/cpufreq/davinci-cpufreq.c
+++ b/drivers/cpufreq/davinci-cpufreq.c
@@ -140,15 +140,13 @@ static int davinci_cpu_init(struct cpufreq_policy *policy)
 
 	policy->cur = davinci_getspeed(0);
 
-	result = cpufreq_frequency_table_cpuinfo(policy, freq_table);
+	result = cpufreq_table_validate_and_show(policy, freq_table);
 	if (result) {
-		pr_err("%s: cpufreq_frequency_table_cpuinfo() failed",
+		pr_err("%s: cpufreq_table_validate_and_show() failed",
 				__func__);
 		return result;
 	}
 
-	cpufreq_frequency_table_get_attr(freq_table, policy->cpu);
-
 	/*
 	 * Time measurement across the target() function yields ~1500-1800us
 	 * time taken with no drivers on notification list.
-- 
1.7.12.rc2.18.g61b472e

