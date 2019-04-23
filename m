From: Jiada Wang <jiada_wang@mentor.com>
Subject: [PATCH v2 2/2] thermal: rcar_gen3_thermal: disable interrupt in .remove
Date: Tue, 23 Apr 2019 15:12:18 +0900
Message-ID: <20190423061218.29705-3-jiada_wang@mentor.com>
References: <20190423061218.29705-1-jiada_wang@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190423061218.29705-1-jiada_wang@mentor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com, daniel.lezcano@linaro.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, erosca@de.adit-jv.com, joshua_frkuska@mentor.com, jiada_wang@mentor.com, horms+renesas@verge.net.au, niklas.soderlund+renesas@ragnatech.se, geert+renesas@glider.be, sergei.shtylyov@cogentembedded.com, marek.vasut+renesas@gmail.com, kuninori.morimoto.gx@renesas.com, hien.dang.eb@renesas.com, fabrizio.castro@bp.renesas.com, dien.pham.ry@renesas.com, biju.das@bp.renesas.com
List-Id: linux-pm@vger.kernel.org

Currently IRQ is remain enabled after .remove, later if device is probed,
IRQ is requested before .thermal_init, this may cause IRQ function be
called before device is initialized.

this patch by disable interrupt in .remove, to ensure irq function
only be called after device is fully initialized.

Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
---
 drivers/thermal/rcar_gen3_thermal.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_thermal.c
index a11032e42f36..eb4e65b7ad8b 100644
--- a/drivers/thermal/rcar_gen3_thermal.c
+++ b/drivers/thermal/rcar_gen3_thermal.c
@@ -318,6 +318,9 @@ MODULE_DEVICE_TABLE(of, rcar_gen3_thermal_dt_ids);
 static int rcar_gen3_thermal_remove(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
+	struct rcar_gen3_thermal_priv *priv = dev_get_drvdata(dev);
+
+	rcar_thermal_irq_set(priv, false);
 
 	pm_runtime_put(dev);
 	pm_runtime_disable(dev);
-- 
2.19.2
