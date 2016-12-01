From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH] devfreq: rk3399_dmc: Don't use OPP structures outside of RCU locks
Date: Thu,  1 Dec 2016 16:08:01 +0530
Message-ID: <22bf6dfc155a6a241c2ee4e2b44a615d0e82064d.1480588658.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f181.google.com ([209.85.192.181]:35503 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751503AbcLAKiG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Dec 2016 05:38:06 -0500
Received: by mail-pf0-f181.google.com with SMTP id i88so45562620pfk.2
        for <linux-pm@vger.kernel.org>; Thu, 01 Dec 2016 02:38:06 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>, nm@ti.com, Vincent Guittot <vincent.guittot@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>

The OPP structures are abused to the best here, without understanding
how the OPP core and RCU locks work.

In short, the OPP pointer saved in 'rk3399_dmcfreq' can become invalid
under your nose, as the OPP core may free it.

Fix various abuses around OPP structures and calls.

Compile tested only.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
I would like it to go via the PM tree. Perhaps that's already the
default tree for this.

 drivers/devfreq/rk3399_dmc.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/devfreq/rk3399_dmc.c b/drivers/devfreq/rk3399_dmc.c
index 5063ac1a5939..cf14631b1945 100644
--- a/drivers/devfreq/rk3399_dmc.c
+++ b/drivers/devfreq/rk3399_dmc.c
@@ -80,7 +80,6 @@ struct rk3399_dmcfreq {
 	struct regulator *vdd_center;
 	unsigned long rate, target_rate;
 	unsigned long volt, target_volt;
-	struct dev_pm_opp *curr_opp;
 };
 
 static int rk3399_dmcfreq_target(struct device *dev, unsigned long *freq,
@@ -102,9 +101,6 @@ static int rk3399_dmcfreq_target(struct device *dev, unsigned long *freq,
 	target_rate = dev_pm_opp_get_freq(opp);
 	target_volt = dev_pm_opp_get_voltage(opp);
 
-	dmcfreq->rate = dev_pm_opp_get_freq(dmcfreq->curr_opp);
-	dmcfreq->volt = dev_pm_opp_get_voltage(dmcfreq->curr_opp);
-
 	rcu_read_unlock();
 
 	if (dmcfreq->rate == target_rate)
@@ -165,7 +161,9 @@ static int rk3399_dmcfreq_target(struct device *dev, unsigned long *freq,
 	if (err)
 		dev_err(dev, "Cannot to set vol %lu uV\n", target_volt);
 
-	dmcfreq->curr_opp = opp;
+	dmcfreq->rate = target_rate;
+	dmcfreq->volt = target_volt;
+
 out:
 	mutex_unlock(&dmcfreq->lock);
 	return err;
@@ -431,8 +429,9 @@ static int rk3399_dmcfreq_probe(struct platform_device *pdev)
 		rcu_read_unlock();
 		return PTR_ERR(opp);
 	}
+	dmcfreq->rate = dev_pm_opp_get_freq(opp);
+	dmcfreq->volt = dev_pm_opp_get_voltage(opp);
 	rcu_read_unlock();
-	data->curr_opp = opp;
 
 	rk3399_devfreq_dmc_profile.initial_freq = data->rate;
 
-- 
2.7.1.410.g6faf27b

