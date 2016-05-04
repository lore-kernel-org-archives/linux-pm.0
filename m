From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH] PM / OPP: Remove useless check
Date: Wed,  4 May 2016 18:49:55 +0530
Message-ID: <080908c24c189b44442b2fee7be83e760a6dac49.1462367990.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f176.google.com ([209.85.192.176]:35633 "EHLO
	mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751272AbcEDNUB (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 4 May 2016 09:20:01 -0400
Received: by mail-pf0-f176.google.com with SMTP id 77so25240695pfv.2
        for <linux-pm@vger.kernel.org>; Wed, 04 May 2016 06:20:01 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, Marc Gonzalez <marc_gonzalez@sigmadesigns.com>, linux-kernel@vger.kernel.org

Regulators are optional for devices using OPPs and the OPP core
shouldn't be printing any errors for such missing regulators.

It was fine before the commit 0c717d0f9cb4, but that failed to update
this part of the code to remove an 'always true' check and an extra
unwanted print message.

Fix that now.

Fixes: 0c717d0f9cb4 ("PM / OPP: Initialize regulator pointer to an error value")
Reported-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/opp/core.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
index 433b60092972..d8f4cc22856c 100644
--- a/drivers/base/power/opp/core.c
+++ b/drivers/base/power/opp/core.c
@@ -259,9 +259,6 @@ unsigned long dev_pm_opp_get_max_volt_latency(struct device *dev)
 	reg = opp_table->regulator;
 	if (IS_ERR(reg)) {
 		/* Regulator may not be required for device */
-		if (reg)
-			dev_err(dev, "%s: Invalid regulator (%ld)\n", __func__,
-				PTR_ERR(reg));
 		rcu_read_unlock();
 		return 0;
 	}
-- 
2.7.1.410.g6faf27b

