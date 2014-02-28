From: Patrick Titiano <ptitiano@baylibre.com>
Subject: [PATCH 1/2] thermal: rcar-thermal: fix same mask applied twice
Date: Fri, 28 Feb 2014 14:10:03 +0100
Message-ID: <1393593004-16285-2-git-send-email-ptitiano@baylibre.com>
References: <1393593004-16285-1-git-send-email-ptitiano@baylibre.com>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1393593004-16285-1-git-send-email-ptitiano@baylibre.com>
Sender: linux-sh-owner@vger.kernel.org
To: magnus.damm@gmail.com, kuninori.morimoto.gx@renesas.com, eduardo.valentin@ti.com
Cc: bcousson@baylibre.com, linux-pm@vger.kernel.org, linux-sh@vger.kernel.org, Patrick Titiano <ptitiano@baylibre.com>
List-Id: linux-pm@vger.kernel.org

Mask is already applied preceding the if statement.
Remove the second mask.

Signed-off-by: Patrick Titiano <ptitiano@baylibre.com>
---
 drivers/thermal/rcar_thermal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
index e2bb589..6ea8c5c 100644
--- a/drivers/thermal/rcar_thermal.c
+++ b/drivers/thermal/rcar_thermal.c
@@ -316,7 +316,7 @@ static u32 rcar_thermal_had_changed(struct rcar_thermal_priv *priv, u32 status)
 
 	status = (status >> rcar_id_to_shift(priv)) & 0x3;
 
-	if (status & 0x3) {
+	if (status) {
 		dev_dbg(dev, "thermal%d %s%s\n",
 			priv->id,
 			(status & 0x2) ? "Rising " : "",
-- 
1.8.3.2

