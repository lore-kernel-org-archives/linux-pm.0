Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29C03C433EF
	for <linux-pm@archiver.kernel.org>; Fri, 22 Jul 2022 16:58:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbiGVQ61 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 22 Jul 2022 12:58:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbiGVQ60 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 22 Jul 2022 12:58:26 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6100A31201
        for <linux-pm@vger.kernel.org>; Fri, 22 Jul 2022 09:58:25 -0700 (PDT)
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1oEvyj-0006kd-NC; Fri, 22 Jul 2022 18:58:17 +0200
From:   Lucas Stach <l.stach@pengutronix.de>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, patchwork-lst@pengutronix.de
Subject: [PATCH] thermal: imx8mm: register with hwmon subsystem
Date:   Fri, 22 Jul 2022 18:58:15 +0200
Message-Id: <20220722165815.1601124-1-l.stach@pengutronix.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::28
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Provide standard sensor monitoring via the HWMON subsystem by
registering the sensors with hwmon when CONFIG_THERMAL_HWMON is
enabled.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 drivers/thermal/imx8mm_thermal.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/thermal/imx8mm_thermal.c b/drivers/thermal/imx8mm_thermal.c
index af666bd9e8d4..74120edbbdfd 100644
--- a/drivers/thermal/imx8mm_thermal.c
+++ b/drivers/thermal/imx8mm_thermal.c
@@ -16,6 +16,7 @@
 #include <linux/thermal.h>
 
 #include "thermal_core.h"
+#include "thermal_hwmon.h"
 
 #define TER			0x0	/* TMU enable */
 #define TPS			0x4
@@ -176,6 +177,10 @@ static int imx8mm_tmu_probe(struct platform_device *pdev)
 			goto disable_clk;
 		}
 		tmu->sensors[i].hw_id = i;
+
+		if (devm_thermal_add_hwmon_sysfs(tmu->sensors[i].tzd))
+			dev_warn(&pdev->dev,
+				 "Failed to add hwmon sysfs attributes\n");
 	}
 
 	platform_set_drvdata(pdev, tmu);
-- 
2.30.2

