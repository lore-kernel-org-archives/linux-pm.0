From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH] thermal: fix Mediatek thermal controller build
Date: Thu, 14 Apr 2016 15:15:20 +0200
Message-ID: <1460639720-28180-1-git-send-email-johannes@sipsolutions.net>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:44218 "EHLO sipsolutions.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753394AbcDNNPc (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 14 Apr 2016 09:15:32 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Johannes Berg <johannes.berg@intel.com>

From: Johannes Berg <johannes.berg@intel.com>

At least with CONFIG_COMPILE_TEST, there's no reason to assume
that CONFIG_RESET_CONTROLLER is set, but the code for this
controller requires it since it calls device_reset().

Make CONFIG_MTK_THERMAL properly depend on CONFIG_RESET_CONTROLLER.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/thermal/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index c37eedc35a24..30079ef8b15c 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -376,6 +376,7 @@ config MTK_THERMAL
 	tristate "Temperature sensor driver for mediatek SoCs"
 	depends on ARCH_MEDIATEK || COMPILE_TEST
 	depends on HAS_IOMEM
+	depends on RESET_CONTROLLER
 	default y
 	help
 	  Enable this option if you want to have support for thermal management
-- 
2.7.0

