From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 1/2] thermal: rcar: Fix race condition between init and interrupt
Date: Mon, 23 Feb 2015 16:37:24 +0100
Message-ID: <1424705845-17726-2-git-send-email-geert+renesas@glider.be>
References: <1424705845-17726-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from laurent.telenet-ops.be ([195.130.137.89]:50628 "EHLO
	laurent.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752740AbbBWPha (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 23 Feb 2015 10:37:30 -0500
In-Reply-To: <1424705845-17726-1-git-send-email-geert+renesas@glider.be>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

As soon as the interrupt has been enabled by devm_request_irq(), the
interrupt routine may be called, depending on the current status of the
hardware.

However, at that point rcar_thermal_common hasn't been initialized
complely yet. E.g. rcar_thermal_common.base is still NULL, causing a
NULL pointer dereference:

    Unable to handle kernel NULL pointer dereference at virtual address 0000000c
    pgd = c0004000
    [0000000c] *pgd=00000000
    Internal error: Oops: 5 [#1] SMP ARM
    CPU: 0 PID: 1 Comm: swapper/0 Not tainted 3.19.0-rc7-ape6evm-04564-gb6e46cb7cbe82389 #30
    Hardware name: Generic R8A73A4 (Flattened Device Tree)
    task: ee8953c0 ti: ee896000 task.ti: ee896000
    PC is at rcar_thermal_irq+0x1c/0xf0
    LR is at _raw_spin_lock_irqsave+0x48/0x54

Postpone the call to devm_request_irq() until all initialization has
been done to fix this.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
This triggers sporadically on r8a73a4/ape6evm when starting a new
kernel after a soft power-on reset.

So far I couldn't trigger it on r8a7791/koelsch, not even by adding a
delay just after the call to devm_request_irq().
Probably none of the reboot methods on koelsch are sufficiently "soft"
(da9063-watchdog power-cycles the da9063 regulator, reset button resets
the r2a11302 regulator, even rwdt-restart on SMP=n seems fine)

v2:
  - Add Acked-by.
---
 drivers/thermal/rcar_thermal.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
index 2580a4872f90febe..3c2c1720ba4a4a72 100644
--- a/drivers/thermal/rcar_thermal.c
+++ b/drivers/thermal/rcar_thermal.c
@@ -387,21 +387,9 @@ static int rcar_thermal_probe(struct platform_device *pdev)
 
 	irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
 	if (irq) {
-		int ret;
-
 		/*
 		 * platform has IRQ support.
 		 * Then, driver uses common registers
-		 */
-
-		ret = devm_request_irq(dev, irq->start, rcar_thermal_irq, 0,
-				       dev_name(dev), common);
-		if (ret) {
-			dev_err(dev, "irq request failed\n ");
-			return ret;
-		}
-
-		/*
 		 * rcar_has_irq_support() will be enabled
 		 */
 		res = platform_get_resource(pdev, IORESOURCE_MEM, mres++);
@@ -456,8 +444,16 @@ static int rcar_thermal_probe(struct platform_device *pdev)
 	}
 
 	/* enable temperature comparation */
-	if (irq)
+	if (irq) {
+		ret = devm_request_irq(dev, irq->start, rcar_thermal_irq, 0,
+				       dev_name(dev), common);
+		if (ret) {
+			dev_err(dev, "irq request failed\n ");
+			goto error_unregister;
+		}
+
 		rcar_thermal_common_write(common, ENR, enr_bits);
+	}
 
 	platform_set_drvdata(pdev, common);
 
-- 
1.9.1

