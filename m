From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH] thermal: ti-soc-thermal: fix error check
Date: Mon, 23 Nov 2015 18:24:41 +0530
Message-ID: <1448283281-21402-1-git-send-email-sudipm.mukherjee@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:36064 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751173AbbKWMyu (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 23 Nov 2015 07:54:50 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>

We were only checking if data is not NULL but
ti_bandgap_get_sensor_data() can return NULL or ERR_PTR.

Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---
 drivers/thermal/ti-soc-thermal/ti-thermal-common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
index b213a12..d76bb7c 100644
--- a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
+++ b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
@@ -365,7 +365,7 @@ int ti_thermal_remove_sensor(struct ti_bandgap *bgp, int id)
 
 	data = ti_bandgap_get_sensor_data(bgp, id);
 
-	if (data && data->ti_thermal) {
+	if (!IS_ERR_OR_NULL(data) && data->ti_thermal) {
 		if (data->our_zone)
 			thermal_zone_device_unregister(data->ti_thermal);
 		else
-- 
1.9.1

