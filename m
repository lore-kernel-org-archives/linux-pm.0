From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 2/7] irqchip: renesas-irqc: Add minimal runtime PM support
Date: Wed, 18 Mar 2015 19:55:56 +0100
Message-ID: <1426704961-27322-3-git-send-email-geert+renesas@glider.be>
References: <1426704961-27322-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from michel.telenet-ops.be ([195.130.137.88]:36877 "EHLO
	michel.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933229AbbCRS4E (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 18 Mar 2015 14:56:04 -0400
In-Reply-To: <1426704961-27322-1-git-send-email-geert+renesas@glider.be>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: linux-sh@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

This is just enough to let pm_clk_*() enable the functional clock, and
manage it for suspend/resume, if present.
Before, it was assumed enabled by the bootloader or reset state.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/irqchip/irq-renesas-irqc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/irqchip/irq-renesas-irqc.c b/drivers/irqchip/irq-renesas-irqc.c
index 2ce2edf8ec8ec182..718f01cd1aea19f6 100644
--- a/drivers/irqchip/irq-renesas-irqc.c
+++ b/drivers/irqchip/irq-renesas-irqc.c
@@ -29,6 +29,7 @@
 #include <linux/slab.h>
 #include <linux/module.h>
 #include <linux/platform_data/irq-renesas-irqc.h>
+#include <linux/pm_runtime.h>
 
 #define IRQC_IRQ_MAX	32	/* maximum 32 interrupts per driver instance */
 
@@ -180,6 +181,9 @@ static int irqc_probe(struct platform_device *pdev)
 	p->pdev = pdev;
 	platform_set_drvdata(pdev, p);
 
+	pm_runtime_enable(&pdev->dev);
+	pm_runtime_get_sync(&pdev->dev);
+
 	/* get hold of manadatory IOMEM */
 	io = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!io) {
@@ -260,6 +264,8 @@ err3:
 err2:
 	iounmap(p->iomem);
 err1:
+	pm_runtime_put(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
 	kfree(p);
 err0:
 	return ret;
@@ -275,6 +281,8 @@ static int irqc_remove(struct platform_device *pdev)
 
 	irq_domain_remove(p->irq_domain);
 	iounmap(p->iomem);
+	pm_runtime_put(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
 	kfree(p);
 	return 0;
 }
-- 
1.9.1

