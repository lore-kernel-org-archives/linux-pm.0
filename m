From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH 2/6] thermal: dove: remove unnecessary platform_set_drvdata()
Date: Mon, 06 May 2013 13:27:14 +0900
Message-ID: <003f01ce4a11$fc1b9a90$f452cfb0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:45535 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752461Ab3EFE1Q (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 6 May 2013 00:27:16 -0400
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MMD004Q40DEK2E0@mailout4.samsung.com> for
 linux-pm@vger.kernel.org; Mon, 06 May 2013 13:27:14 +0900 (KST)
Content-language: ko
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: 'Zhang Rui' <rui.zhang@intel.com>
Cc: 'Eduardo Valentin' <eduardo.valentin@ti.com>, linux-pm@vger.kernel.org, Jingoo Han <jg1.han@samsung.com>, Andrew Lunn <andrew@lunn.ch>

The driver core clears the driver data to NULL after device_release
or on probe failure, since commit 0998d0631001288a5974afc0b2a5f568bcdecb4d
(device-core: Ensure drvdata = NULL when no driver is bound).
Thus, it is not needed to manually clear the device driver data to NULL.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/thermal/dove_thermal.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/thermal/dove_thermal.c b/drivers/thermal/dove_thermal.c
index 4b15a5f..900479e 100644
--- a/drivers/thermal/dove_thermal.c
+++ b/drivers/thermal/dove_thermal.c
@@ -182,7 +182,6 @@ static int dove_thermal_exit(struct platform_device *pdev)
 		platform_get_drvdata(pdev);
 
 	thermal_zone_device_unregister(dove_thermal);
-	platform_set_drvdata(pdev, NULL);
 
 	return 0;
 }
-- 
1.7.2.5


