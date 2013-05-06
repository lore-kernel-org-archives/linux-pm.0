From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH 5/6] thermal: rcar: remove unnecessary platform_set_drvdata()
Date: Mon, 06 May 2013 13:30:58 +0900
Message-ID: <004201ce4a12$816b9060$8442b120$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:33414 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752461Ab3EFEbF (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 6 May 2013 00:31:05 -0400
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MMD0042B0J3HSL0@mailout1.samsung.com> for
 linux-pm@vger.kernel.org; Mon, 06 May 2013 13:30:58 +0900 (KST)
Content-language: ko
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: 'Zhang Rui' <rui.zhang@intel.com>
Cc: 'Eduardo Valentin' <eduardo.valentin@ti.com>, linux-pm@vger.kernel.org, Jingoo Han <jg1.han@samsung.com>, 'Kuninori Morimoto' <kuninori.morimoto.gx@renesas.com>

The driver core clears the driver data to NULL after device_release
or on probe failure, since commit 0998d0631001288a5974afc0b2a5f568bcdecb4d
(device-core: Ensure drvdata = NULL when no driver is bound).
Thus, it is not needed to manually clear the device driver data to NULL.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/thermal/rcar_thermal.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
index 8d7edd4..63c7c13 100644
--- a/drivers/thermal/rcar_thermal.c
+++ b/drivers/thermal/rcar_thermal.c
@@ -487,8 +487,6 @@ static int rcar_thermal_remove(struct platform_device *pdev)
 			rcar_thermal_irq_disable(priv);
 	}
 
-	platform_set_drvdata(pdev, NULL);
-
 	pm_runtime_put_sync(dev);
 	pm_runtime_disable(dev);
 
-- 
1.7.2.5


