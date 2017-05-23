From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 2/4] PM / OPP: Don't create copy of regulators unnecessarily
Date: Tue, 23 May 2017 09:32:11 +0530
Message-ID: <ed9beaec36649c862369a34ea209822c00d86f52.1495511998.git.viresh.kumar@linaro.org>
References: <b9f67b2be37d5e9740a5e1ed85b0e8b4e5c0eb91.1495511998.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f181.google.com ([209.85.192.181]:35209 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751648AbdEWECW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 May 2017 00:02:22 -0400
Received: by mail-pf0-f181.google.com with SMTP id n23so101217527pfb.2
        for <linux-pm@vger.kernel.org>; Mon, 22 May 2017 21:02:21 -0700 (PDT)
In-Reply-To: <b9f67b2be37d5e9740a5e1ed85b0e8b4e5c0eb91.1495511998.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1495511998.git.viresh.kumar@linaro.org>
References: <cover.1495511998.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>

This code was required while the OPP core was managed with help of RCUs,
but not anymore. Get rid of unnecessary alloc/memcpy operations.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/base/power/opp/core.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
index c4590fc017ba..5ee7aadf0abf 100644
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
2.13.0.70.g6367777092d9
