From: =?UTF-8?q?Niklas=20S=C3=B6derlund?=
        <niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCH v2 3/7] thermal: rcar_gen3_thermal: check that TSC exists before memory allocation
Date: Fri, 17 Mar 2017 16:52:56 +0100
Message-ID: <20170317155300.21566-4-niklas.soderlund+renesas@ragnatech.se>
References: <20170317155300.21566-1-niklas.soderlund+renesas@ragnatech.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20170317155300.21566-1-niklas.soderlund+renesas@ragnatech.se>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
List-Id: linux-pm@vger.kernel.org

Move the check for a TSC resource before allocating memory for a new
TSC. If no TSC is found there is little point in allocating memory for
it.

Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
---
 drivers/thermal/rcar_gen3_thermal.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_thermal.c
index cb5c362c00009921..9b6bc03dd142a8dd 100644
--- a/drivers/thermal/rcar_gen3_thermal.c
+++ b/drivers/thermal/rcar_gen3_thermal.c
@@ -276,16 +276,16 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
 	for (i = 0; i < TSC_MAX_NUM; i++) {
 		struct rcar_gen3_thermal_tsc *tsc;
 
+		res = platform_get_resource(pdev, IORESOURCE_MEM, i);
+		if (!res)
+			break;
+
 		tsc = devm_kzalloc(dev, sizeof(*tsc), GFP_KERNEL);
 		if (!tsc) {
 			ret = -ENOMEM;
 			goto error_unregister;
 		}
 
-		res = platform_get_resource(pdev, IORESOURCE_MEM, i);
-		if (!res)
-			break;
-
 		tsc->base = devm_ioremap_resource(dev, res);
 		if (IS_ERR(tsc->base)) {
 			ret = PTR_ERR(tsc->base);
-- 
2.12.0
