From: Alex Shi <alex.shi@linaro.org>
Subject: [PATCH 16/19] thermal: rcar-thermal: Enable driver compilation with COMPILE_TEST
Date: Tue, 25 Mar 2014 18:49:29 +0800
Message-ID: <1395744572-20014-17-git-send-email-alex.shi@linaro.org>
References: <1395744572-20014-1-git-send-email-alex.shi@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pb0-f53.google.com ([209.85.160.53]:55283 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753055AbaCYKvi (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 25 Mar 2014 06:51:38 -0400
Received: by mail-pb0-f53.google.com with SMTP id rp16so275600pbb.40
        for <linux-pm@vger.kernel.org>; Tue, 25 Mar 2014 03:51:38 -0700 (PDT)
In-Reply-To: <1395744572-20014-1-git-send-email-alex.shi@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: mark.hambleton@broadcom.com, mark.brown@linaro.org, eduardo.valentin@ti.com, mporter@linaro.org, lsk-interest@linaro.org, linaro-kernel@linaro.org
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org, Alex Shi <alex.shi@linaro.org>

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

This helps increasing build testing coverage.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <eduardo.valentin@ti.com>
Cc: linux-pm@vger.kernel.org
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Simon Horman <horms@verge.net.au>
Acked-by: Eduardo Valentin <eduardo.valentin@ti.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
(cherry picked from commit beeb5a1e0ef774d0a3e18c5a0e78c39e3e1a5389)

Signed-off-by: Alex Shi <alex.shi@linaro.org>
---
 drivers/thermal/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index e92e1dc..92f44ec 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -124,7 +124,7 @@ config SPEAR_THERMAL
 
 config RCAR_THERMAL
 	tristate "Renesas R-Car thermal driver"
-	depends on ARCH_SHMOBILE
+	depends on ARCH_SHMOBILE || COMPILE_TEST
 	help
 	  Enable this to plug the R-Car thermal sensor driver into the Linux
 	  thermal framework
-- 
1.8.1.2

