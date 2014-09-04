From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 08/15] power-supply: Propagate error returned by power_supply_find_supply_from_node()
Date: Thu,  4 Sep 2014 17:31:29 +0530
Message-ID: <38723e6ec5cf70de46fe296fac40235b708a7151.1409831636.git.viresh.kumar@linaro.org>
References: <2eacd908a8094887cc1796f75ae0513be8a3e36d.1409831636.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:49994 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753774AbaIDMCr (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 4 Sep 2014 08:02:47 -0400
Received: by mail-pa0-f43.google.com with SMTP id et14so20017565pad.2
        for <linux-pm@vger.kernel.org>; Thu, 04 Sep 2014 05:02:45 -0700 (PDT)
In-Reply-To: <2eacd908a8094887cc1796f75ae0513be8a3e36d.1409831636.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1409831636.git.viresh.kumar@linaro.org>
References: <cover.1409831636.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, anton@enomsg.org
Cc: linux-pm@vger.kernel.org, linaro-kernel@lists.linaro.org, Viresh Kumar <viresh.kumar@linaro.org>

Callers of power_supply_find_supply_from_node(), i.e.
power_supply_check_supplies(), must propagate the errors returned by it instead
of returning their own.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/power/power_supply_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/power_supply_core.c b/drivers/power/power_supply_core.c
index 8a86cd1..ab1cf8b 100644
--- a/drivers/power/power_supply_core.c
+++ b/drivers/power/power_supply_core.c
@@ -221,8 +221,8 @@ static int power_supply_check_supplies(struct power_supply *psy)
 		of_node_put(np);
 
 		if (ret) {
-			dev_dbg(psy->dev, "Failed to find supply, defer!\n");
-			return -EPROBE_DEFER;
+			dev_dbg(psy->dev, "Failed to find supply!\n");
+			return ret;
 		}
 	} while (np);
 
-- 
2.0.3.693.g996b0fd

