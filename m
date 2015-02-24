From: Lukasz Majewski <l.majewski@samsung.com>
Subject: [PATCH] MAINTAINERS: Add entry for SAMSUNG THERMAL DRIVER
Date: Tue, 24 Feb 2015 16:31:28 +0100
Message-ID: <1424791888-27796-1-git-send-email-l.majewski@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:45386 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752478AbbBXPbn (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 24 Feb 2015 10:31:43 -0500
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout2.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0NKA00FR08GTZ270@mailout2.samsung.com> for
 linux-pm@vger.kernel.org; Wed, 25 Feb 2015 00:31:42 +0900 (KST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Abhilash Kesavan <a.kesavan@samsung.com>, Lukasz Majewski <l.majewski@samsung.com>

This patch adds entry for SAMSUNG THERMAL DRIVER in the MAINTAINERS file.
It has been agreed, that pull request are going to be sent to Eduardo
Valentin.

Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ddc5a8c..be837a0d22 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8481,6 +8481,14 @@ S:	Supported
 L:	netdev@vger.kernel.org
 F:	drivers/net/ethernet/samsung/sxgbe/
 
+SAMSUNG THERMAL DRIVER
+M:	Lukasz Majewski <l.majewski@samsung.com>
+L:	linux-pm@vger.kernel.org
+L:	linux-samsung-soc@vger.kernel.org
+S:	Supported
+T:	https://github.com/lmajewski/linux-samsung-thermal.git
+F:	drivers/thermal/samsung/
+
 SAMSUNG USB2 PHY DRIVER
 M:	Kamil Debski <k.debski@samsung.com>
 L:	linux-kernel@vger.kernel.org
-- 
2.0.0.rc2

