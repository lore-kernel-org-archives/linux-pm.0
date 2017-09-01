From: Jeffy Chen <jeffy.chen@rock-chips.com>
Subject: [PATCH] CHROMIUM: devfreq: rk3399: Clear edev->dev drvdata before enabling dfi
Date: Sat,  2 Sep 2017 07:52:37 +0800
Message-ID: <20170901235237.18390-1-jeffy.chen@rock-chips.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from regular1.263xmail.com ([211.150.99.137]:52950 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752451AbdIAXwr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 1 Sep 2017 19:52:47 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org, dbasehore@chromium.org
Cc: briannorris@chromium.org, dianders@chromium.org, Jeffy Chen <jeffy.chen@rock-chips.com>, Chanwoo Choi <cw00.choi@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, linux-pm@vger.kernel.org

Currently we are using edev->dev drvdata to get rk3399-dmc data, but
it would be inited to edev in devfreq_event_add_edev.

So we need to clear the edev->dev drvdata before enabling dfi, to
prevent dfi from getting the wrong rk3399-dmc data when the irq
triggered too early.

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

 drivers/devfreq/rk3399_dmc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/devfreq/rk3399_dmc.c b/drivers/devfreq/rk3399_dmc.c
index 1b89ebbad02c..12f9f03f349f 100644
--- a/drivers/devfreq/rk3399_dmc.c
+++ b/drivers/devfreq/rk3399_dmc.c
@@ -429,6 +429,7 @@ static int rk3399_dmcfreq_probe(struct platform_device *pdev)
 
 	rk3399_devfreq_dmc_profile.initial_freq = data->rate;
 
+	platform_set_drvdata(pdev, NULL);
 	data->devfreq = devm_devfreq_add_device(dev,
 					   &rk3399_devfreq_dmc_profile,
 					   "simple_ondemand",
-- 
2.11.0
