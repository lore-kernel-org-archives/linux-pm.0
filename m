From: Laxman Dewangan <ldewangan@nvidia.com>
Subject: [PATCH-REPOST] thermal: of: look for sensor driver parent node if device node missing
Date: Fri, 25 Jul 2014 14:49:31 +0530
Message-ID: <1406279971-14957-1-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate15.nvidia.com ([216.228.121.64]:10117 "EHLO
	hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756909AbaGYJVP (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 25 Jul 2014 05:21:15 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rui.zhang@intel.com, eduardo.valentin@gmail.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, javi.merino@arm.com, Laxman Dewangan <ldewangan@nvidia.com>

There are some mfd devices which supports junction thermal interrupt
like ams,AS3722. The DT binding of these devices are defined as the
flat and drivers for sub module of such devices are registered as
the mfd_add_devices. In this method, the sub devices registered as
platform driver and these do not have the of_node pointer on their
device structure. In this case, use the parent of_node pointer to
get the required of_node pointer.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
---
I typed differnet email ID for Eduardo and so it did not reach to him.
Resending the patch with correct ID.

 drivers/thermal/of-thermal.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
index 04b1be7..85a7d71 100644
--- a/drivers/thermal/of-thermal.c
+++ b/drivers/thermal/of-thermal.c
@@ -396,6 +396,8 @@ thermal_zone_of_sensor_register(struct device *dev, int sensor_id,
 		return ERR_PTR(-EINVAL);
 
 	sensor_np = dev->of_node;
+	if (!sensor_np && dev->parent)
+		sensor_np = dev->parent->of_node;
 
 	for_each_child_of_node(np, child) {
 		struct of_phandle_args sensor_specs;
-- 
1.8.1.5

