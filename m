From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH 1/2] thermal: rcar: add rcar_zone_to_priv() macro
Date: Sun, 25 Nov 2012 17:24:47 +0800
Message-ID: <1353835487.2176.6.camel@rzhang1-mobl4>
References: <87sj82uo7o.wl%kuninori.morimoto.gx@renesas.com>
	 <87r4nmuo66.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:64346 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751923Ab2KYJYw (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 25 Nov 2012 04:24:52 -0500
In-Reply-To: <87r4nmuo66.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Simon <horms@verge.net.au>, Magnus <magnus.damm@gmail.com>, linux-pm@vger.kernel.org

On Wed, 2012-11-21 at 22:50 -0800, Kuninori Morimoto wrote:
> This patch adds rcar_zone_to_priv()
> which is a helper macro for gettign private data.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Patch rebased on thermal next.

>From 5d251a94e56673b4fd22451c068a7a410cd6c687 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 21 Nov 2012 22:50:12 -0800
Subject: [PATCH] thermal: rcar: add rcar_zone_to_priv() macro

This patch adds rcar_zone_to_priv()
which is a helper macro for gettign private data.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/thermal/rcar_thermal.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
index 81dce23..b8e6ffc 100644
--- a/drivers/thermal/rcar_thermal.c
+++ b/drivers/thermal/rcar_thermal.c
@@ -43,6 +43,8 @@ struct rcar_thermal_priv {
 	u32 comp;
 };
 
+#define rcar_zone_to_priv(zone)		(zone->devdata)
+
 /*
  *		basic functions
  */
@@ -96,7 +98,7 @@ static void rcar_thermal_bset(struct rcar_thermal_priv *priv, u32 reg,
 static int rcar_thermal_get_temp(struct thermal_zone_device *zone,
 			   unsigned long *temp)
 {
-	struct rcar_thermal_priv *priv = zone->devdata;
+	struct rcar_thermal_priv *priv = rcar_zone_to_priv(zone);
 	int val, min, max, tmp;
 
 	tmp = -200; /* default */
-- 
1.7.7.6



