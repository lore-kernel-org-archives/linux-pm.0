From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 34/34] thermal: rcar: add rcar_zone_to_priv() macro
Date: Sun,  2 Dec 2012 22:45:08 +0800
Message-ID: <1354459508-3707-34-git-send-email-rui.zhang@intel.com>
References: <1354459508-3707-1-git-send-email-rui.zhang@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:53720 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752159Ab2LBOqU (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 2 Dec 2012 09:46:20 -0500
In-Reply-To: <1354459508-3707-1-git-send-email-rui.zhang@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Zhang Rui <rui.zhang@intel.com>

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

This patch adds rcar_zone_to_priv()
which is a helper macro for gettign private data.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/thermal/rcar_thermal.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
index f2678ff..90db951 100644
--- a/drivers/thermal/rcar_thermal.c
+++ b/drivers/thermal/rcar_thermal.c
@@ -44,6 +44,7 @@ struct rcar_thermal_priv {
 };
 
 #define MCELSIUS(temp)			((temp) * 1000)
+#define rcar_zone_to_priv(zone)		(zone->devdata)
 
 /*
  *		basic functions
@@ -98,7 +99,7 @@ static void rcar_thermal_bset(struct rcar_thermal_priv *priv, u32 reg,
 static int rcar_thermal_get_temp(struct thermal_zone_device *zone,
 			   unsigned long *temp)
 {
-	struct rcar_thermal_priv *priv = zone->devdata;
+	struct rcar_thermal_priv *priv = rcar_zone_to_priv(zone);
 	int val, min, max, tmp;
 
 	tmp = -200; /* default */
-- 
1.7.7.6

