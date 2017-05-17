From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 2/4] PM / OPP: Don't create copy of regulators unnecessarily
Date: Wed, 17 May 2017 10:10:33 +0530
Message-ID: <7e185f9780252587f58efdff9b1d3079120a4246.1494995911.git.viresh.kumar@linaro.org>
References: <cover.1494995911.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f42.google.com ([74.125.83.42]:34909 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752150AbdEQEk7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 May 2017 00:40:59 -0400
Received: by mail-pg0-f42.google.com with SMTP id q125so987184pgq.2
        for <linux-pm@vger.kernel.org>; Tue, 16 May 2017 21:40:58 -0700 (PDT)
In-Reply-To: <cover.1494995911.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1494995911.git.viresh.kumar@linaro.org>
References: <cover.1494995911.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>

This code was required while the OPP core was managed with help of RCUs,
but not anymore. Get rid of unnecessary alloc/memcpy operations.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/opp/core.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
index 402b9e86d77c..898f19ea0f60 100644
--- a/drivers/base/power/opp/core.c
+++ b/drivers/base/power/opp/core.c
@@ -180,7 +180,7 @@ unsigned long dev_pm_opp_get_max_volt_latency(struct device *dev)
 {
 	struct opp_table *opp_table;
 	struct dev_pm_opp *opp;
-	struct regulator *reg, **regulators;
+	struct regulator *reg;
 	unsigned long latency_ns = 0;
 	int ret, i, count;
 	struct {
@@ -198,15 +198,9 @@ unsigned long dev_pm_opp_get_max_volt_latency(struct device *dev)
 	if (!count)
 		goto put_opp_table;
 
-	regulators = kmalloc_array(count, sizeof(*regulators), GFP_KERNEL);
-	if (!regulators)
-		goto put_opp_table;
-
 	uV = kmalloc_array(count, sizeof(*uV), GFP_KERNEL);
 	if (!uV)
-		goto free_regulators;
-
-	memcpy(regulators, opp_table->regulators, count * sizeof(*regulators));
+		goto put_opp_table;
 
 	mutex_lock(&opp_table->lock);
 
@@ -232,15 +226,13 @@ unsigned long dev_pm_opp_get_max_volt_latency(struct device *dev)
 	 * isn't freed, while we are executing this routine.
 	 */
 	for (i = 0; i < count; i++) {
-		reg = regulators[i];
+		reg = opp_table->regulators[i];
 		ret = regulator_set_voltage_time(reg, uV[i].min, uV[i].max);
 		if (ret > 0)
 			latency_ns += ret * 1000;
 	}
 
 	kfree(uV);
-free_regulators:
-	kfree(regulators);
 put_opp_table:
 	dev_pm_opp_put_opp_table(opp_table);
 
-- 
2.13.0.303.g4ebf3021692d
