From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH 6/6] thermal: spear: remove unnecessary platform_set_drvdata()
Date: Mon, 06 May 2013 13:34:47 +0900
Message-ID: <004401ce4a13$0a2e3ec0$1e8abc40$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:34037 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750720Ab3EFEet (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 6 May 2013 00:34:49 -0400
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MMD0048D0PHHSL0@mailout1.samsung.com> for
 linux-pm@vger.kernel.org; Mon, 06 May 2013 13:34:48 +0900 (KST)
Content-language: ko
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: 'Zhang Rui' <rui.zhang@intel.com>
Cc: 'Eduardo Valentin' <eduardo.valentin@ti.com>, linux-pm@vger.kernel.org, Jingoo Han <jg1.han@samsung.com>, 'Vincenzo Frascino' <vincenzo.frascino@st.com>, 'Viresh Kumar' <viresh.linux@gmail.com>

The driver core clears the driver data to NULL after device_release
or on probe failure, since commit 0998d0631001288a5974afc0b2a5f568bcdecb4d
(device-core: Ensure drvdata = NULL when no driver is bound).
Thus, it is not needed to manually clear the device driver data to NULL.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/thermal/spear_thermal.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/thermal/spear_thermal.c b/drivers/thermal/spear_thermal.c
index 3c5ee56..1a14eaa 100644
--- a/drivers/thermal/spear_thermal.c
+++ b/drivers/thermal/spear_thermal.c
@@ -174,7 +174,6 @@ static int spear_thermal_exit(struct platform_device *pdev)
 	struct spear_thermal_dev *stdev = spear_thermal->devdata;
 
 	thermal_zone_device_unregister(spear_thermal);
-	platform_set_drvdata(pdev, NULL);
 
 	/* Disable SPEAr Thermal Sensor */
 	actual_mask = readl_relaxed(stdev->thermal_base);
-- 
1.7.2.5


