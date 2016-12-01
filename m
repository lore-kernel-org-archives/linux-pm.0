From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH] devfreq: rk3399_dmc: Remove dangling rcu_read_unlock()
Date: Thu,  1 Dec 2016 16:12:14 +0530
Message-ID: <2958843865a6ed790ff9ecfc9cacd54d752cace5.1480588927.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f171.google.com ([209.85.192.171]:34373 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751997AbcLAKmU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Dec 2016 05:42:20 -0500
Received: by mail-pf0-f171.google.com with SMTP id c4so45762955pfb.1
        for <linux-pm@vger.kernel.org>; Thu, 01 Dec 2016 02:42:20 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>, nm@ti.com, Vincent Guittot <vincent.guittot@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>

This call never had the rcu_read_lock() counterpart. Remove the unlock
part as well.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/devfreq/rk3399_dmc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/devfreq/rk3399_dmc.c b/drivers/devfreq/rk3399_dmc.c
index 192240423fee..4cc5be08720a 100644
--- a/drivers/devfreq/rk3399_dmc.c
+++ b/drivers/devfreq/rk3399_dmc.c
@@ -408,7 +408,6 @@ static int rk3399_dmcfreq_probe(struct platform_device *pdev)
 	 */
 	if (dev_pm_opp_of_add_table(dev)) {
 		dev_err(dev, "Invalid operating-points in device tree.\n");
-		rcu_read_unlock();
 		return -EINVAL;
 	}
 
-- 
2.7.1.410.g6faf27b

