From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 2/3] thermal: tango: Fix module autoload
Date: Fri, 14 Oct 2016 11:35:01 -0300
Message-ID: <1476455702-21748-3-git-send-email-javier@osg.samsung.com>
References: <1476455702-21748-1-git-send-email-javier@osg.samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:57030
        "EHLO s-opensource.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754259AbcJNOf1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Oct 2016 10:35:27 -0400
In-Reply-To: <1476455702-21748-1-git-send-email-javier@osg.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javier@osg.samsung.com>, Marc Gonzalez <marc_gonzalez@sigmadesigns.com>, linux-pm@vger.kernel.org, Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>, linux-arm-kernel@lists.infradead.org

If the driver is built as a module, autoload won't work because the module
alias information is not filled. So user-space can't match the registered
device with the corresponding module.

Export the module alias information using the MODULE_DEVICE_TABLE() macro.

Before this patch:

$ modinfo drivers/thermal/tango_thermal.ko | grep alias
$

After this patch:

$ modinfo drivers/thermal/tango_thermal.ko | grep alias
alias:          of:N*T*Csigma,smp8758-thermalC*
alias:          of:N*T*Csigma,smp8758-thermal

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 drivers/thermal/tango_thermal.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/thermal/tango_thermal.c b/drivers/thermal/tango_thermal.c
index 201304aeafeb..4e67795cb6ce 100644
--- a/drivers/thermal/tango_thermal.c
+++ b/drivers/thermal/tango_thermal.c
@@ -107,6 +107,7 @@ static const struct of_device_id tango_sensor_ids[] = {
 	},
 	{ /* sentinel */ }
 };
+MODULE_DEVICE_TABLE(of, tango_sensor_ids);
 
 static struct platform_driver tango_thermal_driver = {
 	.probe	= tango_thermal_probe,
-- 
2.7.4

