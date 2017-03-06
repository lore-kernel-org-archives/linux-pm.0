From: =?UTF-8?q?Niklas=20S=C3=B6derlund?=
        <niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCH 2/7] thermal: rcar_gen3_thermal: fix probe error path
Date: Mon,  6 Mar 2017 21:03:56 +0100
Message-ID: <20170306200401.29923-3-niklas.soderlund+renesas@ragnatech.se>
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

If the memory resource for a TSC is unviable probe should fail not try
to go ahead with the remaining TSC. This fix is aligned with other
checks in probe where probe fails if they are unavailable.

Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
---
 drivers/thermal/rcar_gen3_thermal.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_thermal.c
index ec477d47d0bae8e5..97958f91047b4c3a 100644
--- a/drivers/thermal/rcar_gen3_thermal.c
+++ b/drivers/thermal/rcar_gen3_thermal.c
@@ -289,8 +289,10 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
 		}
 
 		res = platform_get_resource(pdev, IORESOURCE_MEM, i);
-		if (!res)
-			break;
+		if (!res) {
+			ret = -ENODEV;
+			goto error_unregister;
+		}
 
 		tsc->base = devm_ioremap_resource(dev, res);
 		if (IS_ERR(tsc->base)) {
-- 
2.12.0
