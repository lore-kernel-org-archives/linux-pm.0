From: Khiem Nguyen <khiem.nguyen.xt@rvc.renesas.com>
Subject: [PATCH/RFC 2/3] thermal: rcar_gen3_thermal: Modify the way to detect
 the interrupts
Date: Sun, 19 Jun 2016 11:15:38 +0700
Message-ID: <57661C6A.5050300@rvc.renesas.com>
References: <57661211.7010900@rvc.renesas.com>
 <57661BB1.3060401@rvc.renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from relmlor3.renesas.com ([210.160.252.173]:24522 "EHLO
	relmlie2.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750793AbcFSEPn (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 19 Jun 2016 00:15:43 -0400
In-Reply-To: <57661BB1.3060401@rvc.renesas.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <damm+renesas@opensource.se>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Rob Herring <robh+dt@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Thao Phuong Le. Nguyen" <thao.nguyen.yb@rvc.renesas.com>, "Hien Duy. Dang" <hien.dang.eb@rvc.renesas.com>, Toru Oishi <toru.oishi.zj@rvc.renesas.com>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Gaku Inami <gaku.inami.xw@bp.renesas.com>, Catalin Marinas <catalin.marinas@arm.com>, Simon Horman <horms@verge.net.au>, "Khiem Trong. Nguyen" <khiem.nguyen.xt@rvc.r>

The current implementation is that the interrupt I/F and thermal
sensor are assigned with one-to-one. So it can't be set the more
interrupt trigger to one thermal sensor. Also, the interrupt is
detected by a little bit change in temperature.

In order to solve the above problems, the interrupt of thermal
sensor is changed as below.
  - Change the shared interrupt in each thermal sensors.
  - Detect the interrupt when the temperature is changed
    one degree up and down.

Signed-off-by: Gaku Inami <gaku.inami.xw@bp.renesas.com>
Signed-off-by: Khiem Nguyen <khiem.nguyen.xt@rvc.renesas.com>
---
 drivers/thermal/rcar_gen3_thermal.c | 69 +++++++++++++++++++++++--------------
 1 file changed, 44 insertions(+), 25 deletions(-)

diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_thermal.c
index e640a14..dc5f231 100644
--- a/drivers/thermal/rcar_gen3_thermal.c
+++ b/drivers/thermal/rcar_gen3_thermal.c
@@ -63,6 +63,11 @@
 
 #define CTEMP_MASK	0xFFF
 
+#define IRQ_TEMP1_BIT	(0x1 << 0)
+#define IRQ_TEMP2_BIT	(0x1 << 1)
+#define IRQ_TEMPD1_BIT	(0x1 << 3)
+#define IRQ_TEMPD2_BIT	(0x1 << 4)
+
 #define MCELSIUS(temp)			((temp) * 1000)
 #define TEMP_IRQ_SHIFT(tsc_id)	(0x1 << tsc_id)
 #define TEMPD_IRQ_SHIFT(tsc_id)	(0x1 << (tsc_id + 3))
@@ -216,28 +221,42 @@ int _linear_temp_converter(struct equation_coefs coef,
 	return _round_temp(temp);
 }
 
+int _linear_celsius_to_temp(struct equation_coefs coef,
+					int ctemp)
+{
+	int temp_code, temp1, temp2;
+
+	temp1 = (ctemp * coef.a1 / 1000 + coef.b1) / 1000;
+	temp2 = (ctemp * coef.a2 / 1000 + coef.b2) / 1000;
+	temp_code = (temp1 + temp2) / 2;
+
+	return temp_code;
+}
+
 /*
  *		Zone device functions
  */
 static int rcar_gen3_thermal_update_temp(struct rcar_gen3_thermal_priv *priv)
 {
 	u32 ctemp;
-	int i;
 	unsigned long flags;
-	u32 reg = REG_GEN3_IRQTEMP1 + (priv->id * 4);
+	int temp_cel, temp_code;
 
 	spin_lock_irqsave(&priv->lock, flags);
 
-	for (i = 0; i < 256; i++) {
-		ctemp = thermal_reg_read(priv, REG_GEN3_TEMP) & CTEMP_MASK;
-		if (rcar_has_irq_support(priv)) {
-			thermal_reg_write(priv, reg, ctemp);
-			if (thermal_reg_read(priv, REG_GEN3_IRQSTR) != 0)
-				break;
-		} else
-			break;
+	ctemp = thermal_reg_read(priv, REG_GEN3_TEMP) & CTEMP_MASK;
+	if (rcar_has_irq_support(priv)) {
+		temp_cel = _linear_temp_converter(priv->coef, ctemp);
+
+		/* set the interrupts to exceed the temperature */
+		temp_code = _linear_celsius_to_temp(priv->coef,
+						    temp_cel + MCELSIUS(1));
+		thermal_reg_write(priv, REG_GEN3_IRQTEMP1, temp_code);
 
-		udelay(150);
+		/* set the interrupts to fall below the temperature */
+		temp_code = _linear_celsius_to_temp(priv->coef,
+						    temp_cel - MCELSIUS(1));
+		thermal_reg_write(priv, REG_GEN3_IRQTEMP2, temp_code);
 	}
 
 	priv->ctemp = ctemp;
@@ -283,14 +302,14 @@ static int r8a7795_thermal_init(struct rcar_gen3_thermal_priv *priv)
 
 	thermal_reg_write(priv, REG_GEN3_CTSR, PONM);
 	thermal_reg_write(priv, REG_GEN3_IRQCTL, 0x3F);
-	thermal_reg_write(priv, REG_GEN3_IRQEN, TEMP_IRQ_SHIFT(priv->id) |
-						TEMPD_IRQ_SHIFT(priv->id));
+	thermal_reg_write(priv, REG_GEN3_IRQEN,
+			   IRQ_TEMP1_BIT | IRQ_TEMPD2_BIT);
 	thermal_reg_write(priv, REG_GEN3_CTSR,
-			PONM | AOUT | THBGR | VMEN);
+			   PONM | AOUT | THBGR | VMEN);
 	udelay(100);
 
 	thermal_reg_write(priv, REG_GEN3_CTSR,
-			PONM | AOUT | THBGR | VMEN | VMST | THSST);
+			   PONM | AOUT | THBGR | VMEN | VMST | THSST);
 
 	spin_unlock_irqrestore(&priv->lock, flags);
 
@@ -305,11 +324,11 @@ static int r8a7796_thermal_init(struct rcar_gen3_thermal_priv *priv)
 	spin_lock_irqsave(&priv->lock, flags);
 	thermal_reg_write(priv, REG_GEN3_THCTR,  0x0);
 	udelay(1000);
+
 	thermal_reg_write(priv, REG_GEN3_IRQCTL, 0x3F);
-	thermal_reg_write(priv, REG_GEN3_IRQEN, TEMP_IRQ_SHIFT(priv->id) |
-						TEMPD_IRQ_SHIFT(priv->id));
-	thermal_reg_write(priv, REG_GEN3_THCTR,
-						CTCTL | THCNTSEN(BIT_LEN_12));
+	thermal_reg_write(priv, REG_GEN3_IRQEN,
+			   IRQ_TEMP1_BIT | IRQ_TEMPD2_BIT);
+	thermal_reg_write(priv, REG_GEN3_THCTR, CTCTL | THCNTSEN(BIT_LEN_12));
 	reg_val = thermal_reg_read(priv, REG_GEN3_THCTR);
 	reg_val &= ~CTCTL;
 	reg_val |= THSST;
@@ -334,8 +353,7 @@ static void _thermal_irq_ctrl(struct rcar_gen3_thermal_priv *priv, int enable)
 
 	spin_lock_irqsave(&priv->lock, flags);
 	thermal_reg_write(priv, REG_GEN3_IRQMSK,
-		enable ? (TEMP_IRQ_SHIFT(priv->id) |
-			TEMPD_IRQ_SHIFT(priv->id)) : 0);
+		enable ? (IRQ_TEMP1_BIT | IRQ_TEMPD2_BIT) : 0);
 	spin_unlock_irqrestore(&priv->lock, flags);
 }
 
@@ -361,11 +379,12 @@ static irqreturn_t rcar_gen3_thermal_irq(int irq, void *data)
 	thermal_reg_write(priv, REG_GEN3_IRQSTR, 0);
 	spin_unlock_irqrestore(&priv->lock, flags);
 
-	if ((status & TEMP_IRQ_SHIFT(priv->id)) ||
-		(status & TEMPD_IRQ_SHIFT(priv->id))) {
+	if (status == 0)
+		return IRQ_NONE;
+
+	if (status & (IRQ_TEMP1_BIT | IRQ_TEMPD2_BIT)) {
 		rcar_gen3_thermal_irq_disable(priv);
-		schedule_delayed_work(&priv->work,
-				      msecs_to_jiffies(300));
+		schedule_delayed_work(&priv->work, 0);
 	}
 
 	return IRQ_HANDLED;
-- 
1.9.1

