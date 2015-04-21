From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH/RFC 02/03] irqchip: renesas-irqc: Add fine grained Runtime PM code
Date: Wed, 22 Apr 2015 00:01:37 +0900
Message-ID: <20150421150137.14288.45064.sendpatchset@little-apple>
References: <20150421150115.14288.88519.sendpatchset@little-apple>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150421150115.14288.88519.sendpatchset@little-apple>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: jason@lakedaemon.net, geert+renesas@glider.be, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, horms@verge.net.au, Magnus Damm <magnus.damm@gmail.com>, tglx@linutronix.de
List-Id: linux-pm@vger.kernel.org

From: Magnus Damm <damm+renesas@opensource.se>

Convert Runtime PM support from coarse grained "always enabled"
into more fine grained per-interrupt optional enablement.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 drivers/irqchip/irq-renesas-irqc.c |   11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

--- 0002/drivers/irqchip/irq-renesas-irqc.c
+++ work/drivers/irqchip/irq-renesas-irqc.c	2015-04-21 23:16:17.686370138 +0900
@@ -96,12 +96,18 @@ static void irqc_irq_mask(struct irq_dat
 
 static void irqc_irq_enable(struct irq_data *d)
 {
+	struct irqc_priv *p = irq_data_get_irq_chip_data(d);
+
+	pm_runtime_get_sync(&p->pdev->dev);
 	irqc_irq_unmask(d);
 }
 
 static void irqc_irq_disable(struct irq_data *d)
 {
+	struct irqc_priv *p = irq_data_get_irq_chip_data(d);
+
 	irqc_irq_mask(d);
+	pm_runtime_put(&p->pdev->dev);
 }
 
 static unsigned char irqc_sense[IRQ_TYPE_SENSE_MASK + 1] = {
@@ -124,10 +130,12 @@ static int irqc_irq_set_type(struct irq_
 	if (!value)
 		return -EINVAL;
 
+	pm_runtime_get_sync(&p->pdev->dev);
 	tmp = ioread32(p->iomem + IRQC_CONFIG(hw_irq));
 	tmp &= ~0x3f;
 	tmp |= value;
 	iowrite32(tmp, p->iomem + IRQC_CONFIG(hw_irq));
+	pm_runtime_put(&p->pdev->dev);
 	return 0;
 }
 
@@ -215,7 +223,6 @@ static int irqc_probe(struct platform_de
 	}
 
 	pm_runtime_enable(&pdev->dev);
-	pm_runtime_get_sync(&pdev->dev);
 
 	/* get hold of manadatory IOMEM */
 	io = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -300,7 +307,6 @@ err3:
 err2:
 	iounmap(p->iomem);
 err1:
-	pm_runtime_put(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 	kfree(p);
 err0:
@@ -317,7 +323,6 @@ static int irqc_remove(struct platform_d
 
 	irq_domain_remove(p->irq_domain);
 	iounmap(p->iomem);
-	pm_runtime_put(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 	kfree(p);
 	return 0;
