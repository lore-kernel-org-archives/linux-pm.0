From: Lin Huang <hl@rock-chips.com>
Subject: [PATCH v3 2/2] PM/devfreq: rk3399: get devfreq suspend frequency
Date: Mon,  7 Nov 2016 14:23:09 +0800
Message-ID: <1478499789-21589-3-git-send-email-hl@rock-chips.com>
References: <1478499789-21589-1-git-send-email-hl@rock-chips.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36351 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751297AbcKGGjm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 7 Nov 2016 01:39:42 -0500
In-Reply-To: <1478499789-21589-1-git-send-email-hl@rock-chips.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: myungjoo.ham@samsung.com
Cc: linux-pm@vger.kernel.org, dbasehore@chromium.org, dianders@chromium.org, linux-kernel@vger.kernel.org, cw00.choi@samsung.com, linux-rockchip@lists.infradead.org, Lin Huang <hl@rock-chips.com>

We need ddr run a specific frequency when ddr dvfs stop
working. For example: if we enable two monitor, then we will
stop ddr dvfs, but we hope ddr can run in highest frequency
obviously.

Signed-off-by: Lin Huang <hl@rock-chips.com>
---
Changes in v2:
- None
Changes in v3:
- None

 drivers/devfreq/rk3399_dmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/devfreq/rk3399_dmc.c b/drivers/devfreq/rk3399_dmc.c
index 5a2da95..39f8e27 100644
--- a/drivers/devfreq/rk3399_dmc.c
+++ b/drivers/devfreq/rk3399_dmc.c
@@ -329,7 +329,7 @@ static int rk3399_dmcfreq_probe(struct platform_device *pdev)
 	if (IS_ERR(data->devfreq))
 		return PTR_ERR(data->devfreq);
 	devm_devfreq_register_opp_notifier(dev, data->devfreq);
-
+	devfreq_opp_get_suspend_opp(dev, data->devfreq);
 	data->dev = dev;
 	platform_set_drvdata(pdev, data);
 	pd_register_notify_to_dmc(data->devfreq);
-- 
1.9.1

