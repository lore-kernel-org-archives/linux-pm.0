From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 1/4] PM / devfreq: rk3399_dmc: Fix module autoload
Date: Wed, 19 Oct 2016 18:06:24 -0300
Message-ID: <1476911187-11040-2-git-send-email-javier@osg.samsung.com>
References: <1476911187-11040-1-git-send-email-javier@osg.samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:48278
        "EHLO s-opensource.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933233AbcJSVGp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 Oct 2016 17:06:45 -0400
In-Reply-To: <1476911187-11040-1-git-send-email-javier@osg.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javier@osg.samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, linux-pm@vger.kernel.org

If the driver is built as a module, autoload won't work because the module
alias information is not filled. So user-space can't match the registered
device with the corresponding module.

Export the module alias information using the MODULE_DEVICE_TABLE() macro.

Before this patch:

$ modinfo drivers/devfreq/rk3399_dmc.ko | grep alias
$

After this patch:

$ modinfo drivers/devfreq/rk3399_dmc.ko | grep alias
alias:          of:N*T*Crockchip,rk3399-dmcC*
alias:          of:N*T*Crockchip,rk3399-dmc

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 drivers/devfreq/rk3399_dmc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/devfreq/rk3399_dmc.c b/drivers/devfreq/rk3399_dmc.c
index e24b73d66659..77bd9d02e870 100644
--- a/drivers/devfreq/rk3399_dmc.c
+++ b/drivers/devfreq/rk3399_dmc.c
@@ -454,6 +454,7 @@ static const struct of_device_id rk3399dmc_devfreq_of_match[] = {
 	{ .compatible = "rockchip,rk3399-dmc" },
 	{ },
 };
+MODULE_DEVICE_TABLE(of, rk3399dmc_devfreq_of_match);
 
 static struct platform_driver rk3399_dmcfreq_driver = {
 	.probe	= rk3399_dmcfreq_probe,
-- 
2.7.4

