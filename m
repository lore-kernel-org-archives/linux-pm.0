From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 3/3] thermal: db8500: Fix module autoload
Date: Fri, 14 Oct 2016 11:35:02 -0300
Message-ID: <1476455702-21748-4-git-send-email-javier@osg.samsung.com>
References: <1476455702-21748-1-git-send-email-javier@osg.samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:57034
        "EHLO s-opensource.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754628AbcJNOfg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Oct 2016 10:35:36 -0400
In-Reply-To: <1476455702-21748-1-git-send-email-javier@osg.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javier@osg.samsung.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, linux-pm@vger.kernel.org

If the driver is built as a module, autoload won't work because the module
alias information is not filled. So user-space can't match the registered
device with the corresponding module.

Export the module alias information using the MODULE_DEVICE_TABLE() macro.

Before this patch:

$ modinfo drivers/thermal/db8500_thermal.ko | grep alias
$

After this patch:

$ modinfo drivers/thermal/db8500_thermal.ko | grep alias
alias:          of:N*T*Cstericsson,db8500-thermalC*
alias:          of:N*T*Cstericsson,db8500-thermal

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

---

 drivers/thermal/db8500_thermal.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/thermal/db8500_thermal.c b/drivers/thermal/db8500_thermal.c
index e776cea80cfc..f491faf16592 100644
--- a/drivers/thermal/db8500_thermal.c
+++ b/drivers/thermal/db8500_thermal.c
@@ -512,6 +512,7 @@ static const struct of_device_id db8500_thermal_match[] = {
 	{ .compatible = "stericsson,db8500-thermal" },
 	{},
 };
+MODULE_DEVICE_TABLE(of, db8500_thermal_match);
 #endif
 
 static struct platform_driver db8500_thermal_driver = {
-- 
2.7.4

