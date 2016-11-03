From: Lin Huang <hl@rock-chips.com>
Subject: [PATCH v2 2/2] PM/devfreq: rk3399: set specific ddr frequency when stop ddr dvfs
Date: Thu,  3 Nov 2016 14:16:10 +0800
Message-ID: <1478153770-8433-3-git-send-email-hl@rock-chips.com>
References: <1478153770-8433-1-git-send-email-hl@rock-chips.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33420 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752089AbcKCGQb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 3 Nov 2016 02:16:31 -0400
In-Reply-To: <1478153770-8433-1-git-send-email-hl@rock-chips.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: myungjoo.ham@samsung.com
Cc: cw00.choi@samsung.com, dianders@chromium.org, linux-rockchip@lists.infradead.org, linux-pm@vger.kernel.org, dbasehore@chromium.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Lin Huang <hl@rock-chips.com>

We need ddr run a specific frequency when ddr dvfs stop
working. For example: if we enable two monitor, then we will
stop ddr dvfs, but we hope ddr can run in highest frequency
obviously.

Change-Id: I02460f0becbf0e1a732e2a55b8e529f53c01109c
Signed-off-by: Lin Huang <hl@rock-chips.com>
---
Changes in v2:
- None

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
1.9.1

