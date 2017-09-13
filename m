From: =?UTF-8?q?Niklas=20S=C3=B6derlund?=
        <niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCH] thermal: rcar_gen3_thermal: fix initialization sequence for H3 ES2.0
Date: Wed, 13 Sep 2017 12:55:22 +0200
Message-ID: <20170913105522.12880-1-niklas.soderlund+renesas@ragnatech.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
List-Id: linux-pm@vger.kernel.org

The initialization sequence for H3 (r8a7795) ES1.x and ES2.0 is
different. H3 ES2.0 and later uses the same sequence as M3 (r8a7796)
ES1.0. Fix this by swapping place of the two initialization functions
and calling the r8a7796 init function from the r8a7795 init function if
the ES version is not "ES1.*".

Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
---
 drivers/thermal/rcar_gen3_thermal.c | 54 ++++++++++++++++++++++---------------
 1 file changed, 33 insertions(+), 21 deletions(-)

diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_thermal.c
index 203aca44a2bb4bdf..528a65b05b304ca3 100644
--- a/drivers/thermal/rcar_gen3_thermal.c
+++ b/drivers/thermal/rcar_gen3_thermal.c
@@ -24,6 +24,7 @@
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/spinlock.h>
+#include <linux/sys_soc.h>
 #include <linux/thermal.h>
 
 #include "thermal_core.h"
@@ -278,48 +279,59 @@ static irqreturn_t rcar_gen3_thermal_irq_thread(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static void r8a7795_thermal_init(struct rcar_gen3_thermal_tsc *tsc)
+static const struct soc_device_attribute r8a7795es1[] = {
+	{ .soc_id = "r8a7795", .revision = "ES1.*" },
+	{ /* sentinel */ }
+};
+
+static void r8a7796_thermal_init(struct rcar_gen3_thermal_tsc *tsc)
 {
-	rcar_gen3_thermal_write(tsc, REG_GEN3_CTSR,  CTSR_THBGR);
-	rcar_gen3_thermal_write(tsc, REG_GEN3_CTSR,  0x0);
+	u32 reg_val;
 
-	usleep_range(1000, 2000);
+	reg_val = rcar_gen3_thermal_read(tsc, REG_GEN3_THCTR);
+	reg_val &= ~THCTR_PONM;
+	rcar_gen3_thermal_write(tsc, REG_GEN3_THCTR, reg_val);
 
-	rcar_gen3_thermal_write(tsc, REG_GEN3_CTSR, CTSR_PONM);
+	usleep_range(1000, 2000);
 
 	rcar_gen3_thermal_write(tsc, REG_GEN3_IRQCTL, 0x3F);
 	rcar_gen3_thermal_write(tsc, REG_GEN3_IRQMSK, 0);
 	rcar_gen3_thermal_write(tsc, REG_GEN3_IRQEN, IRQ_TEMPD1 | IRQ_TEMP2);
 
-	rcar_gen3_thermal_write(tsc, REG_GEN3_CTSR,
-				CTSR_PONM | CTSR_AOUT | CTSR_THBGR | CTSR_VMEN);
-
-	usleep_range(100, 200);
-
-	rcar_gen3_thermal_write(tsc, REG_GEN3_CTSR,
-				CTSR_PONM | CTSR_AOUT | CTSR_THBGR | CTSR_VMEN |
-				CTSR_VMST | CTSR_THSST);
+	reg_val = rcar_gen3_thermal_read(tsc, REG_GEN3_THCTR);
+	reg_val |= THCTR_THSST;
+	rcar_gen3_thermal_write(tsc, REG_GEN3_THCTR, reg_val);
 
 	usleep_range(1000, 2000);
 }
 
-static void r8a7796_thermal_init(struct rcar_gen3_thermal_tsc *tsc)
+static void r8a7795_thermal_init(struct rcar_gen3_thermal_tsc *tsc)
 {
-	u32 reg_val;
+	/* H3 ES2.0 and later uses same initialization sequence as M3 ES1.0 */
+	if (!soc_device_match(r8a7795es1)) {
+		r8a7796_thermal_init(tsc);
+		return;
+	}
 
-	reg_val = rcar_gen3_thermal_read(tsc, REG_GEN3_THCTR);
-	reg_val &= ~THCTR_PONM;
-	rcar_gen3_thermal_write(tsc, REG_GEN3_THCTR, reg_val);
+	rcar_gen3_thermal_write(tsc, REG_GEN3_CTSR,  CTSR_THBGR);
+	rcar_gen3_thermal_write(tsc, REG_GEN3_CTSR,  0x0);
 
 	usleep_range(1000, 2000);
 
+	rcar_gen3_thermal_write(tsc, REG_GEN3_CTSR, CTSR_PONM);
+
 	rcar_gen3_thermal_write(tsc, REG_GEN3_IRQCTL, 0x3F);
 	rcar_gen3_thermal_write(tsc, REG_GEN3_IRQMSK, 0);
 	rcar_gen3_thermal_write(tsc, REG_GEN3_IRQEN, IRQ_TEMPD1 | IRQ_TEMP2);
 
-	reg_val = rcar_gen3_thermal_read(tsc, REG_GEN3_THCTR);
-	reg_val |= THCTR_THSST;
-	rcar_gen3_thermal_write(tsc, REG_GEN3_THCTR, reg_val);
+	rcar_gen3_thermal_write(tsc, REG_GEN3_CTSR,
+				CTSR_PONM | CTSR_AOUT | CTSR_THBGR | CTSR_VMEN);
+
+	usleep_range(100, 200);
+
+	rcar_gen3_thermal_write(tsc, REG_GEN3_CTSR,
+				CTSR_PONM | CTSR_AOUT | CTSR_THBGR | CTSR_VMEN |
+				CTSR_VMST | CTSR_THSST);
 
 	usleep_range(1000, 2000);
 }
-- 
2.14.1
