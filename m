From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 04/10] PM / OPP: Error out on failing to add static OPPs for v1 bindings
Date: Tue,  6 Dec 2016 14:45:56 +0530
Message-ID: <1f876a6d176784f9ab901aea7ff521d53522682d.1481015522.git.viresh.kumar@linaro.org>
References: <cover.1481015522.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f170.google.com ([209.85.192.170]:33819 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752183AbcLFJQv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 6 Dec 2016 04:16:51 -0500
Received: by mail-pf0-f170.google.com with SMTP id c4so69639521pfb.1
        for <linux-pm@vger.kernel.org>; Tue, 06 Dec 2016 01:16:26 -0800 (PST)
In-Reply-To: <cover.1481015522.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1481015522.git.viresh.kumar@linaro.org>
References: <cover.1481015522.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>

The code adding static OPPs for V2 bindings already does so. Make the V1
bindings specific code behave the same.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/opp/of.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/base/power/opp/of.c b/drivers/base/power/opp/of.c
index f8512ca2bf41..c8fe815774ff 100644
--- a/drivers/base/power/opp/of.c
+++ b/drivers/base/power/opp/of.c
@@ -433,7 +433,7 @@ static int _of_add_opp_table_v1(struct device *dev)
 {
 	const struct property *prop;
 	const __be32 *val;
-	int nr;
+	int nr, ret;
 
 	prop = of_find_property(dev->of_node, "operating-points", NULL);
 	if (!prop)
@@ -456,9 +456,13 @@ static int _of_add_opp_table_v1(struct device *dev)
 		unsigned long freq = be32_to_cpup(val++) * 1000;
 		unsigned long volt = be32_to_cpup(val++);
 
-		if (_opp_add_v1(dev, freq, volt, false))
-			dev_warn(dev, "%s: Failed to add OPP %ld\n",
-				 __func__, freq);
+		ret = _opp_add_v1(dev, freq, volt, false);
+		if (ret) {
+			dev_err(dev, "%s: Failed to add OPP %ld (%d)\n",
+				__func__, freq, ret);
+			dev_pm_opp_of_remove_table(dev);
+			return ret;
+		}
 		nr -= 2;
 	}
 
-- 
2.7.1.410.g6faf27b

