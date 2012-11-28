From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: [PATCH 4/5] cpufreq: dbx500: Minor code cleanup
Date: Wed, 28 Nov 2012 11:27:43 +0100
Message-ID: <1354098464-6665-5-git-send-email-ulf.hansson@stericsson.com>
References: <1354098464-6665-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from eu1sys200aog111.obsmtp.com ([207.126.144.131]:38288 "EHLO
	eu1sys200aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753572Ab2K1K2b (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 28 Nov 2012 05:28:31 -0500
In-Reply-To: <1354098464-6665-1-git-send-email-ulf.hansson@stericsson.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Lee Jones <lee.jones@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Rickard Andersson <rickard.andersson@stericsson.com>, Jonas Aberg <jonas.aberg@stericsson.com>, Vincent Guittot <vincent.guittot@linaro.org>, Philippe Begnic <philippe.begnic@st.com>, Ulf Hansson <ulf.hansson@linaro.org>

From: Jonas Aaberg <jonas.aberg@stericsson.com>

Some minor code cleanup and some minor changes to printed
error messages.

Signed-off-by: Jonas Aaberg <jonas.aberg@stericsson.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/cpufreq/dbx500-cpufreq.c |   22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/cpufreq/dbx500-cpufreq.c b/drivers/cpufreq/dbx500-cpufreq.c
index d974a8e..d4cb782 100644
--- a/drivers/cpufreq/dbx500-cpufreq.c
+++ b/drivers/cpufreq/dbx500-cpufreq.c
@@ -36,6 +36,7 @@ static int dbx500_cpufreq_target(struct cpufreq_policy *policy,
 {
 	struct cpufreq_freqs freqs;
 	unsigned int idx;
+	int ret;
 
 	/* scale the target frequency to one of the extremes supported */
 	if (target_freq < policy->cpuinfo.min_freq)
@@ -44,10 +45,9 @@ static int dbx500_cpufreq_target(struct cpufreq_policy *policy,
 		target_freq = policy->cpuinfo.max_freq;
 
 	/* Lookup the next frequency */
-	if (cpufreq_frequency_table_target
-	    (policy, freq_table, target_freq, relation, &idx)) {
+	if (cpufreq_frequency_table_target(policy, freq_table, target_freq,
+					relation, &idx))
 		return -EINVAL;
-	}
 
 	freqs.old = policy->cur;
 	freqs.new = freq_table[idx].frequency;
@@ -60,9 +60,12 @@ static int dbx500_cpufreq_target(struct cpufreq_policy *policy,
 		cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
 
 	/* update armss clk frequency */
-	if (clk_set_rate(armss_clk, freq_table[idx].frequency * 1000)) {
-		pr_err("dbx500-cpufreq: Failed to update armss clk\n");
-		return -EINVAL;
+	ret = clk_set_rate(armss_clk, freqs.new * 1000);
+
+	if (ret) {
+		pr_err("dbx500-cpufreq: Failed to set armss_clk to %d Hz: error %d\n",
+		       freqs.new * 1000, ret);
+		return ret;
 	}
 
 	/* post change notification */
@@ -97,7 +100,7 @@ static int __cpuinit dbx500_cpufreq_init(struct cpufreq_policy *policy)
 	if (!res)
 		cpufreq_frequency_table_get_attr(freq_table, policy->cpu);
 	else {
-		pr_err("dbx500-cpufreq : Failed to read policy table\n");
+		pr_err("dbx500-cpufreq: Failed to read policy table\n");
 		return res;
 	}
 
@@ -143,11 +146,11 @@ static int dbx500_cpufreq_probe(struct platform_device *pdev)
 
 	armss_clk = clk_get(&pdev->dev, "armss");
 	if (IS_ERR(armss_clk)) {
-		pr_err("dbx500-cpufreq : Failed to get armss clk\n");
+		pr_err("dbx500-cpufreq: Failed to get armss clk\n");
 		return PTR_ERR(armss_clk);
 	}
 
-	pr_info("dbx500-cpufreq : Available frequencies:\n");
+	pr_info("dbx500-cpufreq: Available frequencies:\n");
 	while (freq_table[i].frequency != CPUFREQ_TABLE_END) {
 		pr_info("  %d Mhz\n", freq_table[i].frequency/1000);
 		i++;
@@ -169,7 +172,6 @@ static int __init dbx500_cpufreq_register(void)
 	if (!cpu_is_u8500_family())
 		return -ENODEV;
 
-	pr_info("cpufreq for DBX500 started\n");
 	return platform_driver_register(&dbx500_cpufreq_plat_driver);
 }
 device_initcall(dbx500_cpufreq_register);
-- 
1.7.10

