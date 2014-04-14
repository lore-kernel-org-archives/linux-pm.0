From: Stratos Karafotis <stratosk@semaphore.gr>
Subject: [PATCH 05/20] cpufreq: dbx500: Use cpufreq_for_each_entry macro for
 iteration
Date: Tue, 15 Apr 2014 00:08:45 +0300
Message-ID: <534C4E5D.40508@semaphore.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from sema.semaphore.gr ([78.46.194.137]:54731 "EHLO
	sema.semaphore.gr" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755495AbaDNVIs (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 14 Apr 2014 17:08:48 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

The cpufreq core supports the cpufreq_for_each_entry macro helper
for iteration over the cpufreq_frequency_table, so use it.

It should have no functional changes.

Signed-off-by: Stratos Karafotis <stratosk@semaphore.gr>
---
 drivers/cpufreq/dbx500-cpufreq.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/dbx500-cpufreq.c b/drivers/cpufreq/dbx500-cpufreq.c
index 412a78b..2a0635c 100644
--- a/drivers/cpufreq/dbx500-cpufreq.c
+++ b/drivers/cpufreq/dbx500-cpufreq.c
@@ -45,7 +45,7 @@ static struct cpufreq_driver dbx500_cpufreq_driver = {
 
 static int dbx500_cpufreq_probe(struct platform_device *pdev)
 {
-	int i = 0;
+	struct cpufreq_frequency_table *pos;
 
 	freq_table = dev_get_platdata(&pdev->dev);
 	if (!freq_table) {
@@ -60,9 +60,8 @@ static int dbx500_cpufreq_probe(struct platform_device *pdev)
 	}
 
 	pr_info("dbx500-cpufreq: Available frequencies:\n");
-	while (freq_table[i].frequency != CPUFREQ_TABLE_END) {
-		pr_info("  %d Mhz\n", freq_table[i].frequency/1000);
-		i++;
+	cpufreq_for_each_entry(pos, freq_table) {
+		pr_info("  %d Mhz\n", pos->frequency / 1000);
 	}
 
 	return cpufreq_register_driver(&dbx500_cpufreq_driver);
-- 
1.9.0
