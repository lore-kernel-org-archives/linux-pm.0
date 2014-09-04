From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 06/15] power-supply: Use 'break' instead of 'continue' to end loop
Date: Thu,  4 Sep 2014 17:31:27 +0530
Message-ID: <f89da51fb4e274d10734f58a2631ea4c6bb7542f.1409831636.git.viresh.kumar@linaro.org>
References: <2eacd908a8094887cc1796f75ae0513be8a3e36d.1409831636.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:45239 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753774AbaIDMCc (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 4 Sep 2014 08:02:32 -0400
Received: by mail-pa0-f43.google.com with SMTP id et14so19910551pad.30
        for <linux-pm@vger.kernel.org>; Thu, 04 Sep 2014 05:02:30 -0700 (PDT)
In-Reply-To: <2eacd908a8094887cc1796f75ae0513be8a3e36d.1409831636.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1409831636.git.viresh.kumar@linaro.org>
References: <cover.1409831636.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, anton@enomsg.org
Cc: linux-pm@vger.kernel.org, linaro-kernel@lists.linaro.org, Viresh Kumar <viresh.kumar@linaro.org>

In few routines, we need to end the do-while loop when no more "power-supplies"
are available. Currently we are doing 'continue' which will make the
'while(np)' conditional statement run again.

Skip this by doing a 'break' instead.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/power/power_supply_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/power_supply_core.c b/drivers/power/power_supply_core.c
index 71d00ec..7657335 100644
--- a/drivers/power/power_supply_core.c
+++ b/drivers/power/power_supply_core.c
@@ -127,7 +127,7 @@ static int __power_supply_populate_supplied_from(struct device *dev,
 	do {
 		np = of_parse_phandle(psy->of_node, "power-supplies", i++);
 		if (!np)
-			continue;
+			break;
 
 		if (np == epsy->of_node) {
 			dev_info(psy->dev, "%s: Found supply : %s\n",
@@ -215,7 +215,7 @@ static int power_supply_check_supplies(struct power_supply *psy)
 
 		np = of_parse_phandle(psy->of_node, "power-supplies", cnt++);
 		if (!np)
-			continue;
+			break;
 
 		ret = power_supply_find_supply_from_node(np);
 		if (ret) {
-- 
2.0.3.693.g996b0fd

