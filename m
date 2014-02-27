From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH] thermal: ti-soc-thermal: Use SIMPLE_DEV_PM_OPS macro
Date: Thu, 27 Feb 2014 20:43:02 +0900
Message-ID: <000e01cf33b1$12277f00$36767d00$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:9855 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751200AbaB0LnD (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 27 Feb 2014 06:43:03 -0500
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N1N006YPKJQVL90@mailout1.samsung.com> for
 linux-pm@vger.kernel.org; Thu, 27 Feb 2014 20:43:02 +0900 (KST)
Content-language: ko
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: 'Zhang Rui' <rui.zhang@intel.com>
Cc: 'Eduardo Valentin' <eduardo.valentin@ti.com>, linux-pm@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>, 'Ranganath Krishnan' <ranganath@ti.com>

Use SIMPLE_DEV_PM_OPS macro in order to make the code simpler.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/thermal/ti-soc-thermal/ti-bandgap.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/ti-soc-thermal/ti-bandgap.c b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
index 74c0e34..3ab12ee 100644
--- a/drivers/thermal/ti-soc-thermal/ti-bandgap.c
+++ b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
@@ -1500,10 +1500,8 @@ static int ti_bandgap_resume(struct device *dev)
 
 	return ti_bandgap_restore_ctxt(bgp);
 }
-static const struct dev_pm_ops ti_bandgap_dev_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(ti_bandgap_suspend,
-				ti_bandgap_resume)
-};
+static SIMPLE_DEV_PM_OPS(ti_bandgap_dev_pm_ops, ti_bandgap_suspend,
+			 ti_bandgap_resume);
 
 #define DEV_PM_OPS	(&ti_bandgap_dev_pm_ops)
 #else
-- 
1.7.10.4


