From: =?UTF-8?q?Niklas=20S=C3=B6derlund?=
        <niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCH 4/7] thermal: rcar_gen3_thermal: record more information about each TSC
Date: Mon,  6 Mar 2017 21:03:58 +0100
Message-ID: <20170306200401.29923-5-niklas.soderlund+renesas@ragnatech.se>
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

The struct rcar_gen3_thermal_tsc benefits from knowing which TSC it
represent. Record this at probe time before this information is lost.

Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
---
 drivers/thermal/rcar_gen3_thermal.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_thermal.c
index 5d4a5483eb13e796..65f7204936a18278 100644
--- a/drivers/thermal/rcar_gen3_thermal.c
+++ b/drivers/thermal/rcar_gen3_thermal.c
@@ -68,6 +68,8 @@ struct equation_coefs {
 };
 
 struct rcar_gen3_thermal_tsc {
+	struct device *dev;
+	int num;
 	void __iomem *base;
 	struct thermal_zone_device *zone;
 	struct equation_coefs coef;
@@ -282,6 +284,9 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
 			goto error_unregister;
 		}
 
+		tsc->dev = dev;
+		tsc->num = i;
+
 		res = platform_get_resource(pdev, IORESOURCE_MEM, i);
 		if (!res) {
 			ret = -ENODEV;
-- 
2.12.0
