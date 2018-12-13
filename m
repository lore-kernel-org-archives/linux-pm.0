From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Subject: [PATCH] thermal: rcar_thermal: add R8A774C0 support
Date: Thu, 13 Dec 2018 20:23:10 +0000
Message-ID: <1544732590-7230-1-git-send-email-fabrizio.castro@bp.renesas.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Fabrizio Castro <fabrizio.castro@bp.renesas.com>, Zhang Rui <rui.zhang@intel.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Simon Horman <horms@verge.net.au>, Geert Uytterhoeven <geert+renesas@glider.be>, Chris Paterson <Chris.Paterson2@renesas.com>, Biju Das <biju.das@bp.renesas.com>, linux-renesas-soc@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Add thermal support for the RZ/G2E SoC (a.k.a. R8A774C0).

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 drivers/thermal/rcar_thermal.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
index 30a12b8..97462e9 100644
--- a/drivers/thermal/rcar_thermal.c
+++ b/drivers/thermal/rcar_thermal.c
@@ -113,6 +113,10 @@ static const struct of_device_id rcar_thermal_dt_ids[] = {
 		 .data = &rcar_gen2_thermal,
 	},
 	{
+		.compatible = "renesas,thermal-r8a774c0",
+		.data = &rcar_gen3_thermal,
+	},
+	{
 		.compatible = "renesas,thermal-r8a77970",
 		.data = &rcar_gen3_thermal,
 	},
-- 
2.7.4
