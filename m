From: Luka Perkov <luka@openwrt.org>
Subject: [PATCH v2] thermal: Kconfig: cosmetic fixes
Date: Fri, 27 Sep 2013 20:20:33 +0200
Message-ID: <1380306033-20325-1-git-send-email-luka@openwrt.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from arrakis.dune.hu ([78.24.191.176]:37431 "EHLO arrakis.dune.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754125Ab3I0SVD (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 27 Sep 2013 14:21:03 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Luka Perkov <luka@openwrt.org>, Randy Dunlap <rdunlap@infradead.org>

Fix typo, finish sentence and add missing dots.

Signed-off-by: Luka Perkov <luka@openwrt.org>
CC: Randy Dunlap <rdunlap@infradead.org>
---
 drivers/thermal/Kconfig | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

v1 -> v2:
* address Randy's comment about unfinished sentence

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index dbfc390..3910b09 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -56,7 +56,7 @@ config THERMAL_DEFAULT_GOV_USER_SPACE
 	select THERMAL_GOV_USER_SPACE
 	help
 	  Select this if you want to let the user space manage the
-	  lpatform thermals.
+	  platform thermals.
 
 endchoice
 
@@ -69,6 +69,7 @@ config THERMAL_GOV_STEP_WISE
 	bool "Step_wise thermal governor"
 	help
 	  Enable this to manage platform thermals using a simple linear
+	  governor.
 
 config THERMAL_GOV_USER_SPACE
 	bool "User_space thermal governor"
@@ -117,14 +118,14 @@ config SPEAR_THERMAL
 	depends on OF
 	help
 	  Enable this to plug the SPEAr thermal sensor driver into the Linux
-	  thermal framework
+	  thermal framework.
 
 config RCAR_THERMAL
 	tristate "Renesas R-Car thermal driver"
 	depends on ARCH_SHMOBILE
 	help
 	  Enable this to plug the R-Car thermal sensor driver into the Linux
-	  thermal framework
+	  thermal framework.
 
 config KIRKWOOD_THERMAL
 	tristate "Temperature sensor on Marvell Kirkwood SoCs"
-- 
1.8.4
