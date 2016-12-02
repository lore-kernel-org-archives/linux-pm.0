From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH v4 5/4] thermal: rcar_gen3_thermal: restrict to 64BIT
Date: Fri,  2 Dec 2016 21:44:22 +0100
Message-ID: <20161202204422.21832-1-wsa+renesas@sang-engineering.com>
References: <20161201220442.22057-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from www.zeus03.de ([194.117.254.33]:58560 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751549AbcLBUoa (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 2 Dec 2016 15:44:30 -0500
In-Reply-To: <20161201220442.22057-1-wsa+renesas@sang-engineering.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Khiem Nguyen <khiem.nguyen.xt@renesas.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>

COMPILE_TEST triggers problems on 32 bit machines, so limit this driver
to 64BIT for now. This is no loss because the hardware is only available
on 64 bit SoCs anyhow. After we obtained more data from the hardware
engineers, we will refactor the code to be usable with COMPILE_TEST.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

buildbot reported the problem and seems to be happy now.

 drivers/thermal/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 3912d24a07b10f..edaed1282791bf 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -247,7 +247,7 @@ config RCAR_THERMAL
 
 config RCAR_GEN3_THERMAL
 	tristate "Renesas R-Car Gen3 thermal driver"
-	depends on ARCH_RENESAS || COMPILE_TEST
+	depends on ARCH_RENESAS && 64BIT
 	depends on HAS_IOMEM
 	depends on OF
 	help
-- 
2.10.2

