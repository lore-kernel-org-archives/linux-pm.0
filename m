From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: [RESEND PATCH 3/5] cpufreq: dbx500: Move clk_get to probe
Date: Mon, 10 Dec 2012 16:25:40 +0100
Message-ID: <1355153142-9534-4-git-send-email-ulf.hansson@stericsson.com>
References: <1355153142-9534-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from eu1sys200aog119.obsmtp.com ([207.126.144.147]:35409 "EHLO
	eu1sys200aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753893Ab2LJP0Y (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 10 Dec 2012 10:26:24 -0500
In-Reply-To: <1355153142-9534-1-git-send-email-ulf.hansson@stericsson.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, Mike Turquette <mturquette@ti.com>, Mike Turquette <mturquette@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, Lee Jones <lee.jones@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Rickard Andersson <rickard.andersson@stericsson.com>, Jonas Aberg <jonas.aberg@stericsson.com>, Vincent Guittot <vincent.guittot@linaro.org>, Philippe Begnic <philippe.begnic@st.com>, Ulf Hansson <ulf.hansson@linaro.org>

From: Ulf Hansson <ulf.hansson@linaro.org>

The armss clock shall only be fetched at probe thus move this here.
Same thing goes for the printing of the available frequencies.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Jonas Aaberg <jonas.aberg@stericsson.com>
---
 drivers/cpufreq/dbx500-cpufreq.c |   29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/drivers/cpufreq/dbx500-cpufreq.c b/drivers/cpufreq/dbx500-cpufreq.c
index 0a411b5..d974a8e 100644
--- a/drivers/cpufreq/dbx500-cpufreq.c
+++ b/drivers/cpufreq/dbx500-cpufreq.c
@@ -90,28 +90,14 @@ static unsigned int dbx500_cpufreq_getspeed(unsigned int cpu)
 
 static int __cpuinit dbx500_cpufreq_init(struct cpufreq_policy *policy)
 {
-	int i = 0;
 	int res;
 
-	armss_clk = clk_get(NULL, "armss");
-	if (IS_ERR(armss_clk)) {
-		pr_err("dbx500-cpufreq : Failed to get armss clk\n");
-		return PTR_ERR(armss_clk);
-	}
-
-	pr_info("dbx500-cpufreq : Available frequencies:\n");
-	while (freq_table[i].frequency != CPUFREQ_TABLE_END) {
-		pr_info("  %d Mhz\n", freq_table[i].frequency/1000);
-		i++;
-	}
-
 	/* get policy fields based on the table */
 	res = cpufreq_frequency_table_cpuinfo(policy, freq_table);
 	if (!res)
 		cpufreq_frequency_table_get_attr(freq_table, policy->cpu);
 	else {
 		pr_err("dbx500-cpufreq : Failed to read policy table\n");
-		clk_put(armss_clk);
 		return res;
 	}
 
@@ -147,13 +133,26 @@ static struct cpufreq_driver dbx500_cpufreq_driver = {
 
 static int dbx500_cpufreq_probe(struct platform_device *pdev)
 {
-	freq_table = dev_get_platdata(&pdev->dev);
+	int i = 0;
 
+	freq_table = dev_get_platdata(&pdev->dev);
 	if (!freq_table) {
 		pr_err("dbx500-cpufreq: Failed to fetch cpufreq table\n");
 		return -ENODEV;
 	}
 
+	armss_clk = clk_get(&pdev->dev, "armss");
+	if (IS_ERR(armss_clk)) {
+		pr_err("dbx500-cpufreq : Failed to get armss clk\n");
+		return PTR_ERR(armss_clk);
+	}
+
+	pr_info("dbx500-cpufreq : Available frequencies:\n");
+	while (freq_table[i].frequency != CPUFREQ_TABLE_END) {
+		pr_info("  %d Mhz\n", freq_table[i].frequency/1000);
+		i++;
+	}
+
 	return cpufreq_register_driver(&dbx500_cpufreq_driver);
 }
 
-- 
1.7.10

