From: =?UTF-8?q?Niklas=20S=C3=B6derlund?=
        <niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCH v2 4/7] thermal: rcar_gen3_thermal: record and check number of TSCs found
Date: Fri, 17 Mar 2017 16:52:57 +0100
Message-ID: <20170317155300.21566-5-niklas.soderlund+renesas@ragnatech.se>
References: <20170317155300.21566-1-niklas.soderlund+renesas@ragnatech.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp-4.sys.kth.se ([130.237.48.193]:56335 "EHLO
        smtp-4.sys.kth.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751061AbdCQQCG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 Mar 2017 12:02:06 -0400
In-Reply-To: <20170317155300.21566-1-niklas.soderlund+renesas@ragnatech.se>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>

Record how many TSCs are found in struct rcar_gen3_thermal_priv, this is
needed to be able to add hardware interrupts for trip points later. Also
add a check to make sure at least one TSC is found.

Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
---
 drivers/thermal/rcar_gen3_thermal.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_thermal.c
index 9b6bc03dd142a8dd..3b6e85abfadc61a3 100644
--- a/drivers/thermal/rcar_gen3_thermal.c
+++ b/drivers/thermal/rcar_gen3_thermal.c
@@ -74,6 +74,7 @@ struct rcar_gen3_thermal_tsc {
 };
 
 struct rcar_gen3_thermal_priv {
+	unsigned int num_tscs;
 	struct rcar_gen3_thermal_tsc *tscs[TSC_MAX_NUM];
 };
 
@@ -305,6 +306,12 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
 			goto error_unregister;
 		}
 		tsc->zone = zone;
+		priv->num_tscs++;
+	}
+
+	if (!priv->num_tscs) {
+		ret = -ENODEV;
+		goto error_unregister;
 	}
 
 	return 0;
-- 
2.12.0
