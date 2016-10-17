From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 4/4] power: reset: zx-reboot: Fix module autoload
Date: Mon, 17 Oct 2016 15:36:15 -0300
Message-ID: <1476729375-17526-5-git-send-email-javier@osg.samsung.com>
References: <1476729375-17526-1-git-send-email-javier@osg.samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:37085
        "EHLO s-opensource.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932424AbcJQSge (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 17 Oct 2016 14:36:34 -0400
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

$ modinfo drivers/power/reset/zx-reboot.ko | grep alias
$

After this patch:

$ modinfo drivers/power/reset/zx-reboot.ko | grep alias
alias:          of:N*T*Czte,sysctrlC*
alias:          of:N*T*Czte,sysctrl

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

---

 drivers/power/reset/zx-reboot.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/power/reset/zx-reboot.c b/drivers/power/reset/zx-reboot.c
index b0b1eb3a78c2..7549c7f74a3c 100644
--- a/drivers/power/reset/zx-reboot.c
+++ b/drivers/power/reset/zx-reboot.c
@@ -72,6 +72,7 @@ static const struct of_device_id zx_reboot_of_match[] = {
 	{ .compatible = "zte,sysctrl" },
 	{}
 };
+MODULE_DEVICE_TABLE(of, zx_reboot_of_match);
 
 static struct platform_driver zx_reboot_driver = {
 	.probe = zx_reboot_probe,
-- 
2.7.4

