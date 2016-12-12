From: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
Subject: [PATCHv5 5/5] thermal: rcar_gen3_thermal: Add delay in .thermal_init on r8a7795
Date: Mon, 12 Dec 2016 15:18:05 +0100
Message-ID: <20161212141805.14946-6-niklas.soderlund@ragnatech.se>
References: <20161212141805.14946-1-niklas.soderlund@ragnatech.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp-4.sys.kth.se ([130.237.48.193]:52503 "EHLO
        smtp-4.sys.kth.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752847AbcLLOUQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Dec 2016 09:20:16 -0500
In-Reply-To: <20161212141805.14946-1-niklas.soderlund@ragnatech.se>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, Khiem Nguyen <khiem.nguyen.xt@renesas.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Cc: linux-renesas-soc@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>

From: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

The .thermal_init needs to be delayed a short amount of time after
setting REG_GEN3_CTSR to allow for the TEMP register to contain
something useful. If it's not delayed theses warnings are common during
boot:

thermal thermal_zone0: failed to read out thermal zone (-5)
thermal thermal_zone1: failed to read out thermal zone (-5)
thermal thermal_zone2: failed to read out thermal zone (-5)

The warnings are triggered by the first call to .get_temp while the TEMP
register contains 0 and rcar_gen3_thermal_get_temp() returns -EIO since
a TEMP value of 0 will result in a temperature reading which is out of
specifications.

Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
---
 drivers/thermal/rcar_gen3_thermal.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_thermal.c
index 7d78498..085daec 100644
--- a/drivers/thermal/rcar_gen3_thermal.c
+++ b/drivers/thermal/rcar_gen3_thermal.c
@@ -199,6 +199,8 @@ static void r8a7795_thermal_init(struct rcar_gen3_thermal_tsc *tsc)
 	rcar_gen3_thermal_write(tsc, REG_GEN3_CTSR,
 				CTSR_PONM | CTSR_AOUT | CTSR_THBGR | CTSR_VMEN |
 				CTSR_VMST | CTSR_THSST);
+
+	usleep_range(1000, 2000);
 }
 
 static void r8a7796_thermal_init(struct rcar_gen3_thermal_tsc *tsc)
-- 
2.10.2

