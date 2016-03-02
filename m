From: Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH] thermal: rcar: Use ARCH_RENESAS
Date: Wed,  2 Mar 2016 11:04:26 +0900
Message-ID: <1456884266-25522-1-git-send-email-horms+renesas@verge.net.au>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:54045 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754451AbcCBCEe (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 1 Mar 2016 21:04:34 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Magnus Damm <magnus.damm@gmail.com>, linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Simon Horman <horms+renesas@verge.net.au>

Make use of ARCH_RENESAS in place of ARCH_SHMOBILE.

This is part of an ongoing process to migrate from ARCH_SHMOBILE to
ARCH_RENESAS the motivation for which being that RENESAS seems to be a more
appropriate name than SHMOBILE for the majority of Renesas ARM based SoCs.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/thermal/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

 Based on linux-soc-thermal/next

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 5e7c97a3f1d8..9fc1afaa6879 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -214,7 +214,7 @@ config ROCKCHIP_THERMAL
 
 config RCAR_THERMAL
 	tristate "Renesas R-Car thermal driver"
-	depends on ARCH_SHMOBILE || COMPILE_TEST
+	depends on ARCH_RENESAS || COMPILE_TEST
 	depends on HAS_IOMEM
 	help
 	  Enable this to plug the R-Car thermal sensor driver into the Linux
-- 
2.1.4

