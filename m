From: Lin Huang <hl@rock-chips.com>
Subject: [PATCH v1 2/2] PM/devfreq: rk3399: set specific ddr frequency when stop ddr dvfs
Date: Tue,  1 Nov 2016 16:47:09 +0800
Message-ID: <1477990029-11062-3-git-send-email-hl@rock-chips.com>
References: <1477990029-11062-1-git-send-email-hl@rock-chips.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35256 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1168061AbcKAIrV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 1 Nov 2016 04:47:21 -0400
Received: by mail-pf0-f193.google.com with SMTP id s8so11105458pfj.2
        for <linux-pm@vger.kernel.org>; Tue, 01 Nov 2016 01:47:21 -0700 (PDT)
In-Reply-To: <1477990029-11062-1-git-send-email-hl@rock-chips.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: myungjoo.ham@samsung.com
Cc: cw00.choi@samsung.com, dianders@chromium.org, linux-rockchip@lists.infradead.org, linux-pm@vger.kernel.org, dbasehore@chromium.org, Lin Huang <hl@rock-chips.com>

We need ddr run a specific frequency when ddr dvfs stop
working. For example: if we enable two monitor, then we will
stop ddr dvfs, but we hope ddr can run in highest frequency
obviously.

Change-Id: I02460f0becbf0e1a732e2a55b8e529f53c01109c
Signed-off-by: Lin Huang <hl@rock-chips.com>
---
 drivers/devfreq/rk3399_dmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/devfreq/rk3399_dmc.c b/drivers/devfreq/rk3399_dmc.c
index e24b73d..9309941 100644
--- a/drivers/devfreq/rk3399_dmc.c
+++ b/drivers/devfreq/rk3399_dmc.c
@@ -443,7 +443,7 @@ static int rk3399_dmcfreq_probe(struct platform_device *pdev)
 	if (IS_ERR(data->devfreq))
 		return PTR_ERR(data->devfreq);
 	devm_devfreq_register_opp_notifier(dev, data->devfreq);
-
+	devfreq_opp_get_suspend_opp(dev, data->devfreq);
 	data->dev = dev;
 	platform_set_drvdata(pdev, data);
 
-- 
2.6.6

