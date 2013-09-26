From: Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH] cpufreq: cpufreq-cpu0: NULL is a valid regulator, part 2
Date: Thu, 26 Sep 2013 11:19:37 +0200
Message-ID: <1380187177-9447-1-git-send-email-p.zabel@pengutronix.de>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:59099 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751471Ab3IZJTs (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 26 Sep 2013 05:19:48 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Viresh Kumar <viresh.kumar@linaro.org>, Mark Brown <broonie@linaro.org>, kernel@pengutronix.de, Philipp Zabel <p.zabel@pengutronix.de>

Since the patch "cpufreq: cpufreq-cpu0: NULL is a valid regulator", cpu_reg
contains an error value if the regulator is not set, instead of NULL.
Accordingly, fix the remaining check for non-NULL cpu_reg.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/cpufreq/cpufreq-cpu0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq-cpu0.c b/drivers/cpufreq/cpufreq-cpu0.c
index 78c49d8..c522a95 100644
--- a/drivers/cpufreq/cpufreq-cpu0.c
+++ b/drivers/cpufreq/cpufreq-cpu0.c
@@ -229,7 +229,7 @@ static int cpu0_cpufreq_probe(struct platform_device *pdev)
 	if (of_property_read_u32(np, "clock-latency", &transition_latency))
 		transition_latency = CPUFREQ_ETERNAL;
 
-	if (cpu_reg) {
+	if (!IS_ERR(cpu_reg)) {
 		struct opp *opp;
 		unsigned long min_uV, max_uV;
 		int i;
-- 
1.8.4.rc3

