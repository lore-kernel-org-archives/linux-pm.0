From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 Resend 33/44] cpufreq: sh: use cpufreq_table_validate_and_show()
Date: Mon, 16 Sep 2013 18:56:35 +0530
Message-ID: <5806900685a8c866089f385a17bd049cceaa696e.1379309339.git.viresh.kumar@linaro.org>
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

Cc: Paul Mundt <lethal@linux-sh.org>
Cc: linux-sh@vger.kernel.org
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/sh-cpufreq.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/sh-cpufreq.c b/drivers/cpufreq/sh-cpufreq.c
index ffc6d24..1362e88 100644
--- a/drivers/cpufreq/sh-cpufreq.c
+++ b/drivers/cpufreq/sh-cpufreq.c
@@ -120,9 +120,9 @@ static int sh_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	if (freq_table) {
 		int result;
 
-		result = cpufreq_frequency_table_cpuinfo(policy, freq_table);
-		if (!result)
-			cpufreq_frequency_table_get_attr(freq_table, cpu);
+		result = cpufreq_table_validate_and_show(policy, freq_table);
+		if (result)
+			return result;
 	} else {
 		dev_notice(dev, "no frequency table found, falling back "
 			   "to rate rounding.\n");
-- 
1.7.12.rc2.18.g61b472e

