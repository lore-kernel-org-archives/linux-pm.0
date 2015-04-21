From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH/RFC 01/03] irqchip: renesas-irqc: Add irq_enable() and irq_disable()
Date: Wed, 22 Apr 2015 00:01:26 +0900
Message-ID: <20150421150126.14288.6375.sendpatchset@little-apple>
References: <20150421150115.14288.88519.sendpatchset@little-apple>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20150421150115.14288.88519.sendpatchset@little-apple>
Sender: linux-sh-owner@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: jason@lakedaemon.net, geert+renesas@glider.be, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, horms@verge.net.au, Magnus Damm <magnus.damm@gmail.com>, tglx@linutronix.de
List-Id: linux-pm@vger.kernel.org

From: Magnus Damm <damm+renesas@opensource.se>

Hook up ->irq_enable() and ->irq_disable() together with
->irq_mask() and ->irq_unmask(). This should not adjust
any code behaviour at all.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 drivers/irqchip/irq-renesas-irqc.c |   24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

--- 0001/drivers/irqchip/irq-renesas-irqc.c
+++ work/drivers/irqchip/irq-renesas-irqc.c	2015-04-21 23:09:53.116371520 +0900
@@ -76,24 +76,34 @@ static void irqc_dbg(struct irqc_irq *i,
 		str, i->requested_irq, i->hw_irq, i->domain_irq);
 }
 
-static void irqc_irq_enable(struct irq_data *d)
+static void irqc_irq_unmask(struct irq_data *d)
 {
 	struct irqc_priv *p = irq_data_get_irq_chip_data(d);
 	int hw_irq = irqd_to_hwirq(d);
 
-	irqc_dbg(&p->irq[hw_irq], "enable");
+	irqc_dbg(&p->irq[hw_irq], "unmask");
 	iowrite32(BIT(hw_irq), p->cpu_int_base + IRQC_EN_SET);
 }
 
-static void irqc_irq_disable(struct irq_data *d)
+static void irqc_irq_mask(struct irq_data *d)
 {
 	struct irqc_priv *p = irq_data_get_irq_chip_data(d);
 	int hw_irq = irqd_to_hwirq(d);
 
-	irqc_dbg(&p->irq[hw_irq], "disable");
+	irqc_dbg(&p->irq[hw_irq], "mask");
 	iowrite32(BIT(hw_irq), p->cpu_int_base + IRQC_EN_STS);
 }
 
+static void irqc_irq_enable(struct irq_data *d)
+{
+	irqc_irq_unmask(d);
+}
+
+static void irqc_irq_disable(struct irq_data *d)
+{
+	irqc_irq_mask(d);
+}
+
 static unsigned char irqc_sense[IRQ_TYPE_SENSE_MASK + 1] = {
 	[IRQ_TYPE_LEVEL_LOW]	= 0x01,
 	[IRQ_TYPE_LEVEL_HIGH]	= 0x02,
@@ -244,8 +254,10 @@ static int irqc_probe(struct platform_de
 
 	irq_chip = &p->irq_chip;
 	irq_chip->name = name;
-	irq_chip->irq_mask = irqc_irq_disable;
-	irq_chip->irq_unmask = irqc_irq_enable;
+	irq_chip->irq_enable = irqc_irq_enable;
+	irq_chip->irq_disable = irqc_irq_disable;
+	irq_chip->irq_mask = irqc_irq_mask;
+	irq_chip->irq_unmask = irqc_irq_unmask;
 	irq_chip->irq_set_type = irqc_irq_set_type;
 	irq_chip->irq_set_wake = irqc_irq_set_wake;
 	irq_chip->flags	= IRQCHIP_MASK_ON_SUSPEND;
