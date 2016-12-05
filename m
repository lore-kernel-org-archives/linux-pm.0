From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2] devfreq: rk3399_dmc: Don't use OPP structures outside of RCU locks
Date: Mon,  5 Dec 2016 08:53:52 +0530
Message-ID: <dcd19eb862a0de24b441f4d43473a01ae90e20e9.1480908064.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f45.google.com ([74.125.83.45]:33335 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751120AbcLEDYB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 4 Dec 2016 22:24:01 -0500
Received: by mail-pg0-f45.google.com with SMTP id 3so131430843pgd.0
        for <linux-pm@vger.kernel.org>; Sun, 04 Dec 2016 19:24:01 -0800 (PST)
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

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
V1->V2:
- Added Reviewed-by from Chanwoo.
- Fixed an issue reported by buildbot.

 drivers/devfreq/rk3399_dmc.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/devfreq/rk3399_dmc.c b/drivers/devfreq/rk3399_dmc.c
index 5063ac1a5939..75333050cdea 100644
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
+	data->rate = dev_pm_opp_get_freq(opp);
+	data->volt = dev_pm_opp_get_voltage(opp);
 	rcu_read_unlock();
-	data->curr_opp = opp;
 
 	rk3399_devfreq_dmc_profile.initial_freq = data->rate;
 
-- 
2.7.1.410.g6faf27b

