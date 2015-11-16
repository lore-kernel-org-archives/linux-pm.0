From: Jiada Wang <jiada_wang@mentor.com>
Subject: [PATCH] thermal: of-thermal: Reduce log level for message when can't fine thermal zone
Date: Mon, 16 Nov 2015 17:10:05 +0900
Message-ID: <1447661405-28903-1-git-send-email-jiada_wang@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from relay1.mentorg.com ([192.94.38.131]:63590 "EHLO
	relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751397AbbKPILZ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 16 Nov 2015 03:11:25 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, jiada_wang@mentor.com

Some systems register thermal zone by themself and don't need to
have thermal zones node in DT. Therefore reduce the log level from
ERROR to DEBUG when thermal zone node can't be find in
of_thermal_destroy_zones().

Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
---
 drivers/thermal/of-thermal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
index 42b7d42..be4eedc 100644
--- a/drivers/thermal/of-thermal.c
+++ b/drivers/thermal/of-thermal.c
@@ -964,7 +964,7 @@ void of_thermal_destroy_zones(void)
 
 	np = of_find_node_by_name(NULL, "thermal-zones");
 	if (!np) {
-		pr_err("unable to find thermal zones\n");
+		pr_debug("unable to find thermal zones\n");
 		return;
 	}
 
-- 
2.4.5

