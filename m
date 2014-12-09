From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH] opp: set new_opp->dev_opp to a valid dev_opp
Date: Tue,  9 Dec 2014 11:18:51 +0530
Message-ID: <92ee61e091ccc336e6937f7af093f7ce569f5485.1418104004.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f177.google.com ([209.85.192.177]:64516 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754760AbaLIFtR (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 9 Dec 2014 00:49:17 -0500
Received: by mail-pd0-f177.google.com with SMTP id ft15so6589979pdb.22
        for <linux-pm@vger.kernel.org>; Mon, 08 Dec 2014 21:49:16 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>

We find/allocate dev_opp after using its value to fill new_opp->dev_opp right
now. Move this to a later point where dev_opp is valid.

Fixes: a7470db6fec4 ("PM / OPP don't match for existing OPPs when list is empty")
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/opp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
index 2d195f3a1998..c2020520b2bf 100644
--- a/drivers/base/power/opp.c
+++ b/drivers/base/power/opp.c
@@ -400,7 +400,6 @@ static int dev_pm_opp_add_dynamic(struct device *dev, unsigned long freq,
 	mutex_lock(&dev_opp_list_lock);
 
 	/* populate the opp table */
-	new_opp->dev_opp = dev_opp;
 	new_opp->rate = freq;
 	new_opp->u_volt = u_volt;
 	new_opp->available = true;
@@ -460,6 +459,7 @@ static int dev_pm_opp_add_dynamic(struct device *dev, unsigned long freq,
 	}
 
 list_add:
+	new_opp->dev_opp = dev_opp;
 	list_add_rcu(&new_opp->node, head);
 	mutex_unlock(&dev_opp_list_lock);
 
-- 
2.2.0

