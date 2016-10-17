From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 3/4] power: reset: syscon-reboot-mode: Fix module autoload
Date: Mon, 17 Oct 2016 15:36:14 -0300
Message-ID: <1476729375-17526-4-git-send-email-javier@osg.samsung.com>
References: <1476729375-17526-1-git-send-email-javier@osg.samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:37081
        "EHLO s-opensource.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754447AbcJQSgd (ORCPT
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

$ modinfo drivers/power/reset/syscon-reboot-mode.ko | grep alias
$

After this patch:

$ modinfo drivers/power/reset/syscon-reboot-mode.ko | grep alias
alias:          of:N*T*Csyscon-reboot-modeC*
alias:          of:N*T*Csyscon-reboot-mode

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 drivers/power/reset/syscon-reboot-mode.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/power/reset/syscon-reboot-mode.c b/drivers/power/reset/syscon-reboot-mode.c
index 1ecb51d67149..c8c371b285b1 100644
--- a/drivers/power/reset/syscon-reboot-mode.c
+++ b/drivers/power/reset/syscon-reboot-mode.c
@@ -74,6 +74,7 @@ static const struct of_device_id syscon_reboot_mode_of_match[] = {
 	{ .compatible = "syscon-reboot-mode" },
 	{}
 };
+MODULE_DEVICE_TABLE(of, syscon_reboot_mode_of_match);
 
 static struct platform_driver syscon_reboot_mode_driver = {
 	.probe = syscon_reboot_mode_probe,
-- 
2.7.4

