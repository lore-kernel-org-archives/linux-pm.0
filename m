From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH] thermal: offer TI thermal support only when ARCH_OMAP2PLUS is
 defined
Date: Fri, 04 Oct 2013 14:35:19 +0200
Message-ID: <3702969.8rn3SOscJE@amdc1032>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:15412 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753131Ab3JDMfo (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 4 Oct 2013 08:35:44 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <eduardo.valentin@ti.com>, Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Kyungmin Park <kyungmin.park@samsung.com>

Menu for Texas Instruments thermal support is visible on all
platforms and TI_SOC_THERMAL + TI_THERMAL config options can
be selected also on EXYNOS platform (on which ARCH_HAS_BANDGAP
config option is selected by SoCs config options to fulfill
EXYNOS_THERMAL config option dependency). Thus the code which
is never used can be build. Fix it by making TI menu dependent
on ARCH_OMAP2PLUS config option.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/thermal/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 57e06a9..a709c63 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -193,6 +193,7 @@ config X86_PKG_TEMP_THERMAL
 	  notification methods.
 
 menu "Texas Instruments thermal drivers"
+depends on ARCH_OMAP2PLUS
 source "drivers/thermal/ti-soc-thermal/Kconfig"
 endmenu
 
-- 
1.8.2.3


