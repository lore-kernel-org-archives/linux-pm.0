From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH 4/6] thermal: kirkwood: remove unnecessary
 platform_set_drvdata()
Date: Mon, 06 May 2013 13:30:09 +0900
Message-ID: <004101ce4a12$64bcbac0$2e363040$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:46014 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752461Ab3EFEaL (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 6 May 2013 00:30:11 -0400
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MMD000KY0I3HFH0@mailout4.samsung.com> for
 linux-pm@vger.kernel.org; Mon, 06 May 2013 13:30:10 +0900 (KST)
Content-language: ko
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: 'Zhang Rui' <rui.zhang@intel.com>
Cc: 'Eduardo Valentin' <eduardo.valentin@ti.com>, linux-pm@vger.kernel.org, Jingoo Han <jg1.han@samsung.com>, 'Nobuhiro Iwamatsu' <iwamatsu@nigauri.org>, 'Ezequiel Garcia' <ezequiel.garcia@free-electrons.com>

The driver core clears the driver data to NULL after device_release
or on probe failure, since commit 0998d0631001288a5974afc0b2a5f568bcdecb4d
(device-core: Ensure drvdata = NULL when no driver is bound).
Thus, it is not needed to manually clear the device driver data to NULL.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/thermal/kirkwood_thermal.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/thermal/kirkwood_thermal.c b/drivers/thermal/kirkwood_thermal.c
index dfeceaf..b57a45d 100644
--- a/drivers/thermal/kirkwood_thermal.c
+++ b/drivers/thermal/kirkwood_thermal.c
@@ -108,7 +108,6 @@ static int kirkwood_thermal_exit(struct platform_device *pdev)
 		platform_get_drvdata(pdev);
 
 	thermal_zone_device_unregister(kirkwood_thermal);
-	platform_set_drvdata(pdev, NULL);
 
 	return 0;
 }
-- 
1.7.2.5


