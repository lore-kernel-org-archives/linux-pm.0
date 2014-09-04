From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 10/15] power-supply: Drop useless 'if (ret.intval)' statements
Date: Thu,  4 Sep 2014 17:31:31 +0530
Message-ID: <757d201831cd8187644fc50705a8415e44237e00.1409831636.git.viresh.kumar@linaro.org>
References: <2eacd908a8094887cc1796f75ae0513be8a3e36d.1409831636.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f173.google.com ([209.85.192.173]:51264 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753774AbaIDMC7 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 4 Sep 2014 08:02:59 -0400
Received: by mail-pd0-f173.google.com with SMTP id p10so13290267pdj.4
        for <linux-pm@vger.kernel.org>; Thu, 04 Sep 2014 05:02:55 -0700 (PDT)
In-Reply-To: <2eacd908a8094887cc1796f75ae0513be8a3e36d.1409831636.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1409831636.git.viresh.kumar@linaro.org>
References: <cover.1409831636.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, anton@enomsg.org
Cc: linux-pm@vger.kernel.org, linaro-kernel@lists.linaro.org, Viresh Kumar <viresh.kumar@linaro.org>

There is no need to check the value of ret.intval before returning it, as we
will be returning zero explicitly when ret.intval is zero.

So essentially we will end up returning value of ret.intval as it is. Drop the
unnecessary 'if' statements.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/power/power_supply_core.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/power/power_supply_core.c b/drivers/power/power_supply_core.c
index 55140eb..bcff7fd 100644
--- a/drivers/power/power_supply_core.c
+++ b/drivers/power/power_supply_core.c
@@ -265,10 +265,8 @@ static int __power_supply_am_i_supplied(struct device *dev, void *data)
 	struct power_supply *epsy = dev_get_drvdata(dev);
 
 	if (__power_supply_is_supplied_by(epsy, psy))
-		if (!epsy->get_property(epsy, POWER_SUPPLY_PROP_ONLINE, &ret)) {
-			if (ret.intval)
-				return ret.intval;
-		}
+		if (!epsy->get_property(epsy, POWER_SUPPLY_PROP_ONLINE, &ret))
+			return ret.intval;
 
 	return 0;
 }
@@ -293,12 +291,10 @@ static int __power_supply_is_system_supplied(struct device *dev, void *data)
 	unsigned int *count = data;
 
 	(*count)++;
-	if (psy->type != POWER_SUPPLY_TYPE_BATTERY) {
-		if (psy->get_property(psy, POWER_SUPPLY_PROP_ONLINE, &ret))
-			return 0;
-		if (ret.intval)
+	if (psy->type != POWER_SUPPLY_TYPE_BATTERY)
+		if (!psy->get_property(psy, POWER_SUPPLY_PROP_ONLINE, &ret))
 			return ret.intval;
-	}
+
 	return 0;
 }
 
-- 
2.0.3.693.g996b0fd

