From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 01/15] power-supply: Don't over-allocate memory for "supplied-from" array
Date: Thu,  4 Sep 2014 17:31:22 +0530
Message-ID: <2eacd908a8094887cc1796f75ae0513be8a3e36d.1409831636.git.viresh.kumar@linaro.org>
References: <cover.1409831636.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:48260 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753774AbaIDMCC (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 4 Sep 2014 08:02:02 -0400
Received: by mail-pa0-f48.google.com with SMTP id ey11so19970359pad.21
        for <linux-pm@vger.kernel.org>; Thu, 04 Sep 2014 05:02:01 -0700 (PDT)
In-Reply-To: <cover.1409831636.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, anton@enomsg.org
Cc: linux-pm@vger.kernel.org, linaro-kernel@lists.linaro.org, Viresh Kumar <viresh.kumar@linaro.org>

In routine power_supply_check_supplies(), 'cnt' is counting the number of
supplies passed in "power-supplies" field of a node. The value of 'cnt' will
always be one more than the number of supplies after the do-while loop ends. And
so we need to allocate memory for 'cnt - 1' char pointers. But we are allocating
memory for 'cnt' instead.

Fix this by not over-allocating memory.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/power/power_supply_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/power_supply_core.c b/drivers/power/power_supply_core.c
index 078afd6..10f0b57 100644
--- a/drivers/power/power_supply_core.c
+++ b/drivers/power/power_supply_core.c
@@ -234,7 +234,7 @@ static int power_supply_check_supplies(struct power_supply *psy)
 		return -ENOMEM;
 	}
 
-	*psy->supplied_from = devm_kzalloc(psy->dev, sizeof(char *) * cnt,
+	*psy->supplied_from = devm_kzalloc(psy->dev, sizeof(char *) * (cnt - 1),
 					   GFP_KERNEL);
 	if (!*psy->supplied_from) {
 		dev_err(psy->dev, "Couldn't allocate memory for supply list\n");
-- 
2.0.3.693.g996b0fd

