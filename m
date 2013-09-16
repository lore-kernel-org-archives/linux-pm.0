From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 Resend 11/44] cpufreq: dbx500: use cpufreq_table_validate_and_show()
Date: Mon, 16 Sep 2013 18:56:13 +0530
Message-ID: <27b2a78326db19188874de244b0f81d7dd36d8de.1379309339.git.viresh.kumar@linaro.org>
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

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/dbx500-cpufreq.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/dbx500-cpufreq.c b/drivers/cpufreq/dbx500-cpufreq.c
index 26321cd..8a484e9 100644
--- a/drivers/cpufreq/dbx500-cpufreq.c
+++ b/drivers/cpufreq/dbx500-cpufreq.c
@@ -87,10 +87,8 @@ static int dbx500_cpufreq_init(struct cpufreq_policy *policy)
 	int res;
 
 	/* get policy fields based on the table */
-	res = cpufreq_frequency_table_cpuinfo(policy, freq_table);
-	if (!res)
-		cpufreq_frequency_table_get_attr(freq_table, policy->cpu);
-	else {
+	res = cpufreq_table_validate_and_show(policy, freq_table);
+	if (res) {
 		pr_err("dbx500-cpufreq: Failed to read policy table\n");
 		return res;
 	}
-- 
1.7.12.rc2.18.g61b472e

