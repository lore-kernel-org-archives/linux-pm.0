From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 33/34] thermal: rcar: fixup the unit of temperature
Date: Sun,  2 Dec 2012 22:45:07 +0800
Message-ID: <1354459508-3707-33-git-send-email-rui.zhang@intel.com>
References: <1354459508-3707-1-git-send-email-rui.zhang@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:53720 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751673Ab2LBOqU (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 2 Dec 2012 09:46:20 -0500
In-Reply-To: <1354459508-3707-1-git-send-email-rui.zhang@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Zhang Rui <rui.zhang@intel.com>

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

The unit of temperature is Milli-Celsius.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/thermal/rcar_thermal.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
index 81dce23..f2678ff 100644
--- a/drivers/thermal/rcar_thermal.c
+++ b/drivers/thermal/rcar_thermal.c
@@ -43,6 +43,8 @@ struct rcar_thermal_priv {
 	u32 comp;
 };
 
+#define MCELSIUS(temp)			((temp) * 1000)
+
 /*
  *		basic functions
  */
@@ -169,7 +171,7 @@ static int rcar_thermal_get_temp(struct thermal_zone_device *zone,
 		}
 	}
 
-	*temp = tmp;
+	*temp = MCELSIUS(tmp);
 	return 0;
 }
 
-- 
1.7.7.6

