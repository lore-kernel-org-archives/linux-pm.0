From: =?UTF-8?q?Niklas=20S=C3=B6derlund?=
        <niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCH 1/7] thermal: rcar_gen3_thermal: add delay in .thermal_init on r8a7796
Date: Mon,  6 Mar 2017 21:03:55 +0100
Message-ID: <20170306200401.29923-2-niklas.soderlund+renesas@ragnatech.se>
References: <20170306200401.29923-1-niklas.soderlund+renesas@ragnatech.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20170306200401.29923-1-niklas.soderlund+renesas@ragnatech.se>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
List-Id: linux-pm@vger.kernel.org

The .thermal_init needs to be delayed a short amount of to allow for the
TEMP register to contain something useful. If it's not delayed theses
warnings are common during boot:

thermal thermal_zone0: failed to read out thermal zone (-5)
thermal thermal_zone1: failed to read out thermal zone (-5)
thermal thermal_zone2: failed to read out thermal zone (-5)

The warnings are triggered by the first call to .get_temp while the TEMP
register contains 0 and rcar_gen3_thermal_get_temp() returns -EIO since
a TEMP value of 0 will result in a temperature reading which is out of
specifications.

This should have been done in the initial commit which adds the driver
as the same issue was found and corrected for r8a7795.

Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
---
 drivers/thermal/rcar_gen3_thermal.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_thermal.c
index d33c845244b1d819..ec477d47d0bae8e5 100644
--- a/drivers/thermal/rcar_gen3_thermal.c
+++ b/drivers/thermal/rcar_gen3_thermal.c
@@ -222,6 +222,8 @@ static void r8a7796_thermal_init(struct rcar_gen3_thermal_tsc *tsc)
 	reg_val = rcar_gen3_thermal_read(tsc, REG_GEN3_THCTR);
 	reg_val |= THCTR_THSST;
 	rcar_gen3_thermal_write(tsc, REG_GEN3_THCTR, reg_val);
+
+	usleep_range(1000, 2000);
 }
 
 static const struct rcar_gen3_thermal_data r8a7795_data = {
-- 
2.12.0
