From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: [PATCH] power: supply: act8945a_charger: fix of_irq_get() error check
Date: Sun, 16 Jul 2017 20:52:20 +0300
Message-ID: <20170716175244.300670810@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f44.google.com ([209.85.215.44]:34243 "EHLO
        mail-lf0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751216AbdGPRwu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 16 Jul 2017 13:52:50 -0400
Received: by mail-lf0-f44.google.com with SMTP id t72so75086455lff.1
        for <linux-pm@vger.kernel.org>; Sun, 16 Jul 2017 10:52:49 -0700 (PDT)
Content-Disposition: inline; filename=power-supply-act8945a_charger-fix-of_irq_get-error-check.patch
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Cc: Wenyou Yang <wenyou.yang@atmel.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

of_irq_get() may return any negative error number as well as 0 on failure,
while the driver only checks for -EPROBE_DEFER, blithely continuing with
the call to devm_request_irq() -- that function expects *unsigned int*,
so would probably fail anyway when a large IRQ number resulting from a
conversion of a negative error number is passed to it... This, however,
is incorrect behavior -- error number is not IRQ number.

Check for 'irq <= 0' instead and return -ENXIO from probe if of_irq_get()
returned 0.

Fixes: a09209acd6a8 ("power: supply: act8945a_charger: Add status change update support")
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 drivers/power/supply/act8945a_charger.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux/drivers/power/supply/act8945a_charger.c
===================================================================
--- linux.orig/drivers/power/supply/act8945a_charger.c
+++ linux/drivers/power/supply/act8945a_charger.c
@@ -596,9 +596,9 @@ static int act8945a_charger_probe(struct
 		return ret;
 
 	irq = of_irq_get(pdev->dev.of_node, 0);
-	if (irq == -EPROBE_DEFER) {
+	if (irq <= 0) {
 		dev_err(&pdev->dev, "failed to find IRQ number\n");
-		return -EPROBE_DEFER;
+		return irq ?: -ENXIO;
 	}
 
 	ret = devm_request_irq(&pdev->dev, irq, act8945a_status_changed,
