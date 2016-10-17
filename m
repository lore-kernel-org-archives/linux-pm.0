From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 1/4] power: reset: at91-reset: Fix module autoload
Date: Mon, 17 Oct 2016 15:36:12 -0300
Message-ID: <1476729375-17526-2-git-send-email-javier@osg.samsung.com>
References: <1476729375-17526-1-git-send-email-javier@osg.samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:37071
        "EHLO s-opensource.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757498AbcJQSgd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 17 Oct 2016 14:36:33 -0400
In-Reply-To: <1476729375-17526-1-git-send-email-javier@osg.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javier@osg.samsung.com>, Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org

If the driver is built as a module, autoload won't work because the module
alias information is not filled. So user-space can't match the registered
device with the corresponding module.

Export the module alias information using the MODULE_DEVICE_TABLE() macro.

Before this patch:

$ modinfo drivers/power/reset/at91-reset.ko | grep alias
$

After this patch:

$ modinfo drivers/power/reset/at91-reset.ko | grep alias
alias:          of:N*T*Catmel,sama5d3-rstcC*
alias:          of:N*T*Catmel,sama5d3-rstc
alias:          of:N*T*Catmel,at91sam9g45-rstcC*
alias:          of:N*T*Catmel,at91sam9g45-rstc
alias:          of:N*T*Catmel,at91sam9260-rstcC*
alias:          of:N*T*Catmel,at91sam9260-rstc
alias:          platform:at91-sam9g45-reset
alias:          platform:at91-sam9260-reset

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 drivers/power/reset/at91-reset.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/power/reset/at91-reset.c b/drivers/power/reset/at91-reset.c
index 1b5d450586d1..568580cf0655 100644
--- a/drivers/power/reset/at91-reset.c
+++ b/drivers/power/reset/at91-reset.c
@@ -175,6 +175,7 @@ static const struct of_device_id at91_reset_of_match[] = {
 	{ .compatible = "atmel,sama5d3-rstc", .data = sama5d3_restart },
 	{ /* sentinel */ }
 };
+MODULE_DEVICE_TABLE(of, at91_reset_of_match);
 
 static struct notifier_block at91_restart_nb = {
 	.priority = 192,
@@ -242,6 +243,7 @@ static const struct platform_device_id at91_reset_plat_match[] = {
 	{ "at91-sam9g45-reset", (unsigned long)at91sam9g45_restart },
 	{ /* sentinel */ }
 };
+MODULE_DEVICE_TABLE(platform, at91_reset_plat_match);
 
 static struct platform_driver at91_reset_driver = {
 	.remove = __exit_p(at91_reset_remove),
-- 
2.7.4

