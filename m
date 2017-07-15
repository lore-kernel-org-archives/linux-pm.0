From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH] thermal: tegra: delete unneeded of_node_put
Date: Sat, 15 Jul 2017 10:42:32 +0200
Message-ID: <1500108152-1812-1-git-send-email-Julia.Lawall@lip6.fr>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:2147 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751145AbdGOJHc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 15 Jul 2017 05:07:32 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: kernel-janitors@vger.kernel.org, Eduardo Valentin <edubezval@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org

Device node iterators perform an of_node_put on each iteration, so putting
an of_node_put before a continue results in a double put.

The semantic match that finds this problem is as follows
(http://coccinelle.lip6.fr):

// <smpl>
@@
expression e1;
local idexpression child;
iterator name for_each_child_of_node;
@@

 for_each_child_of_node(e1,child) {
   ... when != of_node_get(child)
*  of_node_put(child);
   ...
*  continue;
}
// </smpl>

Furthermore, the call to thermal_of_cooling_device_register immediately
calls __thermal_cooling_device_register with the same arguments.  The
latter function stores the device node argument, which is the second
argument of for_each_child_of_node, in the returned thermal_cooling_device
structure.  This returned structure is then stored in the cdev field of
stc.  Thus it seems that the second argument of for_each_child_of_node
escapes the scope of the for_each_child_of_node, so an explicit of_node_get
on success of thermal_of_cooling_device_register is also needed.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/thermal/tegra/soctherm.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soctherm.c
index 7d2db23..10f4fdd 100644
--- a/drivers/thermal/tegra/soctherm.c
+++ b/drivers/thermal/tegra/soctherm.c
@@ -1014,7 +1014,6 @@ static void soctherm_init_hw_throt_cdev(struct platform_device *pdev)
 		tcd = thermal_of_cooling_device_register(np_stcc,
 							 (char *)name, ts,
 							 &throt_cooling_ops);
-		of_node_put(np_stcc);
 		if (IS_ERR_OR_NULL(tcd)) {
 			dev_err(dev,
 				"throttle-cfg: %s: failed to register cooling device\n",
@@ -1022,6 +1021,7 @@ static void soctherm_init_hw_throt_cdev(struct platform_device *pdev)
 			continue;
 		}
 
+		of_node_get(np_stcc);
 		stc->cdev = tcd;
 		stc->init = true;
 	}
