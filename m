From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH/TRIVIAL] thermal: rcar: Spelling/grammar: s/drier use .../driver uses ...s/
Date: Mon, 12 Jan 2015 17:33:59 +0100
Message-ID: <1421080439-17669-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from michel.telenet-ops.be ([195.130.137.88]:58356 "EHLO
	michel.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752129AbbALQeB (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 12 Jan 2015 11:34:01 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Jiri Kosina <trivial@kernel.org>
Cc: linux-pm@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/thermal/rcar_thermal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
index 8803e693fe6868a6..ce8ad180d10f83bf 100644
--- a/drivers/thermal/rcar_thermal.c
+++ b/drivers/thermal/rcar_thermal.c
@@ -390,7 +390,7 @@ static int rcar_thermal_probe(struct platform_device *pdev)
 
 		/*
 		 * platform has IRQ support.
-		 * Then, drier use common register
+		 * Then, driver uses common registers
 		 */
 
 		ret = devm_request_irq(dev, irq->start, rcar_thermal_irq, 0,
-- 
1.9.1

