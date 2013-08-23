From: Ranganath Krishnan <ranganath@ti.com>
Subject: [PATCH 3/3] thermal: ti-soc-thermal: Ensure to compute thermal trend
Date: Fri, 23 Aug 2013 11:08:23 -0500
Message-ID: <1377274103-27770-3-git-send-email-ranganath@ti.com>
References: <1377274103-27770-1-git-send-email-ranganath@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:40783 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754825Ab3HWQJA (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 23 Aug 2013 12:09:00 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id r7NG90qB013469
	for <linux-pm@vger.kernel.org>; Fri, 23 Aug 2013 11:09:00 -0500
Received: from DFLE73.ent.ti.com (dfle73.ent.ti.com [128.247.5.110])
	by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id r7NG90hT017558
	for <linux-pm@vger.kernel.org>; Fri, 23 Aug 2013 11:09:00 -0500
In-Reply-To: <1377274103-27770-1-git-send-email-ranganath@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, Eduardo Valentin <eduardo.valentin@ti.com>
Cc: Praneeth Bajjuri <praneeth@ti.com>, Ranganath Krishnan <ranganath@ti.com>

Workaround to compute thermal trend even when update interval
is not set. This patch will ensure to compute the thermal trend
when bandgap counter delay is not set.

Signed-off-by: Ranganath Krishnan <ranganath@ti.com>
Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
---
 drivers/thermal/ti-soc-thermal/ti-bandgap.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/ti-soc-thermal/ti-bandgap.c b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
index 9dfd471..74c0e34 100644
--- a/drivers/thermal/ti-soc-thermal/ti-bandgap.c
+++ b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
@@ -1020,9 +1020,13 @@ int ti_bandgap_get_trend(struct ti_bandgap *bgp, int id, int *trend)
 
 	/* Fetch the update interval */
 	ret = ti_bandgap_read_update_interval(bgp, id, &interval);
-	if (ret || !interval)
+	if (ret)
 		goto unfreeze;
 
+	/* Set the interval to 1 ms if bandgap counter delay is not set */
+	if (interval == 0)
+		interval = 1;
+
 	*trend = (t1 - t2) / interval;
 
 	dev_dbg(bgp->dev, "The temperatures are t1 = %d and t2 = %d and trend =%d\n",
-- 
1.7.9.5

